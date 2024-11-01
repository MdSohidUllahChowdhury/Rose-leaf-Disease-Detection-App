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
  late List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().catchError((value) {
      setState(() {});
    });
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
        model: 'lib/Assets/model_unquant.tflite',
        labels: 'lib/Assets/labels.txt');
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
      backgroundColor: Color(0xFF101010),
      drawer: MyDrawer(),
      key: _scaffoldkey,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 40),
              diseaseDetailBottom(
                  () => _scaffoldkey.currentState!.openDrawer()),
              Text('BaganBilash',
                style: GoogleFonts.roboto(
                    color: Color(0xFFEEDA28),
                    fontSize: 46,
                    fontWeight: FontWeight.bold)
                    ),
              SizedBox(height: 30),
              Center(
                  child: _loading
                      ? Container(
                        padding: EdgeInsets.only(top: 4),
                          width: 450,
                          child: Column(
                            children: [
                              Image.asset('lib/Assets/tree.png'),
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
                          _output != _output
                              ? Text('Error',
                                  style: TextStyle(color: Colors.white, fontSize: 20))
                              : Text('${_output[0]['label']}',
                                  style: TextStyle(color: Colors.white, fontSize: 20)),
                          SizedBox(height: 10)
                        ],
                       )
                      ),
              galleryCamera(context, pickGalleryImage, pickImage)
            ],
          ),
        ),
      ),
    );
  }
}