import 'package:flutter/material.dart';

class Rust extends StatelessWidget {
  const Rust({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RUST",
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
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 228, 225, 215)),
        width: double.infinity,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text(
                "",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Rust of rose, also known as rose rust, is a common fungal disease that affects roses, causing significant damage to their foliage and overall appearance.\nIt is caused by the fungus Phragmidium mucronatum, which thrives in cool, humid climates and can spread rapidly under favorable conditions.",
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
                "1.Rust of rose is characterized by the presence of small, circular, yellow-orange spots on the upper surface of rose leaves.\n2. These spots gradually enlarge and turn reddish-brown or black, often with a yellow border.\n3. As the disease progresses, the spots may coalesce, causing the leaves to become distorted, yellow, and eventually drop prematurely.\n4. In severe cases, defoliation can occur, weakening the plant and reducing its ability to produce flowers.",
                style: TextStyle(fontSize: 20),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Treatment and Prevention: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "1. Fungicides:\n\nApplying fungicides containing active ingredients such as myclobutanil, triadimefon, or propiconazole can help control the spread of rust. Follow the instructions on the product label carefully for proper application and timing.\n\n2. Cultural Practices:\n\nAvoid overhead watering: \nWet foliage creates a favorable environment for fungal growth. Water roses at the base to keep the leaves dry.\n\nPrune infected leaves:\nRemove and destroy infected leaves promptly to prevent the spread of spores.\n\nKeep the area clean: \nRemove fallen leaves and debris around the rose plants to reduce the risk of infection.\n\nImprove air circulation: \nEnsure good air circulation around the roses to help dry the foliage and reduce humidity.\n\n3.Resistant Varieties: \n\nSome rose varieties are more resistant to rust than others. Consider planting rust-resistant varieties in areas where the disease is prevalent.\n\nRemember, early detection and prompt action are crucial in managing rust of rose and protecting your plants. If you suspect your roses are affected by rust, take immediate steps to control the disease and prevent further damage.",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
