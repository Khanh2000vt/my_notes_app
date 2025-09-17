import 'package:flutter/cupertino.dart';

class ModalPopupApp {
  ModalPopupApp._();

  static Future<T?> modalPopup<T>({
    required BuildContext ctx,
    required T initValue,
    double height = 250,
    bool hideHeader = false,
    required Widget Function(BuildContext context, Function(T value) onChanged)
    child,
  }) async {
    T selected = initValue;
    final result = await showCupertinoModalPopup<T>(
      context: ctx,
      builder: (context) => CupertinoPopupSurface(
        isSurfacePainted: true,
        child: Container(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          height: height,
          child: Column(
            children: [
              if (!hideHeader)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: Text('Huỷ'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoButton(
                      child: Text('Chọn'),
                      onPressed: () {
                        Navigator.pop(context, selected);
                      },
                    ),
                  ],
                ),
              Expanded(
                child: child(context, (T value) {
                  selected = value;
                }),
              ),
            ],
          ),
        ),
      ),
    );
    return result;
  }

  static Future<void> date({
    required BuildContext context,
    required DateTime value,
    required void Function(DateTime value) onChanged,
    CupertinoDatePickerMode mode = CupertinoDatePickerMode.dateAndTime,
  }) async {
    final result = await modalPopup<DateTime>(
      ctx: context,
      initValue: value,
      child: (context, onDateTimeChanged) {
        return CupertinoDatePicker(
          mode: mode,
          initialDateTime: value,
          onDateTimeChanged: onDateTimeChanged,
        );
      },
    );
    if (result != null && result != value) {
      onChanged(result);
    }
  }

  static Future<void> select({
    required BuildContext context,
    required int value,
    required void Function(int value) onChanged,
    required List<Widget> items,
  }) async {
    final result = await modalPopup<int>(
      ctx: context,
      initValue: value,
      child: (context, onChangedSelect) {
        return CupertinoPicker(
          magnification: 1.22,
          looping: true,
          squeeze: 1.2,
          useMagnifier: true,
          itemExtent: 32,
          scrollController: FixedExtentScrollController(initialItem: value),
          onSelectedItemChanged: onChangedSelect,
          children: items,
        );
      },
    );
    if (result != null && result != value) {
      onChanged(result);
    }
  }
}
