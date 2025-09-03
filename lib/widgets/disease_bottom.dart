import 'package:flutter/material.dart';

Widget diseaseDetailBottom(void Function()? path) {
  return Align(
    alignment: Alignment.topLeft,
    child: IconButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            Color(0xFFEEDA28),
          ),
        ),
        onPressed: path,
        icon: Icon(Icons.info_outline, color: Color(0xFF101010), size: 28)),
  );
}
