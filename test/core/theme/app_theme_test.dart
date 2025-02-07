import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voyagevue/app/constants/theme_constant.dart';
import 'package:voyagevue/core/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    test('should return light theme when isDarkMode is false', () {
      final themeData = AppTheme.getApplicationTheme(isDarkMode: false);

      expect(themeData.brightness, Brightness.light);
      expect(themeData.colorScheme.primary, const Color.fromARGB(255, 17, 119, 20));
      expect(themeData.useMaterial3, true);
      expect(themeData.bottomNavigationBarTheme.backgroundColor, const Color.fromARGB(255, 82, 136, 211));
    });

    test('should return dark theme when isDarkMode is true', () {
      final themeData = AppTheme.getApplicationTheme(isDarkMode: true);

      expect(themeData.brightness, Brightness.dark);
      expect(themeData.colorScheme.primary, ThemeConstant.darkPrimaryColor);
      expect(themeData.useMaterial3, true);
      expect(themeData.bottomNavigationBarTheme.backgroundColor, const Color.fromARGB(255, 82, 136, 211));
    });

    test('should have correct input decoration theme', () {
      final themeDataLight = AppTheme.getApplicationTheme(isDarkMode: false);
      final themeDataDark = AppTheme.getApplicationTheme(isDarkMode: true);

      final inputThemeLight = themeDataLight.inputDecorationTheme;
      final inputThemeDark = themeDataDark.inputDecorationTheme;

      // Light theme input decorations
      expect(inputThemeLight.contentPadding, const EdgeInsets.all(15));
      expect(inputThemeLight.border, isA<OutlineInputBorder>());
      expect(inputThemeLight.errorBorder?.borderSide.color, Colors.red);

      // Dark theme input decorations (optional, if different)
      expect(inputThemeDark.contentPadding, const EdgeInsets.all(15));
      expect(inputThemeDark.border, isA<OutlineInputBorder>());
      expect(inputThemeDark.errorBorder?.borderSide.color, Colors.red);
    });
  });
}
