import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:simple_s3/simple_s3.dart';

import 'LandingPage.dart';
import 'ShowTheSignPage.dart';

class ScanTheObjectState extends StatefulWidget {
  const ScanTheObjectState({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  State<ScanTheObjectState> createState() => ScanTheObjectPage();
}

class ScanTheObjectPage extends State<ScanTheObjectState> {

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

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
              child: const Image(
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
                      child: Column(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30),
                            Container(
                              height: 300.0,
                              width: 300.0,
                              child: FutureBuilder<void>(
                                future: _initializeControllerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return CameraPreview(_controller);
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            FloatingActionButton(
                              onPressed: () async {
                                try {
                                  await _initializeControllerFuture;
                                  final image = await _controller.takePicture();
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DisplayPictureScreen(
                                        imagePath: image.path,
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: const Icon(Icons.camera_alt),
                            ),
                            SizedBox(height: 10),
                            // RaisedButton(
                            //     onPressed: () {
                            //       Navigator.of(context).push(MaterialPageRoute(
                            //           builder: (context) =>
                            //               ShowTheSignState()));
                            //     },
                            //     color: Colors.lightBlue[400],
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(25.0),
                            //     ),
                            //     child: Text(
                            //       "Next",
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     )),
                            SizedBox(height: 10),
                            Text(
                              "!Warning Please hold the camera for seconds",
                              style: TextStyle(
                                color: Colors.cyan[900],
                                fontSize: 18.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        )
                      ]),
                    )))
          ],
        ))
      ],
    ));
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

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
                    child: const Image(
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
                            child: Column(children: [
                              SizedBox(height: 70),
                              Center(
                                child: Image.file(
                                  File(imagePath),
                                ),

                              ),
                              SizedBox(height: 20),
                              RaisedButton(onPressed:()async {

                                SimpleS3 _simpleS3 = SimpleS3();
                                String result = await _simpleS3.uploadFile(
                                    File(imagePath),
                                    "sdgpinput",
                                    "ap-south-1:71968705-b2d0-4911-9cac-078532ee7759",
                                    AWSRegions.apSouth1,
                                    debugLog: true,
                                    s3FolderPath: "test",
                                    fileName: "inputImage.jpg"
                                );
                                print(result);

                                getSign();
                                if (showPopup){
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
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LandingPageState()));

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
                                          ShowTheSignState(className:name)));
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
                            ]),
                          )))
                ],
              ))
        ],
      ),
    );
  }
}


late String name = "";
late bool showPopup = false;

String className = "Apple" ;
void getSign(){
  var classes = ["Airplane","Apple","Bag","Bicycle","Boat","Brass","Bread","Bun","Bus","Car","CD","Chicken","Coconut","Cricket","Cup","Desk","Egg","Father","Female","Fish","Flower","Food","Football","Frock","Fruit","Grass","Knife","Male","Medicine","Milk","Motorbike","Paper","Pen","Person","Plate","Rock","Sand","Saree","Shirt","Shoes","Shorts","Shower","Slippers","Socks","Spoon","Tea","Television","ThreeWheeler","Train","Tree","Trousers","Underwear","Van","Vegetable","Vest","Volleyball","Water"];
  if(classes.contains(className)) {
    name = className;
  }else{
    name = "-";
    showPopup = true;

  }
}