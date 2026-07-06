import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ─── Brand Palette ─────────────────────────────────────────────────────────
  static const Color primary   = Color(0xFFFF5F8F); // Soft Rose Pink
  static const Color secondary = Color(0xFFB388FF); // Lavender
  static const Color accent    = Color(0xFFFF7F6B); // Coral
  static const Color success   = Color(0xFF4CAF50); // Green

  // ─── Backgrounds ───────────────────────────────────────────────────────────
  static const Color bgWarm    = Color(0xFFFFFDFB); // Warm White
  static const Color bgLight   = Color(0xFFF8F4FF); // Soft lavender tint
  static const Color cardWhite = Color(0xFFFFFFFF);

  // ─── Text ──────────────────────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFF222222);
  static const Color textSecondary = Color(0xFF777777);
  static const Color textMuted     = Color(0xFFBBBBBB);

  // ─── Geometry ──────────────────────────────────────────────────────────────
  static const double radius   = 24.0;
  static const double radiusSm = 14.0;
  static const double radiusLg = 32.0;

  static final BorderRadius rounded   = BorderRadius.circular(radius);
  static final BorderRadius roundedSm = BorderRadius.circular(radiusSm);
  static final BorderRadius roundedLg = BorderRadius.circular(radiusLg);

  // ─── Shadows ───────────────────────────────────────────────────────────────
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: primary.withValues(alpha: 0.08),
      blurRadius: 24,
      spreadRadius: 0,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 8,
      spreadRadius: 0,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 6),
    ),
  ];

  // ─── Theme ─────────────────────────────────────────────────────────────────
  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      primaryColor: primary,
      scaffoldBackgroundColor: bgWarm,
      colorScheme: const ColorScheme.light(
        primary:   primary,
        secondary: secondary,
        tertiary:  accent,
        surface:   cardWhite,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimary,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,
          color: textPrimary,
          fontSize: 28,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: textPrimary,
          fontSize: 20,
        ),
        titleLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: textPrimary,
          fontSize: 16,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          color: textPrimary,
          fontSize: 14,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          color: textSecondary,
          fontSize: 13,
        ),
        labelSmall: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: textMuted,
          fontSize: 10,
          letterSpacing: 0.8,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardWhite,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: rounded),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: bgWarm,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: textPrimary),
        titleTextStyle: GoogleFonts.poppins(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardWhite,
        selectedItemColor: primary,
        unselectedItemColor: textMuted,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: bgLight,
        border: OutlineInputBorder(
          borderRadius: rounded,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: rounded,
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        hintStyle: GoogleFonts.poppins(color: textMuted, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: rounded),
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: bgLight,
        selectedColor: primary.withValues(alpha: 0.12),
        labelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: primary,
        inactiveTrackColor: primary.withValues(alpha: 0.15),
        thumbColor: primary,
        overlayColor: primary.withValues(alpha: 0.12),
      ),
    );
  }

  // ─── Glassmorphic Card Decoration ──────────────────────────────────────────
  /// Light frosted glass — for soft overlay cards
  static BoxDecoration glassDecoration({
    BorderRadius? radius,
    Color? tint,
  }) {
    return BoxDecoration(
      color: (tint ?? Colors.white).withValues(alpha: 0.75),
      borderRadius: radius ?? rounded,
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.6),
        width: 1.5,
      ),
      boxShadow: cardShadow,
    );
  }

  /// Rose-tinted glass — for accent cards
  static BoxDecoration roseGlassDecoration({BorderRadius? radius}) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          primary.withValues(alpha: 0.08),
          secondary.withValues(alpha: 0.06),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: radius ?? rounded,
      border: Border.all(
        color: primary.withValues(alpha: 0.15),
        width: 1.2,
      ),
      boxShadow: softShadow,
    );
  }

  /// Solid card — white card with soft shadow
  static BoxDecoration solidCard({BorderRadius? radius}) {
    return BoxDecoration(
      color: cardWhite,
      borderRadius: radius ?? rounded,
      boxShadow: cardShadow,
    );
  }

  // ─── Gradient helpers ──────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFFFF8FB0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient lavenderGradient = LinearGradient(
    colors: [secondary, Color(0xFFCFB4FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warmGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

