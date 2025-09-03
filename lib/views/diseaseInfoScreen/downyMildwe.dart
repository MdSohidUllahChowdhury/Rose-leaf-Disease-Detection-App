import 'package:flutter/material.dart';

class DownyMildwe extends StatelessWidget {
  const DownyMildwe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Downy Mildew'.toUpperCase(),
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                " Downy mildew is a common fungal disease that affects roses, causing significant damage to the plant's foliage and flowers. It is caused by the fungus Peronospora sparsa, which thrives in cool, humid environments.",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Symptoms of downy mildew include: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "1. Yellowish-green or brown spots on the upper surface of leaves\n2. A white or grayish downy growth on the underside of leaves\n3. Infected leaves may become distorted and eventually drop off\n4. Infected flowers may become discolored and fail to open properly\n",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Downy mildew can be managed by: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                  "1. Avoiding overhead watering, which can spread the fungus\n2. Ensuring good air circulation around rose plants\n3. Removing infected leaves and flowers promptly\n4. Applying fungicides specifically labeled for downy mildew control",
                  style: TextStyle(fontSize: 20))
            ],
          ),
        ),
      ),
    );
  }
}
