import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:mix/mix.dart';
import '../core/styles/app_tokens.dart';

final lightBlueTheme = MixThemeData(
  colors: {
    $tokenMix.color.primary: const Color(0xFF0093B9),
    $tokenMix.color.onPrimary: const Color(0xFFFAFAFA),
    $tokenMix.color.surface: const Color(0xFFFAFAFA),
    $tokenMix.color.onSurface: const Color(0xFF141C24),
    $tokenMix.color.onSurfaceVariant: const Color(0xFF405473),
  },
  textStyles: {
    $tokenMix.textStyle.headline1: GoogleFonts.plusJakartaSans(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFFAFAFA),
    ),
    $tokenMix.textStyle.headline2: GoogleFonts.plusJakartaSans(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFFAFAFA),
    ),
    $tokenMix.textStyle.headline3: GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    $tokenMix.textStyle.body: GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    $tokenMix.textStyle.callout: GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
  },
  radii: {
    $tokenMix.radius.large: const Radius.circular(100),
    $tokenMix.radius.medium: const Radius.circular(12),
    $tokenMix.radius.small: const Radius.circular(8),
  },
  spaces: {
    $tokenMix.space.medium: 16,
    $tokenMix.space.large: 24,
    $tokenMix.space.small: 8,
  },
  breakpoints: {
    $tokenMix.breakpoint.mobile: const Breakpoint(minWidth: 0, maxWidth: 600),
    $tokenMix.breakpoint.tablet: const Breakpoint(
      minWidth: 600,
      maxWidth: 1200,
    ),
    $tokenMix.breakpoint.desktop: const Breakpoint(
      minWidth: 1200,
      maxWidth: double.infinity,
    ),
  },
);

final darkPurpleTheme = MixThemeData(
  colors: {
    $tokenMix.color.primary: const Color(0xFF617AFA),
    $tokenMix.color.onPrimary: const Color(0xFFFAFAFA),
    $tokenMix.color.surface: const Color(0xFF1C1C21),
    $tokenMix.color.onSurface: const Color(0xFFFAFAFA),
    $tokenMix.color.onSurfaceVariant: const Color(0xFFD6D6DE),
  },
  textStyles: {
    $tokenMix.textStyle.headline1: GoogleFonts.spaceGrotesk(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    $tokenMix.textStyle.headline2: GoogleFonts.spaceGrotesk(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    $tokenMix.textStyle.headline3: GoogleFonts.spaceGrotesk(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    $tokenMix.textStyle.body: GoogleFonts.spaceGrotesk(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    $tokenMix.textStyle.callout: GoogleFonts.spaceGrotesk(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
  },
  radii: {
    $tokenMix.radius.large: const Radius.circular(100),
    $tokenMix.radius.medium: const Radius.circular(12),
    $tokenMix.radius.small: const Radius.circular(8),
  },
  spaces: {
    $tokenMix.space.medium: 16,
    $tokenMix.space.large: 24,
    $tokenMix.space.small: 8,
  },
  breakpoints: {
    $tokenMix.breakpoint.mobile: const Breakpoint(minWidth: 0, maxWidth: 600),
    $tokenMix.breakpoint.tablet: const Breakpoint(
      minWidth: 600,
      maxWidth: 1200,
    ),
    $tokenMix.breakpoint.desktop: const Breakpoint(
      minWidth: 1200,
      maxWidth: double.infinity,
    ),
  },
);
