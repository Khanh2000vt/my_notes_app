import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/features/summary/widget/check_widget.dart';
import 'package:my_notes_app/features/summary/widget/config_export_widget.dart';
import 'package:my_notes_app/helper/date_time_format.dart';
import 'package:my_notes_app/interface/expense_summary.dart';
import 'package:my_notes_app/services/expense.dart';
import 'package:my_notes_app/services/qr.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  DateTime selectedDate = DateTime.now();
  ExpenseSummary summary = ExpenseSummary(
    byCategory: [],
    expenseMember: [],
    total: 0,
  );
  bool fetching = true;
  bool loading = false;
  bool group = false;
  List<ExpenseMember> members = [];
  Uint8List? capturedImage;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      setState(() {
        fetching = true;
        capturedImage = null;
      });
      final res = await ExpenseService().fetchRoomExpenseSummary(
        selectedDate,
        1,
      );
      setState(() {
        summary = res;
        members = summary.expenseMember;
        fetching = false;
      });
    } catch (e) {
      setState(() {
        summary = ExpenseSummary(byCategory: [], expenseMember: [], total: 0);
        fetching = false;
        members = [];
      });
    }
  }

  Future<void> _onPickerMember(BuildContext ctx) async {
    final result = await showCupertinoModalPopup(
      context: ctx,
      builder: (context) => ConfigExportWidget(
        expenseMember: summary.expenseMember,
        context: context,
        group: group,
        members: members,
        selectedDate: selectedDate,
      ),
    );
    if (result != null) {
      setState(() {
        group = result['group'] as bool;
        members = result['members'] as List<ExpenseMember>;
        selectedDate = result['selectedDate'] as DateTime;
        capturedImage = null;
      });
    }
  }

  Widget buildImageWidget({
    String? qrDataURL,
    required num amountByMember,
    required Size size,
  }) {
    final mediaQueryData = MediaQueryData(size: size);
    return MediaQuery(
      data: mediaQueryData,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(height: 16),
            Text(
              'BẢNG KÊ CHI TIÊU',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.black,
              ),
            ),
            Text(
              DateTimeFormat.formatMonthYear(selectedDate),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.activeBlue,
              ),
            ),
            CheckWidget(
              summary: summary,
              amountByMember: amountByMember,
              group: group,
              members: members,
            ),
            if (qrDataURL != null) ...[
              SizedBox(height: 20),
              Image.memory(
                base64Decode(qrDataURL.split(",").last),
                height: 120,
                width: 120,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> captureWidget({
    required num sum,
    bool? isShare,
    required Size size,
  }) async {
    if (capturedImage != null) {
      shareCapture();
      return;
    }
    try {
      setState(() {
        loading = true;
      });
      final nameMember = group
          ? members.fold<String>('', (previousValue, element) {
              return '$previousValue ${element.name}';
            })
          : '';
      final qrDataURL = await QRService.generateQRData(
        amount: group ? sum : null,
        note:
            '$nameMember gui tien phong ${DateTimeFormat.formatMonthYear(selectedDate)}',
      );
      final Uint8List image = await screenshotController.captureFromWidget(
        buildImageWidget(qrDataURL: qrDataURL, amountByMember: sum, size: size),
      );
      setState(() {
        capturedImage = image;
      });
      shareCapture();
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> shareCapture() async {
    if (capturedImage != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
      await imagePath.writeAsBytes(capturedImage!);

      /// Share Plugin
      final params = ShareParams(files: [XFile(imagePath.path)]);
      await SharePlus.instance.share(params);
      if (await imagePath.exists()) {
        await imagePath.delete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final amountByMember = members.fold<num>(
      0,
      (previousValue, element) =>
          previousValue + (element.own == true ? 0 : element.amount),
    );
    final size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Tổng kết'),
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: 'Trở lại',
          onPressed: () {
            context.pop();
          },
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.ellipsis_vertical_circle),
          onPressed: () {
            _onPickerMember(context);
          },
        ),
      ),
      child: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Text(
                  DateTimeFormat.formatMonthYear(selectedDate),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.activeBlue,
                  ),
                ),
                Expanded(
                  child: fetching
                      ? CupertinoActivityIndicator()
                      : SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: CheckWidget(
                            summary: summary,
                            amountByMember: amountByMember,
                            group: group,
                            members: members,
                          ),
                        ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    spacing: 12,
                    children: [
                      CupertinoButton.tinted(
                        onPressed: fetching
                            ? null
                            : () {
                                captureWidget(sum: amountByMember, size: size);
                              },
                        child: Row(
                          spacing: 10,
                          children: [
                            Icon(CupertinoIcons.down_arrow),
                            Text('Lưu ảnh'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: CupertinoButton.filled(
                          onPressed: fetching
                              ? null
                              : () {
                                  captureWidget(
                                    sum: amountByMember,
                                    size: size,
                                    isShare: true,
                                  );
                                },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 16,
                            children: [
                              Icon(CupertinoIcons.share),
                              Text('Chia sẻ'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (loading)
            Container(
              color: CupertinoColors.black.withOpacity(0.5),
              child: const Center(
                child: CupertinoActivityIndicator(
                  radius: 18,
                  color: CupertinoColors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
