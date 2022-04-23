

import "package:flutter/material.dart";
import 'package:glass_kit/glass_kit.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'LandingPage.dart';

class FeedbackPageState extends StatefulWidget {
  const FeedbackPageState({Key? key}) : super(key: key);

  @override
  State<FeedbackPageState> createState() => FeedbackPage();

}



class FeedbackPage extends State<FeedbackPageState> {

  late double rate;


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
                  SizedBox(height: 10.0),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    child: Image(
                      image: AssetImage("assets/logo/logo_transparent.png"),
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
                            SizedBox(
                              height: 200.00,
                            ),

                            RatingBar.builder(
                              itemCount: 5,
                              initialRating: 3,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemBuilder :(context, _)=> Icon(
                                Icons.star,
                                color: Colors.indigoAccent,


                              ),
                              onRatingUpdate: (rating){
                                print(rating);
                                rate= rating;
                              },

                            ),


                            SizedBox(
                              height: 40.00,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LandingPageState()));
                                  },
                                  color: Colors.lightBlue[400],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)
                                  ),
                                  child: Text('Home',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold )
                                  ),


                                ),  RaisedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=>secondpage(rating:rate)
                                    ));
                                  },
                                  color: Colors.lightBlue[400],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)
                                  ),
                                  child: Text('Submit',
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
            )
          ],
        )
    );
  }
}
class secondpage extends StatelessWidget {
  late double rating;
  secondpage ({Key ? key,required this.rating}): super (key : key);
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
                  SizedBox(height: 10.0),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    child: Image(
                      image: AssetImage("assets/logo/logo_transparent.png"),
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
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150.00,
                              ),
                              Center(
                                child: Text("Thank You ! You Have Successfully Rated Our App With $rating Stars",style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,




                                ),),
                              ),





                              SizedBox(
                                height: 40.00,
                              ),



                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LandingPageState()));
                                    },
                                    color: Colors.lightBlue[400],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25)
                                    ),
                                    child: Text('Go Back',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold )
                                    ),
                                  )




                                ],



                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}

