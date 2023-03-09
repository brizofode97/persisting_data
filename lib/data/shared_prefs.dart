import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SPSettings {
  final String fontSizeKey = 'font_size';
  final String colorKey = 'color';
  final String fontNameKey = 'font_name';
  static late SharedPreferences _sp;
  static SPSettings? _instance;

  SPSettings._internal();

  factory SPSettings() {
    _instance ??= SPSettings._internal();
    return _instance as SPSettings;
  }

  Future init() async {
    return _sp = await SharedPreferences.getInstance();
  }

  Future setColor(int color) {
    return _sp.setInt(colorKey, color);
  }

  int getColor() {
    return _sp.getInt(colorKey) ?? 0xFF1976d2;
  }

  Future setFontSize(double size) {
    return _sp.setDouble(fontSizeKey, size);
  }

  double getFontSize() {
    return _sp.getDouble(fontSizeKey) ?? 16;
  }

  Future setFontName(String name) {
    return _sp.setString(fontNameKey, name);
  }

  String getFontName() {
    return _sp.getString(fontNameKey) ?? 'no name';
  }
}
