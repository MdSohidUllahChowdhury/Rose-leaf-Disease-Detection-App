import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rose_leaf_ai/drawer/social_links.dart';
import 'package:rose_leaf_ai/treatment/black_spot.dart';
import 'package:rose_leaf_ai/treatment/downy_mildwe.dart';
import 'package:rose_leaf_ai/treatment/powder_milder.dart';
import 'package:rose_leaf_ai/treatment/rust.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(207, 38, 50, 56),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          SizedBox(height: 100),
          CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('lib/assets/roseLeafLogo.png'),
          ),
          SizedBox(height: 20),
          Text(
            'Rose Leaf AI'.toUpperCase(),
            style: GoogleFonts.robotoSerif(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              wordSpacing: 2,
              letterSpacing: 2.5,
            ),
          ),
          Expanded(child: SizedBox(height: 40)),
          dieaseName(
            'Black Spot',
            () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => BlackSpot())),
          ),
          dieaseName(
            'Rust',
            () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => Rust())),
          ),
          dieaseName(
            'Powdery Milder',
            () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => PowderMilder())),
          ),
          dieaseName(
            'Downy Mildwe',
            () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => DownyMildwe())),
          ),
          Expanded(child: const SizedBox(height: 20)),
          Text(
            '© Md Sohid Ullah Chowdhury',
            style: GoogleFonts.roboto(color: Colors.white, fontSize: 12),
          ),
          Divider(color: Colors.white),
          SizedBox(height: 6),
          SocialLinks(),
          SizedBox(height: 23),
        ],
      ),
    );
  }
}

Widget dieaseName(String diseaseName, void Function()? routname) {
  return GestureDetector(
    onTap: routname,
    child: Container(
      height: ScreenUtil().setHeight(35),
      width: ScreenUtil().setWidth(310),
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Text(
        diseaseName,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF004643),
          fontSize: 16,
          letterSpacing: 2,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
