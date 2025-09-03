import 'package:baganbilash/utils/style_fonts.dart';
import 'package:flutter/material.dart';

Widget galleryCamera(BuildContext context,void Function()? gallery,void Function()? camera ){

  return  Column(
                children: [
                  GestureDetector(
                    onTap: camera,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 120,
                      height: MediaQuery.of(context).size.height * .065,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                          color: Color(0xFF004643),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Camera',
                            textAlign: TextAlign.center,
                            style: myStyle20(
                                color: Colors.white,size: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: gallery,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 120,
                      height: MediaQuery.of(context).size.height * .065,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                          color: Color(0xFF004643),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.photo, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Gallery',
                            textAlign: TextAlign.center,
                            style: myStyle20(
                                color: Colors.white, size: 18),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
}