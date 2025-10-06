import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData buildLightTheme() {
    const ColorScheme lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF2563EB),       // Blue-600
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFDBEAFE), // Blue-100
      onPrimaryContainer: Color(0xFF1E40AF), // Blue-800
      secondary: Color(0xFF475569),     // Slate-600
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFF1F5F9), // Slate-100
      onSecondaryContainer: Color(0xFF334155), // Slate-700
      tertiary: Color(0xFF7C3AED),      // Violet-600
      onTertiary: Colors.white,
      error: Color(0xFFDC2626),         // Red-600
      onError: Colors.white,
      background: Color(0xFFF8FAFC),    // Slate-50
      onBackground: Color(0xFF0F172A),  // Slate-900
      surface: Colors.white,
      onSurface: Color(0xFF0F172A),     // Slate-900
      surfaceVariant: Color(0xFFF1F5F9), // Slate-100
      onSurfaceVariant: Color(0xFF475569), // Slate-600
      outline: Color(0xFFE2E8F0),       // Slate-200
      shadow: Color(0xFF000000),
    );

    return ThemeData(
      brightness: Brightness.light,
      colorScheme: lightColorScheme,
      useMaterial3: true,
      
      // Scaffold
      scaffoldBackgroundColor: lightColorScheme.background,
      
      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: lightColorScheme.surface,
        foregroundColor: lightColorScheme.onSurface,
        elevation: 1,
        shadowColor: Colors.black12,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: lightColorScheme.onSurface,
        ),
        iconTheme: IconThemeData(color: lightColorScheme.onSurface),
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
      
      // Input Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightColorScheme.surface,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(color: lightColorScheme.onSurfaceVariant),
        hintStyle: TextStyle(color: lightColorScheme.onSurfaceVariant.withOpacity(0.6)),
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
          foregroundColor: lightColorScheme.primary,
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
      
      // Text Theme
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: lightColorScheme.onBackground,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: lightColorScheme.onBackground,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: lightColorScheme.onSurfaceVariant,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: lightColorScheme.onSurfaceVariant.withOpacity(0.8),
        ),
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
      primary: Color(0xFF60A5FA),       // Blue-400
      onPrimary: Color(0xFF0F172A),     // Slate-900
      primaryContainer: Color(0xFF1E3A8A), // Blue-900
      onPrimaryContainer: Color(0xFFDBEAFE), // Blue-100
      secondary: Color(0xFF94A3B8),     // Slate-400
      onSecondary: Color(0xFF0F172A),   // Slate-900
      secondaryContainer: Color(0xFF334155), // Slate-700
      onSecondaryContainer: Color(0xFFF1F5F9), // Slate-100
      tertiary: Color(0xFFA78BFA),      // Violet-400
      onTertiary: Color(0xFF0F172A),    // Slate-900
      error: Color(0xFFF87171),         // Red-400
      onError: Color(0xFF0F172A),       // Slate-900
      background: Color(0xFF0F172A),    // Slate-900
      onBackground: Color(0xFFF1F5F9),  // Slate-100
      surface: Color(0xFF1E293B),       // Slate-800
      onSurface: Color(0xFFF1F5F9),     // Slate-100
      surfaceVariant: Color(0xFF334155), // Slate-700
      onSurfaceVariant: Color(0xFFCBD5E1), // Slate-300
      outline: Color(0xFF475569),       // Slate-600
      shadow: Color(0xFF000000),
    );

    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: darkColorScheme,
      useMaterial3: true,
      
      // Scaffold
      scaffoldBackgroundColor: darkColorScheme.background,
      
      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: darkColorScheme.surface,
        foregroundColor: darkColorScheme.onSurface,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: darkColorScheme.onSurface,
        ),
        iconTheme: IconThemeData(color: darkColorScheme.onSurface),
      ),
      
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
      
      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
        shape: const CircleBorder(),
        elevation: 4,
      ),
      
      // Input Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkColorScheme.surfaceVariant,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(color: darkColorScheme.onSurfaceVariant),
        hintStyle: TextStyle(color: darkColorScheme.onSurfaceVariant.withOpacity(0.6)),
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
          foregroundColor: darkColorScheme.primary,
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
      
      // Text Theme
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkColorScheme.onBackground,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: darkColorScheme.onBackground,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: darkColorScheme.onSurfaceVariant,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: darkColorScheme.onSurfaceVariant.withOpacity(0.8),
        ),
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