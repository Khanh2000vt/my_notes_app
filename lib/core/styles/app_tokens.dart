import 'package:mix/mix.dart';

const $tokenMix = MyThemeToken();

class MyThemeToken {
  const MyThemeToken();

  final color = const MyThemeColorToken();
  final textStyle = const MyThemeTextStyleToken();
  final space = const MyThemeSpaceToken();
  final radius = const MyThemeRadiusToken();
  final breakpoint = const MyThemeBreakpointToken();
}

class MyThemeColorToken {
  const MyThemeColorToken();

  ColorToken get primary => const ColorToken('primary-color');
  ColorToken get onPrimary => const ColorToken('on-primary-color');
  ColorToken get surface => const ColorToken('surface-color');
  ColorToken get onSurface => const ColorToken('on-surface-color');
  ColorToken get onSurfaceVariant =>
      const ColorToken('on-surface-variant-color');
}

class MyThemeTextStyleToken {
  const MyThemeTextStyleToken();

  TextStyleToken get headline1 => const TextStyleToken('headline1');
  TextStyleToken get headline2 => const TextStyleToken('headline2');
  TextStyleToken get headline3 => const TextStyleToken('headline3');
  TextStyleToken get body => const TextStyleToken('body');
  TextStyleToken get callout => const TextStyleToken('callout');
}

class MyThemeSpaceToken {
  const MyThemeSpaceToken();

  SpaceToken get small => const SpaceToken('small-space');
  SpaceToken get medium => const SpaceToken('medium-space');
  SpaceToken get large => const SpaceToken('large-space');
}

class MyThemeRadiusToken {
  const MyThemeRadiusToken();

  RadiusToken get small => const RadiusToken('small-radius');
  RadiusToken get medium => const RadiusToken('medium-radius');
  RadiusToken get large => const RadiusToken('large-radius');
}

class MyThemeBreakpointToken {
  const MyThemeBreakpointToken();

  BreakpointToken get mobile => const BreakpointToken('mobile-breakpoint');
  BreakpointToken get tablet => const BreakpointToken('tablet-breakpoint');
  BreakpointToken get desktop => const BreakpointToken('desktop-breakpoint');
}
