import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/features/expense/model/expense_model.dart';
import 'package:my_notes_app/features/room/widget/header_sticky_widget.dart';
import 'package:my_notes_app/features/room/widget/list_expense_widget.dart';
import 'package:my_notes_app/interface/expense_room.dart';
import 'package:my_notes_app/interface/room.dart';
import 'package:my_notes_app/routing/routes.dart';
import 'package:my_notes_app/services/expense.dart';
import 'package:my_notes_app/services/room.dart';
import 'package:my_notes_app/shared/atomic/sticky_header_delegate/sticky_header_delegate.dart';

import 'widget/navigation_bar_widget.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final roomId = 1;
  late Future<Room?> _futureRoom;
  late Future<List<ExpenseRoom>?> _futureExpense;
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    _futureRoom = RoomService().fetchRoomDetail(roomId);
    _futureExpense = ExpenseService().fetchExpensesDateTimeByRoomId(
      roomId,
      selectedDate,
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _futureRoom = RoomService().fetchRoomDetail(roomId);
      _futureExpense = ExpenseService().fetchExpensesDateTimeByRoomId(
        roomId,
        selectedDate,
      );
    });
  }

  void _onTapExpense(ExpenseModel model) {
    context.push(Routes.expense, extra: model).then((v) {
      setState(() {
        _futureExpense = ExpenseService().fetchExpensesDateTimeByRoomId(
          roomId,
          selectedDate,
        );
      });
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
          return CustomScrollView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: <Widget>[
              NavigationBarWidget(
                members: room?.members,
                onAdd: () => _onTapExpense(
                  ExpenseModel(members: room?.members ?? [], expense: null),
                ),
              ),
              CupertinoSliverRefreshControl(onRefresh: _refresh),

              SliverPersistentHeader(
                pinned: true,
                delegate: StickyHeaderDelegate(
                  minHeight: 100,
                  maxHeight: 100,
                  child: loading
                      ? CupertinoActivityIndicator()
                      : error
                      ? Center(child: Text("Không có data"))
                      : HeaderStickyWidget(
                          room: room,
                          selectedDate: selectedDate,
                          onSelectedDate: (date) {
                            setState(() {
                              selectedDate = date;
                              _futureExpense = ExpenseService()
                                  .fetchExpensesDateTimeByRoomId(
                                    roomId,
                                    selectedDate,
                                  );
                            });
                          },
                        ),
                ),
              ),
              if (room != null)
                ListExpenseWidget(
                  futureExpense: _futureExpense,
                  onTapExpense: (expenseRoom) => _onTapExpense(
                    ExpenseModel(members: room.members, expense: expenseRoom),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
