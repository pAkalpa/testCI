import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:teambetatech/SearchText.dart';


import 'home.dart';

class LandingPageState extends StatefulWidget {
  const LandingPageState({Key? key}) : super(key: key);

  @override
  State<LandingPageState> createState() => LandingPage();

}

class LandingPage extends State<LandingPageState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  //Scaffold used to implements the basic material design visual layout structure
        body: Stack(
          children: [
            Container( //Container  used to store more widgets and position it on the screen accordingly
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
                        image: AssetImage('assets/logo/logo_transparent.png'), //image added
                      ),
                    ),

                    Stack(
                        children: [Container(
                            decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            child : GlassContainer(
                              height: 150,
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
                              child: Column(children: [
                                const SizedBox(height: 10.0),
                                Text(
                                  "This application is made for the verbally impaired people and normal people who are interested in learning sign language",
                                  style: TextStyle(
                                    color: Colors.cyan[900],
                                    fontSize: 18.0,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ]),
                            ),

                        ),
                        ]
                    ),
                    Row(
                      children: [Container(
                        padding: const EdgeInsets.fromLTRB(45,0, 0, 5),
                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SearchTextState()));
                          },
                          child: Container(

                            height: 200,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.lightBlue[400]),
                            child:  Center(
                              child: Stack(
                                children:   [const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 100,
                                ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(5,100, 0, 5),
                                    child: const Text('Search Object',
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
                      ),

                        AnimatedContainer(
                          padding: const EdgeInsets.fromLTRB(5,0, 0, 5),
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(30)),

                          duration:const Duration(seconds: 2),
                          curve: Curves.fastOutSlowIn,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Home()));
                            },
                            child: Container(

                              height: 200,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.lightBlue[400]),
                              child:  Center(
                                child: Stack(
                                  children:   [
                                    const Icon(
                                    Icons.view_in_ar,
                                    color: Colors.white,
                                    size: 100,
                                  ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(5,100, 0, 5),
                                      child: const Text('Scan Object',
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
                        ),

                      ],
                    )


                  ],
                ))
          ],
        ));
  }
}