import 'package:my_notes_app/core/design_system/exports.dart';

final class FilledButton extends ButtonCustom {
  const FilledButton({
    super.key,
    required super.label,
    super.disabled = false,
    super.icon,
    required super.onPressed,
    super.style,
  }) : super(variant: ButtonVariant.filled);
}

final class OutlinedButton extends ButtonCustom {
  const OutlinedButton({
    super.key,
    required super.label,
    super.disabled = false,
    super.icon,
    required super.onPressed,
    super.style,
  }) : super(variant: ButtonVariant.outlined);
}

final class ElevatedButton extends ButtonCustom {
  const ElevatedButton({
    super.key,
    required super.label,
    super.disabled = false,
    super.icon,
    required super.onPressed,
    super.style,
  }) : super(variant: ButtonVariant.elevated);
}

final class LinkButton extends ButtonCustom {
  const LinkButton({
    super.key,
    required super.label,
    super.disabled = false,
    super.icon,
    required super.onPressed,
    super.style,
  }) : super(variant: ButtonVariant.link);
}
