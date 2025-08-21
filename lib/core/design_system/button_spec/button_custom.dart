import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'button_spec.dart';
import 'button_styles.dart';
import 'button_variants.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    super.key,
    required this.label,
    this.disabled = false,
    this.icon,
    required this.onPressed,
    this.variant = ButtonVariant.filled,
    this.style,
  });

  final String label;
  final bool disabled;
  final IconData? icon;
  final ButtonVariant variant;
  final VoidCallback? onPressed;
  final Style? style;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onPress: disabled ? null : onPressed,
      enabled: !disabled,
      child: SpecBuilder(
        // Styles will go here
        style: buttonStyle(style, variant),
        builder: (context) {
          final button = ButtonSpec.of(context);

          return button.container(
            child: button.flex(
              direction: Axis.horizontal,
              children: [
                if (icon != null) button.icon(icon),
                if (label.isNotEmpty) button.label(label),
              ],
            ),
          );
        },
      ),
    );
  }
}
