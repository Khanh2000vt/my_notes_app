import 'package:flutter/widgets.dart';

class Snapshot<T> {
  final T? data;
  final bool loading;
  final bool error;

  Snapshot({this.data, this.loading = false, this.error = false});
}

class FetchWidget<T> extends StatefulWidget {
  const FetchWidget({super.key, required this.future, required this.builder});

  final Future<T> future;
  final Widget Function(BuildContext context, Snapshot<T> snapshot) builder;

  @override
  State<FetchWidget<T>> createState() => _FetchWidgetState<T>();
}

class _FetchWidgetState<T> extends State<FetchWidget<T>> {
  T? data;
  bool loading = true;
  bool error = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        loading = true;
        error = false;
      });
      final res = await widget.future;
      setState(() {
        data = res;
        loading = false;
        error = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      Snapshot(data: data, loading: loading, error: error),
    );
  }
}
