import 'package:baganbilash/Controllers/style_fonts.dart';
import 'package:flutter/material.dart';

Widget galleryCamera(BuildContext context,void Function()? gallery,void Function()? camera ){

  return  Column(
                children: [
                  GestureDetector(
                    onTap: gallery,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 120,
                      height: MediaQuery.of(context).size.height * .075,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                          color: Color(0xFFE99600),
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(
                        '🖼️ Gallery',
                        textAlign: TextAlign.center,
                        style: myStyle20(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: camera,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 120,
                      height: MediaQuery.of(context).size.height * .075,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                          color: Color(0xFFE99600),
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(
                        '📸 Take Snap',
                        textAlign: TextAlign.center,
                        style: myStyle20(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              );
}