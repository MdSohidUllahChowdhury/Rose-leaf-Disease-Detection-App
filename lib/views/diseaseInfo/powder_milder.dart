import 'package:flutter/material.dart';

class PowderMilder extends StatelessWidget {
  const PowderMilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Powdery Milder'.toUpperCase(),
            style: TextStyle(
                fontSize: 20,
                letterSpacing: 1.2,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 228, 225, 215)),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Text(
                "Powdery mildew is a common fungal disease that affects roses, causing white or gray powdery spots on the leaves, stems, and flowers. It is caused by the fungus Podosphaera pannosa, which thrives in warm, humid environments.",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Symptoms of powdery mildew on roses include:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "1. White or gray powdery spots on the leaves, stems, and flowers.\n2. Leaves may become yellow and distorted\n3. Flowers may be stunted or deformed\n4. Reduced vigor and growth of the plant",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Powdery mildew can be managed by:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "1. Using resistant rose varieties\n2. Avoiding overhead watering\n3. Providing good air circulation\n4. Applying fungicides, such as sulfur or neem oil\n\nIf you suspect that your roses have powdery mildew, it is important to take action to manage the disease and prevent it from spreading to other plants.",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
