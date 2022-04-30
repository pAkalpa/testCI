import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';


import 'LandingPage.dart';
import 'ShowTheSignPage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final picker = ImagePicker();
  late File _image;
  bool _loading = false;
  late List _output;

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);

    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);

  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);

    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);

  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {});
  }

  @override
  void dispose() {
    Tflite.close();
    _loading = false;
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _loading = false;
      _output = output!;
    });


    sendData();
  }

  sendData(){

    if(_output != null ){
      var classLabel = '${_output[0]['label']}';
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DisplayPictureScreen(imagePath : _image, ObjectLabel:classLabel)));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xFF101010),
        body: Stack(
          children:[Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.cyan, Colors.blueGrey])),
          ),Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10.0),
                const SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: Image(
                    image: AssetImage('assets/logo/logo_transparent.png'),
                  ),
                ),
                Center(
                  child: Container(
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: GlassContainer(
                      height: 400,
                      width: 300,
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(colors: [
                        Colors.white.withOpacity(0.60),
                        Colors.white.withOpacity(0.60)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderGradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.70),
                          Colors.white.withOpacity(0.20),
                          Colors.lightBlueAccent.withOpacity(0.10),
                          Colors.lightBlueAccent.withOpacity(0.12)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0.0, 0.39, 0.40, 1.0],
                      ),
                      blur: 15.0,
                      borderWidth: 1.5,
                      elevation: 3.0,
                      isFrostedGlass: true,
                      shadowColor: Colors.black.withOpacity(0.20),
                      alignment: Alignment.center,
                      frostedOpacity: 0.2,
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),

                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 30),

                              GestureDetector(
                                onTap: pickImage,
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 225,
                                  alignment: Alignment.center,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue[400],
                                    borderRadius:  BorderRadius.circular(25.0),

                                  ),
                                  child:  Center(
                                    child: Stack(
                                      children:   [
                                        const Icon(
                                          Icons.camera_alt_sharp,
                                          color: Colors.white,
                                          size: 100,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(5,100, 0, 5),
                                          child: const Text('Open Camera',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(

                                onTap: pickGalleryImage,
                                child: Container(

                                  width: MediaQuery.of(context).size.width - 225,
                                  alignment: Alignment.center,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue[400],
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child:  Center(
                                    child: Stack(
                                      children:   [
                                        const Icon(
                                          Icons.image_search,
                                          color: Colors.white,
                                          size: 100,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(5,100, 0, 5),
                                          child: const Text('Use Gallery',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          )
                        ]
                      )
                    )
                  )
                )
              ]
            )
          ),
          ]
        ));
  }
}


class DisplayPictureScreen extends StatelessWidget {
  final File imagePath;
  final String  ObjectLabel;



   const DisplayPictureScreen({Key? key, required this.imagePath, required this.ObjectLabel }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.cyan, Colors.blueGrey])),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10.0),
                const SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: Image(
                    image: AssetImage('assets/logo/logo_transparent.png'),
                  ),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30)),
                    child: GlassContainer(
                      height: 550,
                      width: 300,
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.60),
                            Colors.white.withOpacity(0.60)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderGradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.70),
                          Colors.white.withOpacity(0.20),
                          Colors.lightBlueAccent.withOpacity(0.10),
                          Colors.lightBlueAccent.withOpacity(0.12)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0.0, 0.39, 0.40, 1.0],
                      ),
                      blur: 15.0,
                      borderWidth: 1.5,
                      elevation: 3.0,
                      isFrostedGlass: true,
                      shadowColor: Colors.black.withOpacity(0.20),
                      alignment: Alignment.center,
                      frostedOpacity: 0.2,
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),

                      child: Column(
                        children: [
                          const SizedBox(height: 70),
                          Center(
                            child: Image.file(imagePath)
                          ),
                          const SizedBox(height: 20),

                          RaisedButton(onPressed:()async {

                            getSign(ObjectLabel);
                            if (showPopup){
                              showPopup = false;
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  title: const Text("Error 404",
                                      textAlign: TextAlign.center),
                                  content: const Text("Ops! you scan an object out of our scope",
                                      textAlign: TextAlign.center),
                                  actions: <Widget>[
                                    Center(
                                      child: RaisedButton(
                                        color: Colors.lightBlue[400],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LandingPageState()));

                                        },
                                        child: const Text("Home",
                                            style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }else{
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ShowTheSignState(classLabel:name,)));

                            }
                          }, color: Colors.lightBlue[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: const Text(
                                "Show Sign",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ]
                      )
                    )
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }
}


late String name = "";
late bool showPopup = false;

void getSign(object){
  String classLabel = object ;
  var classes = ["Airplane","Apple","Bag","Bicycle","Boat","Brass","Bread","Bun","Bus","Car","CD","Chicken","Coconut","Cricket","Cup","Desk","Egg","Father","Female","Fish","Flower","Food","Football","Frock","Fruit","Grass","Knife","Male","Medicine","Milk","Motorbike","Paper","Pen","Person","Plate","Rock","Sand","Saree","Shirt","Shoes","Shorts","Shower","Slippers","Socks","Spoon","Tea","Television","ThreeWheeler","Train","Tree","Trousers","Underwear","Van","Vegetable","Vest","Volleyball","Water"];
  if(classes.contains(classLabel)) {
    name = classLabel;
  }else{
    name = "-";
    showPopup = true;

  }
}