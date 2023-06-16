import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

class ResponsiveSingleton {
  factory ResponsiveSingleton() {
    _instance ??= ResponsiveSingleton._();
    return _instance!;
  }

  ResponsiveSingleton._();

  static ResponsiveSingleton? _instance;

  static void init({required BuildContext context}) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    ip = math.sqrt(math.pow(width, 2) + math.pow(height, 2));
  }

  static late double width, height, ip;

  static double heightCustom(double value) {
    return height * value;
  }

  static double widthCustom(double value) {
    return width * value;
  }

  static double proportionalFont(double fontSize) {
    return (height * fontSize) / height;
  }

  static double proportionalWidth(double value) {
    return (width * value) / width;
  }

  static double propotionalHeight(double value) {
    return (height * value) / height;
  }
}
