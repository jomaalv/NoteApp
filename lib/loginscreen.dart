// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kareem/forgotpassword.dart';
import 'package:kareem/landingpage.dart';
import 'package:kareem/registerscreen.dart';


import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isHide = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading=true;
      });
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successfully"),
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
                          transitionType: SharedAxisTransitionType.horizontal);
                    },
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secAnimation) {
                      return LandingPage();
                    })).then((value){
                      setState(() {
                        isLoading=false;
                      });
                    })
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message).then((value){
          setState(() {
            isLoading=!isLoading;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.grey.shade200,
        body: isLoading?Center(child: CircularProgressIndicator(color: Colors.blue,)):SingleChildScrollView(
      child: 
        
     
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30,),
                   Container(
                          height: 100,
                          width: 120,
                          child: Image.asset('assets/logo.png',fit: BoxFit.fill,)),
                          SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }
                      },
                      onSaved: (value) {
                        _emailController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        isDense: true,
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                        hintStyle: TextStyle(
                            fontSize: 13, color: Colors.grey.shade800),
                        hintText: 'Email',
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      obscureText: isHide ? true : false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                      },
                      onSaved: (value) {
                        _passwordController.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        isDense: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isHide = !isHide;
                              });
                            },
                            icon: isHide
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                        hintStyle: TextStyle(
                            fontSize: 13, color: Colors.grey.shade800),
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
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
                                  return ForgotPassword();
                                }));
                          },
                          child: Text(
                  'Forgot Password?',
                 style: GoogleFonts.openSans(
                   textStyle:TextStyle(
                     color: Colors.black,
                     fontWeight:FontWeight.bold,
                     fontSize: 12
                   )
                 ),
                ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () async {
                      signIn(_emailController.text, _passwordController.text);
                      final SharedPreferences _pref =
                          await SharedPreferences.getInstance();
                      _pref.setString('email', _emailController.text);
                     
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: 47,
                        width: MediaQuery.of(context).size.width ,
                        child: Center(
                          child:Text(
                  'Login',
                 style: GoogleFonts.openSans(
                   textStyle:TextStyle(
                     color: Colors.white,
                    // fontWeight:FontWeight.bold,
                     fontSize: 15
                   )
                 ),
                ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.blue.shade700, Colors.blue.shade900])),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'OR',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Text(
                  'Dont have an account ? ',
                 style: GoogleFonts.openSans(
                   textStyle:TextStyle(
                     color: Colors.black,
                    // fontWeight:FontWeight.bold,
                     fontSize: 14
                   )
                 ),
                ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
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
                     color: Colors.black,
                     fontWeight:FontWeight.bold,
                     fontSize: 14
                   )
                 ),
                ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ,
    ));
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, 0), radius: size.height / 2));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
