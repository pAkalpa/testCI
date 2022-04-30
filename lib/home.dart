import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:glass_kit/glass_kit.dart';

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

  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {});
  }

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

    print(_output);
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
                SizedBox(height: 10.0),
                Container(
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
                      height: 550,
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
                                  width: MediaQuery.of(context).size.width - 260,
                                  alignment: Alignment.center,
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue[400],
                                    borderRadius:  BorderRadius.circular(25.0),
                                  ),
                                  child: Text('Take a photo',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(

                                onTap: pickGalleryImage,
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 260,
                                  alignment: Alignment.center,
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                                  decoration: BoxDecoration(
                                    color:Colors.lightBlue[400],
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: Text('Camera Roll',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
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
          //   Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     Center(
          //       child: _loading
          //           ? Container(
          //             )
          //           :
          //       Container(
          //               child: Column(
          //               /*children: [
          //                 Container(
          //                   height: 250,
          //                   child: Image.file(_image),
          //                 ),
          //                 SizedBox(height: 20),
          //
          //                 _output != null ?
          //                 Container(
          //                   padding: EdgeInsets.symmetric(vertical: 10),
          //                     child: Text('${_output[0]['label']}', style: TextStyle(color: Colors.white, fontSize: 20.0))):
          //                     Container(),
          //               ],*/
          //             )),
          //     ),
          //
          //   ],
          // ),
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
                SizedBox(height: 10.0),
                Container(
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
                        stops: [0.0, 0.39, 0.40, 1.0],
                      ),
                      blur: 15.0,
                      borderWidth: 1.5,
                      elevation: 3.0,
                      isFrostedGlass: true,
                      shadowColor: Colors.black.withOpacity(0.20),
                      alignment: Alignment.center,
                      frostedOpacity: 0.2,
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(8.0),

                      child: Column(
                        children: [
                          SizedBox(height: 70),
                          Center(
                            child: Image.file(imagePath)
                          ),
                          SizedBox(height: 20),



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
                                  title: Text("Error 404",
                                      textAlign: TextAlign.center),
                                  content: Text("Ops! you scan an object out of our scope",
                                      textAlign: TextAlign.center),
                                  actions: <Widget>[
                                    Center(
                                      child: RaisedButton(
                                        color: Colors.lightBlue[400],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LandingPageState()));

                                        },
                                        child: Text("Home",
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
                              print(name + "sending class");
                            }
                          }, color: Colors.lightBlue[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Text(
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
  print(object);
  String classLabel = object ;
  var classes = ["Airplane","Apple","Bag","Bicycle","Boat","Brass","Bread","Bun","Bus","Car","CD","Chicken","Coconut","Cricket","Cup","Desk","Egg","Father","Female","Fish","Flower","Food","Football","Frock","Fruit","Grass","Knife","Male","Medicine","Milk","Motorbike","Paper","Pen","Person","Plate","Rock","Sand","Saree","Shirt","Shoes","Shorts","Shower","Slippers","Socks","Spoon","Tea","Television","ThreeWheeler","Train","Tree","Trousers","Underwear","Van","Vegetable","Vest","Volleyball","Water"];
  if(classes.contains(classLabel)) {
    name = classLabel;
  }else{
    name = "-";
    showPopup = true;

  }
}