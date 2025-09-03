import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

fontSmall(
  { double? size, 
    required color, 
    FontWeight? fontWeight}) {
  return GoogleFonts.robotoSerif(
    fontSize: 14, 
    color: color, 
    fontWeight: fontWeight);
}

fontLarg(
  { double? size, 
    required color, 
    FontWeight? fontWeight}) {
  return GoogleFonts.robotoSerif(
    fontSize: 18, 
    color: color, 
    fontWeight: fontWeight
  );
}
