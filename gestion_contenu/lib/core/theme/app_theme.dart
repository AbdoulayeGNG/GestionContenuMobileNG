import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData buildLightTheme() {
    const ColorScheme lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Colors.white, // Blue-600
      onPrimary: Colors.black,
      primaryContainer: Color(0xFFDBEAFE), // Blue-100
      onPrimaryContainer: Color(0xFF1E40AF), // Blue-800
      secondary: Color(0xFF475569), // Slate-600
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFF1F5F9), // Slate-100
      onSecondaryContainer: Color(0xFF334155), // Slate-700
      tertiary: Color(0xFF7C3AED), // Violet-600
      onTertiary: Colors.white,
      error: Color(0xFFDC2626), // Red-600
      onError: Colors.white,
      background: Colors.white, // Fond blanc
      onBackground: Colors.black, // Texte NOIR sur fond clair
      surface: Color(0xFFF8FAFC), // Slate-50
      onSurface: Colors.black, // Texte NOIR sur surface
      surfaceVariant: Color(0xFFF1F5F9), // Slate-100
      onSurfaceVariant: Colors.black87, // Texte NOIR sur surface variant
      outline: Color(0xFFE2E8F0), // Slate-200
      shadow: Color(0xFF000000),
    );

    return ThemeData(
      brightness: Brightness.light,
      colorScheme: lightColorScheme,
      useMaterial3: true,

      // Scaffold - Fond blanc
      scaffoldBackgroundColor: Colors.white,

      // AppBar - Fond clair avec texte noir
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // Texte NOIR
        elevation: 1,
        shadowColor: Colors.black12,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black, // Titre NOIR
        ),
        iconTheme: IconThemeData(color: Colors.black), // Icônes NOIRES
      ),

      // Cards
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: lightColorScheme.shadow.withOpacity(0.1),
        color: lightColorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.zero,
      ),

      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
      ),

      // Input Fields - Texte noir
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color.fromARGB(82, 158, 158, 158),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightColorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightColorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightColorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightColorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightColorScheme.error, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(color: Colors.black87), // Label NOIR
        hintStyle: TextStyle(color: Colors.black54), // Hint NOIR
        floatingLabelStyle: TextStyle(color: lightColorScheme.primary),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightColorScheme.primary,
          foregroundColor: lightColorScheme.onPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: lightColorScheme.primary, // Texte bleu
          side: BorderSide(color: lightColorScheme.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      // Text Theme - TOUT EN NOIR
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.black54,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),

      // Icons - Icônes noires
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color: lightColorScheme.outline.withOpacity(0.5),
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ThemeData buildDarkTheme() {
    const ColorScheme darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.black, // Blue-400
      onPrimary: Colors.white, // Texte BLANC sur primary
      primaryContainer: Color(0xFF1E3A8A), // Blue-900
      onPrimaryContainer: Colors.white, // Texte BLANC sur primary container
      secondary: Color(0xFF94A3B8), // Slate-400
      onSecondary: Colors.white, // Texte BLANC sur secondary
      secondaryContainer: Color(0xFF334155), // Slate-700
      onSecondaryContainer: Colors.white, // Texte BLANC
      tertiary: Color(0xFFA78BFA), // Violet-400
      onTertiary: Colors.white, // Texte BLANC sur tertiary
      error: Color(0xFFF87171), // Red-400
      onError: Colors.white, // Texte BLANC sur error
      background: Color(0xFF0F172A), // Slate-900 (fond sombre)
      onBackground: Colors.white, // Texte BLANC sur fond sombre
      surface: Color(0xFF1E293B), // Slate-800
      onSurface: Colors.white, // Texte BLANC sur surface
      surfaceVariant: Color(0xFF334155), // Slate-700
      onSurfaceVariant: Colors.white70, // Texte BLANC sur surface variant
      outline: Color(0xFF475569), // Slate-600
      shadow: Color(0xFF000000),
    );

    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: darkColorScheme,
      useMaterial3: true,

      // Scaffold - Fond sombre
      scaffoldBackgroundColor: Colors.black,

      // AppBar - Fond sombre avec texte blanc
      appBarTheme: AppBarTheme(
        backgroundColor: const Color.fromARGB(186, 2, 10, 16),
        foregroundColor: Colors.white, // Texte BLANC
        elevation: 2,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white, // Titre BLANC
        ),
        iconTheme: IconThemeData(color: Colors.white), // Icônes BLANCHES
      ),

      drawerTheme: DrawerThemeData(backgroundColor: Colors.black),

      // Cards
      cardTheme: CardThemeData(
        elevation: 3,
        shadowColor: darkColorScheme.shadow.withOpacity(0.3),
        color: darkColorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.zero,
      ),

      switchTheme: SwitchThemeData(
        trackColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.blue.withOpacity(.48);
          }
          return Colors.orange;
        }),
      ),

      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
        shape: const CircleBorder(),
        elevation: 4,
      ),

      // Input Fields - Texte blanc
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkColorScheme.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkColorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkColorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkColorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkColorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkColorScheme.error, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(color: Colors.white70), // Label BLANC
        hintStyle: TextStyle(color: Colors.white54), // Hint BLANC
        floatingLabelStyle: TextStyle(color: darkColorScheme.primary),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkColorScheme.primary,
          foregroundColor: darkColorScheme.onPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkColorScheme.primary, // Texte bleu clair
          side: BorderSide(color: darkColorScheme.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      // Text Theme - TOUT EN BLANC
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white70,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.white60,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white70,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.white60,
        ),
      ),

      // Icons - Icônes blanches
      iconTheme: IconThemeData(
        color: Colors.white70,
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color: darkColorScheme.outline.withOpacity(0.5),
        thickness: 1,
        space: 1,
      ),
    );
  }
}
