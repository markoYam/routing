import 'package:flutter/material.dart';
import 'package:routing_app/core/singleton/responsive_singleton.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.hintText,
    this.onPressed,
  });

  final String hintText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveSingleton.ip * 0.3,
      height: ResponsiveSingleton.ip * 0.06,
      child: FilledButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(hintText, style: TextStyle(fontSize: 17)),
      ),
    );
  }
}
