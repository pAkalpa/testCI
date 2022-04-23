import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';


import 'FeedbackPage.dart';
import 'LandingPage.dart';
import 'ScanTheObjectPage.dart';



class ShowTheSignState extends StatefulWidget{
  late String className;
  ShowTheSignState({Key? key, required this.className}) : super(key: key);
  @override
  State<ShowTheSignState> createState() => ShowSignPage();


}

class ShowSignPage extends State<ShowTheSignState> {


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
                colors: [Colors.cyan, Colors.blueGrey]
              )
            )
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10.0),
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
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: GlassContainer(
                      height: 550,
                      width: 300,
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          colors:[Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.60)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                      ),
                      borderGradient: LinearGradient(
                        colors: [Colors.white.withOpacity(0.70), Colors.white.withOpacity(0.20), Colors.lightBlueAccent.withOpacity(0.10), Colors.lightBlueAccent.withOpacity(0.12)],
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
                        children:  [
                          const SizedBox(
                            height: 10.00,
                          ),
                          Text("In Sign",
                            style: TextStyle(color: Colors.cyan[900], fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            thickness: 1.5,
                            height: 40.0,
                            color: Colors.grey[50],
                            indent: 30,
                            endIndent: 30,
                          ),
                          Container(
                            width: 250.0,
                            height: 250.0,
                            child: Image.network(
                              'https://sdgpdatabucket.s3.ap-south-1.amazonaws.com/Objects/$className.jpg',
                            ),
                          ),
                          Divider(
                            thickness: 1.5,
                            height: 40.0,
                            color: Colors.cyan[600],
                            indent: 10,
                            endIndent: 10,
                          ),
                          Text("In Text",
                            style: TextStyle(color: Colors.cyan[900], fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            thickness: 1.5,
                            height: 40.0,
                            color: Colors.grey[50],
                            indent: 30,
                            endIndent: 30,
                          ),
                          Text(className,
                            style: TextStyle(color: Colors.cyan[900], fontSize: 20.0),
                          ),
                          const SizedBox(
                            height: 20.00,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LandingPageState()));       // uncomment this line after set the navigation to the lankding page
                                },
                                color: Colors.lightBlue[400],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: const Text('Home',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold )
                                ),

                              ),
                              RaisedButton(
                                onPressed: () {
                                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FeedbackPageState()));       // uncomment this line after set the navigation to the feedback page
                                },
                                color: Colors.lightBlue[400],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: const Text('Feedback',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold )
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]
      )
    );
  }
}


