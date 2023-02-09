import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

abstract class ColorScheme {
  Color primaryColor();
  Color secondaryColor();
  Color backgroundColor();
}

class LightColorScheme implements ColorScheme {
  @override
  Color primaryColor() => Colors.blue;

  @override
  Color secondaryColor() => Colors.blue[50];

  @override
  Color backgroundColor() => Colors.white;
}

class DarkColorScheme implements ColorScheme {
  @override
  Color primaryColor() => Colors.blue[900];

  @override
  Color secondaryColor() => Colors.blue[800];

  @override
  Color backgroundColor() => Colors.black;
}


class AppThemeManager {
  static AppThemeManager _appThemeManager;

  static AppThemeManager getColor(BuildContext context) {
    final theme = Theme.of(context);
    if (_appThemeManager == null ||
        (theme.brightness == Brightness.light &&
            (_appThemeManager is! AppThemeManager)) ||
        (theme.brightness == Brightness.dark &&
            (_appThemeManager is! DarkColorScheme))) {
      _appThemeManager = theme.brightness == Brightness.light
          ? LightColorScheme()
          : DarkColorScheme();
    }
    return _appThemeManager;
  }
}