import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:routing_app/core/singleton/responsive_singleton.dart';
import 'package:routing_app/widgets/custom_dialog_widget.dart';

class Utils {
  static T convertDynamicToType<T>(dynamic value, {required T defaultValue}) {
    //try to convert dynamic to type T
    try {
      return value as T;
    } catch (e) {
      //if is null add a default value
      if (value == null) {
        return defaultValue;
      }
      //if is not null and can't convert to type T return null
      return defaultValue;
    }
  }

  static String getFechaCorta(DateTime feEntrega) {
    return '${feEntrega.day}/${feEntrega.month}/${feEntrega.year}';
  }

  static void showdialog({
    required BuildContext context2,
    required bool success,
    required String mgs,
    required bool goBack,
  }) {
    showDialog(
      context: context2,
      builder: (context) {
        return CustomDialog(
          title: 'Atención',
          message: mgs,
          showCancel: false,
          type: success ? DialogType.success : DialogType.error,
          onPressedOK: () {
            Navigator.pop(context);
            if (goBack) {
              Navigator.pop(context);
            }
          },
          onPressedCancel: () => null,
        );
      },
    );
  }

  static Future<bool> handleLocationPermission(
      {required BuildContext context}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Los servicios de ubicación están deshabilitados, no podemos continuar')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Permisos de ubicación denegados')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Los permisos de ubicación están denegados permanentemente, no podemos solicitar permisos.'),
        ),
      );
      return false;
    }
    return true;
  }

  static String api_key = '';

  static void showSnackBar(
      {required BuildContext context,
      required String message,
      required type}) {}

  static Future<Uint8List> getBytesFromCanvas({
    required int width,
    required int height,
    required color,
    required String text,
  }) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = color;
    final Radius radius = Radius.circular(60.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        paint1);
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: ResponsiveSingleton.proportionalFont(30),
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
    painter.layout();
    painter.paint(
        canvas,
        Offset(width * 0.5 - painter.width * 0.5,
            height * 0.5 - painter.height * 0.5));
    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }
}

enum DialogType {
  error,
  success,
  warning,
  info,
}

extension StringUtils on String? {
  //function to validate isNullOrEmpty
  bool isNullOrEmpty() {
    return this == null || this?.isEmpty == true;
  }

  //function to validate isNotNullOrEmpty
  bool isNotNullOrEmpty() {
    return this != null && this?.isNotEmpty == true;
  }

  bool equalsIgnoreCase(String? other) {
    if (this == null && other == null) return true;
    if (this == null || other == null) return false;
    return this?.toLowerCase() == other.toLowerCase();
  }

  //to int
  int toInt() {
    return int.parse(this!);
  }

  double toDouble() {
    return double.parse(this!);
  }
}

extension objUtils on Object? {
  bool isNull() {
    return this == null;
  }

  bool isNotNull() {
    return this != null;
  }

  bool isNullOrEmpty() {
    return this == null || this.toString().isEmpty;
  }

  bool isNotNullOrEmpty() {
    return this != null && this.toString().isNotEmpty;
  }

  int toInt() {
    return int.parse(this.toString());
  }
}

extension DateTimeUtils on DateTime {
  String toshortString() {
    return '${this.year}-${this.month}-${this.day}';
  }
}
