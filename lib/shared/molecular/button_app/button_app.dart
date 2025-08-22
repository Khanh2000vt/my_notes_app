import 'package:my_notes_app/core/design_system/exports.dart';

final class ButtonAppFilled extends ButtonCustom {
  const ButtonAppFilled({
    super.key,
    required super.label,
    super.disabled = false,
    super.icon,
    required super.onPressed,
    super.style,
  }) : super(variant: ButtonVariant.filled);
}

final class ButtonAppOutlined extends ButtonCustom {
  const ButtonAppOutlined({
    super.key,
    required super.label,
    super.disabled = false,
    super.icon,
    required super.onPressed,
    super.style,
  }) : super(variant: ButtonVariant.outlined);
}

final class ButtonAppElevated extends ButtonCustom {
  const ButtonAppElevated({
    super.key,
    required super.label,
    super.disabled = false,
    super.icon,
    required super.onPressed,
    super.style,
  }) : super(variant: ButtonVariant.elevated);
}

final class ButtonAppLink extends ButtonCustom {
  const ButtonAppLink({
    super.key,
    required super.label,
    super.disabled = false,
    super.icon,
    required super.onPressed,
    super.style,
  }) : super(variant: ButtonVariant.link);
}
