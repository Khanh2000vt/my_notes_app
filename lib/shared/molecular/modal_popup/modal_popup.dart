import 'package:flutter/cupertino.dart';

class ModalPopupApp {
  ModalPopupApp._();

  static Future<T?> _modalPopup<T>({
    required BuildContext ctx,
    required Widget Function(BuildContext context, Function(T value) onChanged)
    child,
    required T initValue,
  }) async {
    T selected = initValue;
    final result = await showCupertinoModalPopup<T>(
      context: ctx,
      builder: (context) => CupertinoPopupSurface(
        isSurfacePainted: true,
        child: Container(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          height: 250,
          child: Column(
            children: [
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
    final result = await _modalPopup<DateTime>(
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
}
