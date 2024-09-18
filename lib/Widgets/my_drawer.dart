import 'package:baganbilash/Views/Disease_Details/black_spot.dart';
import 'package:baganbilash/Views/Disease_Details/downy_milder.dart';
import 'package:baganbilash/Views/Disease_Details/powder_milder.dart';
import 'package:baganbilash/Views/Disease_Details/rast.dart';
import 'package:baganbilash/Views/homePage.dart';
import 'package:flutter/material.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      backgroundColor: Color.fromARGB(141, 0, 0, 0),
      child:
     Column(children: [
      SizedBox(height: 100,),
     GestureDetector(
      onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Rast()));},
       child: Container(     
        padding: const EdgeInsets.only(left: 30),
        child: ListTile(
          
           
          title: Text("Rust",style: myStile25(color: Colors.black,fontWeight: FontWeight.bold),),tileColor: Color.fromARGB(255, 107, 243, 73),)),
     ),
     SizedBox(height: 20,),
     
        GestureDetector(
      onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PowderMilder()));},
       child: Container(
         child: Padding(
          padding: const EdgeInsets.only(left: 30),
           child: ListTile(title: Text("Powdery Milder",style: myStile25(color: Colors.black,fontWeight: FontWeight.bold),),tileColor: Color.fromARGB(255, 107, 243, 73)),
         ),
       ),
     ),
       SizedBox(height: 20,),
     GestureDetector(
      onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>DownyMilder()));},
       child: Container(
         child: Padding(
          padding: const EdgeInsets.only(left: 30),
           child: ListTile(title: Text("Downy Mildew",style: myStile25(color: Colors.black,fontWeight: FontWeight.bold),),tileColor: Color.fromARGB(255, 107, 243, 73)),
         ),
       ),
     ),
     SizedBox(height: 20,),
        GestureDetector(
      onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>BlackSpot()));},
       child: Container(
         child: Padding(
          padding: const EdgeInsets.only(left: 30),
           child: ListTile(title: Text("Black Spot",style: myStile25(color: Colors.black,fontWeight: FontWeight.bold),),tileColor: Color.fromARGB(255, 107, 243, 73)),
         ),
       ),
     ),
    
   
     
       ],),);
  }
}



