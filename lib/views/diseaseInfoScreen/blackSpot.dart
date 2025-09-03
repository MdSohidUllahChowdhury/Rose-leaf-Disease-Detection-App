import 'package:flutter/material.dart';

class BlackSpot extends StatelessWidget {
  const BlackSpot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Black Spot".toUpperCase(),
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          iconSize: 30,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 228, 225, 215),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Text(
                "Black spot, also known as Diplocarpon rosae, is a common fungal disease that affects roses, causing black or dark brown spots on the leaves, stems, and sometimes even the flowers. It is a widespread problem for rose growers and can significantly impact the health and appearance of rose plants.\n",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Symptoms: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "1. Black or dark brown spots on the leaves, which may start small and gradually enlarge and merge.\n2. The spots may have a slightly raised or sunken appearance.\n3. Infected leaves may turn yellow and drop prematurely, leading to defoliation.\n4. In severe cases, the stems and flowers can also be affected, causing black spots and lesions.\n\n",
                style: TextStyle(fontSize: 20),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Treatment: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "1. Preventive measures are crucial in managing black spot. Proper cultural practices, such as ensuring good air circulation, avoiding overhead watering, and removing fallen leaves, can help reduce the risk of infection.\n2. If the disease is already present, fungicides can be used to control the spread. Several fungicides are available, both chemical and organic, and their effectiveness may vary depending on the severity of the infection and the specific strain of the fungus.\n3. It is important to follow the instructions on the fungicide label carefully and apply it according to the recommended schedule to achieve effective control.\n\n",
                style: TextStyle(fontSize: 20),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Additional Tips: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "1. Choose rose varieties that are known to be resistant or tolerant to black spot.\n2. Prune your roses regularly to improve air circulation and remove any infected leaves or stems.\n3. Avoid over-fertilizing, as excessive nitrogen can make roses more susceptible to black spot.\n4. Water roses at the base to minimize the wetting of leaves and stems.\n5. Monitor your roses regularly for signs of black spot and take prompt action to control the disease.",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
