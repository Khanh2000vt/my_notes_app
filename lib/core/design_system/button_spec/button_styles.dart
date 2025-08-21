import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:my_notes_app/core/styles/app_tokens.dart';

import 'button_spec.dart';
import 'button_variants.dart';

final _util = ButtonSpecUtility.self;
final _label = _util.label;
final _container = _util.container;
final _flex = _util.flex;
final _icon = _util.icon;

final _mdPrimary = $tokenMix.color.primary;
final _mdOnPrimary = $tokenMix.color.onPrimary;

Style get _baseStyle => Style(
  // Container
  _container.borderRadius.all.ref($tokenMix.radius.medium),
  _container.padding(8, 12),
  // Flex
  _flex.gap(8),
  _flex.mainAxisAlignment.center(),
  _flex.crossAxisAlignment.center(),
  _flex.mainAxisSize.min(),
  //Label
  _label.style.ref($tokenMix.textStyle.headline3),
  // Icon
  _icon.size(18),
);

Style get _filledStyle => Style(
  _container.color.ref(_mdPrimary),
  _label.style.color.ref(_mdOnPrimary),
  _icon.color.ref(_mdOnPrimary),
);

Style get _elevatedStyle => Style(
  _filledStyle,
  _container.shadow.offset(0, 5),
  _container.shadow.color.ref(_mdPrimary),
  _container.shadow.color.darken(20),
);

Style get _outlinedStyle => Style(
  _container.color.transparent(),
  _container.border.width(1.5),
  _container.border.color.ref(_mdPrimary),
  _label.style.color.ref(_mdPrimary),
  _icon.color.ref(_mdPrimary),
);

Style get _linkStyle => Style(
  _outlinedStyle,
  _container.border.style.none(),
  _container.color(Colors.transparent),
);

Style get _onDisabled => Style(
  _container.color.desaturate(100),
  _label.style.color.desaturate(100),
  _icon.color.desaturate(100),
  $with.opacity(0.5),
);

Style get _onHover => Style(
  _container.color.brighten(10),
  _label.style.color.brighten(10),
  _icon.color.brighten(10),
);

Style get _onPress => Style(
  _container.color.darken(10),
  _icon.color.darken(10),
  _label.style.color.darken(10),
  $with.scale(0.9),
);

Style buttonStyle(Style? style, ButtonVariant? variant) {
  return Style(
    // Base shared style
    _baseStyle,

    // Button Variants
    ButtonVariant.filled(_filledStyle),
    ButtonVariant.outlined(_outlinedStyle),
    ButtonVariant.elevated(_elevatedStyle),
    ButtonVariant.link(_linkStyle),

    // Widget state variants
    $on.disabled(_onDisabled),
    $on.hover(_onHover),
    $on.press(_onPress),

    // Merge style if a style is provided
    // Apply variant
  ).merge(style).applyVariant(variant);
}
