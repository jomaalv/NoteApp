// ignore_for_file: prefer_const_constructors

import 'package:animations/animations.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kareem/loginscreen.dart';
import 'package:kareem/registerscreen.dart';


import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

@override
  void initState() {
  
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.white,
      body:Stack(
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                 gradient: LinearGradient(
                         begin: Alignment.topLeft,
                  end:Alignment.bottomRight,
                         colors: [Colors.blue.shade700,Colors.blue.shade900])
                ),
            ),
          ),
          ClipPath(
            clipper: WaveClipper1(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(color: Colors.blue.shade800.withOpacity(0.5)),
            ),
          ),
          ClipPath(
            clipper: WaveClipper2(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(color: Colors.blue.shade700.withOpacity(0.7)),
            ),
          ),
          ClipPath(
            clipper: WaveClipper3(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end:Alignment.bottomRight,
                  colors: [Colors.blue.shade300,Colors.blue.shade900])
              ),
            ),
          ),
           ClipPath(
            clipper: WaveClipper7(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey.withOpacity(0.1)])),
            ),
          ),
           
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                ),
                // ignore: prefer_const_constructors
                Text(
                  'WELCOME!',
                 style: GoogleFonts.openSans(
                   textStyle:TextStyle(
                     color: Colors.white,
                     fontWeight:FontWeight.bold,
                     fontSize: 35
                   )
                 ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                  'Nice To See You !',
                 style: GoogleFonts.openSans(
                   textStyle:TextStyle(
                     color: Colors.black,
                     fontWeight:FontWeight.bold,
                     fontSize: 13
                   )
                 ),
                ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(PageRouteBuilder(
                        transitionDuration: Duration(seconds: 1),
                        transitionsBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secAnimation,
                            Widget child) {
                          animation = CurvedAnimation(
                              parent: animation, curve: Curves.linear);
                          return SharedAxisTransition(
                              child: child,
                              animation: animation,
                              secondaryAnimation: secAnimation,
                              transitionType:
                                  SharedAxisTransitionType.horizontal);
                        },
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secAnimation) {
                          return LoginScreen();
                        }));
                  },
                  child: Container(
                    height: 50,
                    width: 120,
                    child: Center(
                        child: Text(
                  'Login',
                 style: GoogleFonts.openSans(
                   textStyle:TextStyle(
                     color: Colors.white,
                    // fontWeight:FontWeight.bold,
                     fontSize: 14
                   )
                 ),
                ),),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                       gradient: LinearGradient(
                         begin: Alignment.topLeft,
                  end:Alignment.bottomRight,
                         colors: [Colors.blue.shade700,Colors.blue.shade900])
                       ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Row(
                  children: [
                    Text(
                  'Yor are not a member ?',
                 style: GoogleFonts.openSans(
                   textStyle:TextStyle(
                     color: Colors.black,
                    // fontWeight:FontWeight.bold,
                     fontSize: 15
                   )
                 ),
                ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                            transitionDuration: Duration(seconds: 1),
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secAnimation,
                                Widget child) {
                              animation = CurvedAnimation(
                                  parent: animation, curve: Curves.linear);
                              return SharedAxisTransition(
                                  child: child,
                                  animation: animation,
                                  secondaryAnimation: secAnimation,
                                  transitionType:
                                      SharedAxisTransitionType.horizontal);
                            },
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secAnimation) {
                              return RegisterScreen();
                            }));
                      },
                      child: Text(
                  'Register',
                 style: GoogleFonts.openSans(
                   textStyle:TextStyle(
                     color: Colors.blue,
                     fontWeight:FontWeight.bold,
                     fontSize: 15
                   )
                 ),
                ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 3.2, 200), radius: size.height / 1.8));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 1.1, size.height / 6.5), radius: 400));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 1.45, size.height / 9),
        radius: size.height / 2));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 3, size.height / 9),
        radius: size.height / 2.5));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class WaveClipper8 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 8, size.height / 1.3),
        radius: size.height / 8));
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}



class WaveClipper7 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 1.5, size.height/4), radius: size.height / 12));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class WaveClipper4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 1.1, 0), radius: size.height / 3));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class WaveClipper5 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 12, 20), radius: size.height / 8));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

