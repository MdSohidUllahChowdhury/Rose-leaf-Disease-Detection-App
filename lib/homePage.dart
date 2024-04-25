import 'dart:io';
import 'package:baganbilash/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }
  // drawer key
  final GlobalKey<ScaffoldState> _scaffoldkey=GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       drawer: MyDrawer(
       ),
       key: _scaffoldkey,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        leadingWidth: 120,
       
       backgroundColor:Colors.transparent,
        
         leading: 
           ElevatedButton(
            
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
              Colors.black
            ),
             
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      
      borderRadius: BorderRadius.circular(30.0),
      side: BorderSide(color:  Color(0xFF101010),width: 20,)
    )
  ),
  
),
            onPressed: (){
             _scaffoldkey.currentState!.openDrawer();
           }, child: Text("🦠 info",style:myStile20(color: Colors.white,fontWeight: FontWeight.bold)  ,))
        
        
      ),
      backgroundColor: Color(0xFF101010),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Text(
                'BaganBilash',
                style: GoogleFonts.roboto(color: Color(0xFFEEDA28), fontSize: 50,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              Center(
                  child: _loading
                      ? Container(
                          width: 450,
                          child: Column(
                            children: [
                              Image.asset('assets/tree.png'),
                              SizedBox(
                                height: 80,
                              )
                            ],
                          ),
                        )
                      : Container(
                          child: Column(
                            children: [
                              Container(
                                height: 250,
                                child: Image.file(_image),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _output != _output
                                  ? Text(
                                      'Error',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  : Text(
                                      '${_output[0]['label']}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        )),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 150,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                        decoration: BoxDecoration(
                            color: Color(0xFFE99600),
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          'Gallery',
                          style: myStile20(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: pickGalleryImage,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 150,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                        decoration: BoxDecoration(
                            color: Color(0xFFE99600),
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          'Camera Roll',
                          style: myStile20(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

myStile20({double? size,required color, FontWeight? fontWeight}){
  return GoogleFonts.roboto(fontSize: 20,color: color, fontWeight: fontWeight);

}
myStile25({double? size,required color, FontWeight? fontWeight}){
  return GoogleFonts.roboto(fontSize: 25,color: color, fontWeight: fontWeight);

}
