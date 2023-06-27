import 'package:flutter/material.dart';
import 'package:routing_app/core/utils/utils.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.onPressedOK,
    required this.onPressedCancel,
    required this.showCancel,
    required this.title,
    required this.message,
    required this.type,
  });

  final VoidCallback onPressedOK;
  final VoidCallback onPressedCancel;
  final bool showCancel;
  final String title;
  final String message;
  final DialogType type;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(color: Colors.black)),
      content: Row(
        children: [
          if (type == DialogType.error)
            Icon(
              Icons.error,
              color: Colors.red,
              size: 40,
            ),
          if (type == DialogType.success)
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 40,
            ),
          if (type == DialogType.warning)
            Icon(
              Icons.warning,
              color: Colors.orange,
              size: 40,
            ),
          if (type == DialogType.info)
            Icon(
              Icons.info,
              color: Colors.blue,
              size: 40,
            ),
          SizedBox(width: 10),
          Expanded(child: Text(message, style: TextStyle(color: Colors.black))),
        ],
      ),
      actions: [
        if (showCancel)
          TextButton(
            onPressed: onPressedCancel,
            child: Text('Cancelar'),
          ),
        TextButton(
          onPressed: onPressedOK,
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}
