import 'package:flutter/material.dart';

class ControlMainScreen{
  static info(){
    final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
    return ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                          color: Color(0xFF101010),
                          width:80,
                        )
                       )
                      ),
              ),
              onPressed: () {
                _scaffoldkey.currentState!.openDrawer();
              },
              child: Text(
                "🦠 info",
                style:TextStyle(
                  fontSize: 20,
                  color: Colors.white,    
                )
              ));
  }
}