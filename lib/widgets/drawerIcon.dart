import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget detailsIconBottom(void Function()? path) {
  return Align(
    alignment: Alignment.topLeft,
    child: IconButton(
        onPressed: path,
        icon: Icon(
          FontAwesomeIcons.circleInfo, 
          color: Colors.black, 
          size:30)),
  );
}
