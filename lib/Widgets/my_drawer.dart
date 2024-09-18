import 'package:baganbilash/Controllers/utils.dart';
import 'package:baganbilash/Views/Disease_Details/black_spot.dart';
import 'package:baganbilash/Views/Disease_Details/downy_milder.dart';
import 'package:baganbilash/Views/Disease_Details/powder_milder.dart';
import 'package:baganbilash/Views/Disease_Details/rast.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(141, 0, 0, 0),
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          DieaseName(
              'Rust',
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Rast()))),
          SizedBox(
            height: 20,
          ),
          DieaseName(
            'Powder Milder',
            () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PowderMilder())),
          ),
          SizedBox(
            height: 20,
          ),
          DieaseName(
              'Downy Milder',
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => DownyMilder()))),
          SizedBox(
            height: 20,
          ),
          DieaseName(
              'Black Spot',
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => BlackSpot()))),
        ],
      ),
    );
  }
}
