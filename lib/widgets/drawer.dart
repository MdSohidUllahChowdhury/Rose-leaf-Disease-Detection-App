import 'package:baganbilash/controllers/routes/disease_name_route.dart';
import 'package:baganbilash/views/diseaseInfo/black_spot.dart';
import 'package:baganbilash/views/diseaseInfo/downy_mildwe.dart';
import 'package:baganbilash/views/diseaseInfo/powder_milder.dart';
import 'package:baganbilash/views/diseaseInfo/rust.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:baganbilash/widgets/social_links.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF004643),
      child: Column(
        children: [
          SizedBox(height: 100),
          CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('lib/assets/roseLeafLogo.png'),
          ),
          SizedBox(height: 20),
          Text('Rose Leaf'.toUpperCase(),
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize:25,
                    ),
              ),
          SizedBox(height:40),
          dieaseName('Black Spot',
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => BlackSpot()))),
          dieaseName('Rust',
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Rust()))),
          dieaseName('Powdery Milder',
            () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PowderMilder()))),
          dieaseName('Downy Mildwe',
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => DownyMildwe()))),
        const SizedBox(height: 20),
        Text('© Md Sohid Ullah Chowdhury',
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize:12,
                    ),
              ),
        Divider(
          color: Colors.white,
        ),
        SizedBox(height: 6),
        Mylinks(),
      ],
    )
    );
  }
}
