import 'package:baganbilash/Controllers/disease_name.dart';
import 'package:baganbilash/Views/Disease_Details/black_spot.dart';
import 'package:baganbilash/Views/Disease_Details/downy_mildwe.dart';
import 'package:baganbilash/Views/Disease_Details/powder_milder.dart';
import 'package:baganbilash/Views/Disease_Details/rust.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      backgroundColor: Color.fromARGB(141, 0, 0, 0),
      child: Column(
        children: [
          SizedBox(height: 100),
          DieaseName(
            'Powdery Milder',
            () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PowderMilder())),
          ),
          DieaseName(
              'Downy Mildwe',
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => DownyMildwe()))),
          DieaseName(
              'Black Spot',
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => BlackSpot()))),
          DieaseName(
              'Rust',
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Rust()))),
        ],
      ),
    );
  }
}
