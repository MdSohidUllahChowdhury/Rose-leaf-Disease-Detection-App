import 'dart:io';
import 'package:baganbilash/Widgets/camera_gallery.dart';
import 'package:baganbilash/Widgets/disease_bottom.dart';
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
  List? _output;
  final picker = ImagePicker();


  Future<void> loadModel() async {
    await Tflite.loadModel(
        model: 'lib/assets/result/model_unquant.tflite',
        labels: 'lib/assets/result/labels.txt');
  }

  @override
  void initState() {
    super.initState();
    loadModel().catchError((value) {
      setState(() {});
    });
  }

  Future<void> classifyImage(File image) async {
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

  Future<void> pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  Future<void> pickGalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

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
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      key: _scaffoldkey,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 32),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 40),
              diseaseDetailBottom(
                  () => _scaffoldkey.currentState!.openDrawer()),
              SizedBox(height: 15),
              Text('ROSE LEAF DISEASE IDENTIFIER',
                  style: GoogleFonts.roboto(
                      color: Color(0xFF004643),
                      fontSize: 22,
                      fontWeight: FontWeight.w800)),
              SizedBox(height: 20),
              Center(
                  child: _loading
                      ? Container(
                          padding: EdgeInsets.only(top: 4),
                          width: 450,
                          child: Column(
                            children: [
                              Image.asset('lib/assets/roseLeafLogo.png',
                                  height: 320),
                              SizedBox(height: 20),
                              Text('“Smart Leaf Disease Identifier”',
                                  style: GoogleFonts.roboto(
                                      color: Color(0xFF101010),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 40)
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 4),
                              height: 250,
                              child: Image.file(_image),
                            ),
                            SizedBox(height: 20),
              (_output == null || _output!.isEmpty)
                ? Text('Error',
                  style: TextStyle(
                    color: Colors.black, fontSize: 20))
                : Text('${_output![0]['label']}',
                  style: TextStyle(
                    color: Colors.black, fontSize: 20)),
                            SizedBox(height: 10)
                          ],
                        )),
              galleryCamera(context, pickGalleryImage, pickImage)
            ],
          ),
        ),
      ),
    );
  }
}
