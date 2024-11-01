import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget diseaseDetailBottom(void Function()? path) {
  //void Function()? path;
  return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          Color(0xFFEEDA28),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(
                  color: Color(0xFF101010),
                  width: 80,
                ))),
      ),
      onPressed:path,
      child: Text(
        "🦠 Diseas Details",
        style: GoogleFonts.roboto(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
      ));
}
