import 'package:baganbilash/Controllers/disease_name_route.dart';
import 'package:baganbilash/Views/disease_details_screens/black_spot.dart';
import 'package:baganbilash/Views/disease_details_screens/downy_mildwe.dart';
import 'package:baganbilash/Views/disease_details_screens/powder_milder.dart';
import 'package:baganbilash/Views/disease_details_screens/rust.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      backgroundColor: Color(0xFF101010),
      child: Column(
        children: [
          SizedBox(height: 100),
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('lib/Assets/logo.png'),
          ),
          SizedBox(height: 10),
          Text('BaganBilash',
                style: GoogleFonts.roboto(
                    color: Color(0xFFEEDA28),
                    fontSize:20,
                    fontWeight: FontWeight.bold),
              ),
          SizedBox(height:15),
          dieaseName('Powdery Milder',
            () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PowderMilder()))),
          dieaseName('Downy Mildwe',
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => DownyMildwe()))),
          dieaseName('Black Spot',
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => BlackSpot()))),
          dieaseName('Rust',
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Rust()))),
        ],
      ),
    );
  }
}
