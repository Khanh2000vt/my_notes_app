import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/features/room/room/widget/list_member_widget.dart';
import 'package:my_notes_app/helper/date_time_format.dart';
import 'package:my_notes_app/interface/expense.dart';
import 'package:my_notes_app/interface/room.dart';
import 'package:my_notes_app/routing/routes.dart';
import 'package:my_notes_app/services/expense.dart';
import 'package:my_notes_app/services/room.dart';
import 'package:my_notes_app/shared/atomic/avatar_widget/avatar_widget.dart';
import 'package:my_notes_app/shared/atomic/sticky_header_delegate/sticky_header_delegate.dart';
import 'package:my_notes_app/utils/string_handle.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final roomId = '027bd95f-e964-4589-98a7-981990fcc9d0';
  late Future<Room?> _futureRoom;
  late Future<List<Expense>?> _futureExpense;
  @override
  void initState() {
    super.initState();
    _futureRoom = RoomService().fetchRoomDetail(roomId);
    _futureExpense = ExpenseService().fetchExpensesDateTimeByRoomId(
      roomId,
      DateTime.now(),
    );
  }

  // void _refreshRoom() {
  //   setState(() {
  //     _futureRoom = RoomService().fetchRoomDetail(
  //       '027bd95f-e964-4589-98a7-981990fcc9d0',
  //     ); // future mới → FutureBuilder refetch
  //   });
  // }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _futureRoom = RoomService().fetchRoomDetail(roomId);
      _futureExpense = ExpenseService().fetchExpensesDateTimeByRoomId(
        roomId,
        DateTime.now(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: FutureBuilder<Room?>(
        future: _futureRoom,
        builder: (context, snapshot) {
          final loading = snapshot.connectionState == ConnectionState.waiting;
          final error = snapshot.hasError || !snapshot.hasData;
          final room = snapshot.data;
          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: <Widget>[
                    CupertinoSliverNavigationBar(
                      leading: CupertinoNavigationBarBackButton(
                        previousPageTitle: 'Trở lại',
                        onPressed: () {
                          context.pop();
                        },
                      ),
                      largeTitle: Text('Home'),
                      trailing: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(CupertinoIcons.add),
                        onPressed: () {
                          context.push(Routes.addExpense, extra: room?.members);
                        },
                      ),
                    ),
                    CupertinoSliverRefreshControl(onRefresh: _refresh),

                    SliverPersistentHeader(
                      pinned: true,
                      delegate: StickyHeaderDelegate(
                        minHeight: 60,
                        maxHeight: 100,
                        child: loading
                            ? CupertinoActivityIndicator()
                            : error
                            ? Center(child: Text("Không có data"))
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 4,
                                ),
                                color: CupertinoColors.systemBackground
                                    .resolveFrom(context),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              room!.name,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Tiền thuê: ${convertToCurrency(room.priceRoom.toString())}đ',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color:
                                                    CupertinoColors.systemGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        ListMemberWidget(members: room.members),
                                      ],
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: CupertinoColors.systemGrey
                                              .resolveFrom(context),
                                          width: 2,
                                        ),
                                      ),
                                      child: CupertinoButton.tinted(
                                        color: CupertinoColors
                                            .tertiarySystemBackground
                                            .resolveFrom(context),
                                        pressedOpacity: 0.9,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 6,
                                          horizontal: 12,
                                        ),
                                        foregroundColor: CupertinoColors.label
                                            .resolveFrom(context),

                                        child: Text('Tháng 09 năm 2025'),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    FutureBuilder<List<Expense>?>(
                      future: _futureExpense,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SliverToBoxAdapter(
                            child: Center(child: CupertinoActivityIndicator()),
                          );
                        }
                        if (snapshot.hasError ||
                            !snapshot.hasData ||
                            snapshot.data == null) {
                          return SliverToBoxAdapter(
                            child: Center(child: Text("Không có data")),
                          );
                        }
                        return SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final item = snapshot.data![index];
                            return CupertinoListTile(
                              title: Text(
                                item.name ?? '_',
                                maxLines: 1,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                DateTimeFormat.dateToDate(item.date),
                              ),
                              additionalInfo: Text(
                                '${convertToCurrency(item.amount.toString())}đ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CupertinoColors.systemRed,
                                  fontSize: 13,
                                ),
                              ),
                              trailing: CupertinoListTileChevron(),
                              leading: AvatarWidget(name: item.name ?? ''),
                              backgroundColor:
                                  (index % 2 == 0
                                          ? CupertinoColors
                                                .secondarySystemBackground
                                          : CupertinoColors.systemBackground)
                                      .resolveFrom(context),
                            );
                          }, childCount: snapshot.data?.length ?? 0),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: CupertinoButton.tinted(
                          pressedOpacity: 0.9,
                          child: Text('Tổng kết'),
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: CupertinoButton.filled(
                          pressedOpacity: 0.9,
                          child: Text('Thêm khoản chi'),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
