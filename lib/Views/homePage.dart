import 'dart:io';
import 'package:baganbilash/Controllers/style_fonts.dart';
import 'package:baganbilash/Widgets/drawer.dart';
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

  loadModel() async {
    await Tflite.loadModel(
        model: 'lib/Assets/model_unquant.tflite', labels: 'lib/Assets/labels.txt');
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

  //* drawer key
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      key: _scaffoldkey,
      backgroundColor: Color(0xFF101010),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:20),
              ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                          color: Color(0xFF101010),
                          width:80,
                        )
                       )
                      ),
              ),
              onPressed: () {
                _scaffoldkey.currentState!.openDrawer();
              },
              child: Text(
                "🦠 info",
                style:TextStyle(
                  fontSize: 20,
                  color: Colors.white,    
                )
              )),
              Text(
                'BaganBilash',
                style: GoogleFonts.roboto(
                    color: Color(0xFFEEDA28),
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              Center(
                  child: _loading
                      ? Container(
                          width: 450,
                          child: Column(
                            children: [
                              Image.asset('lib/Assets/tree.png'),
                              SizedBox(
                                height: 40,
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
                          style: myStyle20(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                          style: myStyle20(
                              color: Colors.white, fontWeight: FontWeight.bold),
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


