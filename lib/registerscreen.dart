// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kareem/loginscreen.dart';






class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isLoading=false;
  bool isHide = true;
  final _formKey = GlobalKey<FormState>();
  File? image;
  UploadTask? task;

  void signUp(String email, password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading=true;
      });
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async => {
            await FirebaseFirestore.instance
        .collection('MyNotes_Users')
        .doc(_auth.currentUser!.uid)
        .set({
      'Name': _usernameController.text,
      'Email': _emailController.text,
      'Password': _passwordController.text,
      
    }).whenComplete((){
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
                      return LoginScreen();
                    }));
                     Fluttertoast.showToast(msg: 'Account created successfully');
    })
              
               
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: 
          
        
          isLoading?
          Center(child: CircularProgressIndicator(
            color: Colors.blue,
          ),)
          :SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30,),
                      Container(
                       height: 100,
                          width: 120,
                        child: Image.asset('assets/logo.png',fit: BoxFit.fill,)),
                     
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            Text(
                              'Register',
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
                          controller: _usernameController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5)),
                            hintStyle: TextStyle(
                                fontSize: 13, color: Colors.grey.shade800),
                            hintText: 'Username',
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Username';
                            }
                          },
                          onSaved: (value) {
                            _usernameController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(
                        height: 15,
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
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: _confirmpasswordController,
                          obscureText: isHide ? true : false,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Confirm Password';
                            } else if (_passwordController.text != value) {
                              return 'Password didnot match';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _confirmpasswordController.text = value!;
                          },
                          textInputAction: TextInputAction.done,
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
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5)),
                            hintStyle: TextStyle(
                                fontSize: 13, color: Colors.grey.shade800),
                            hintText: 'Confirm Password',
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                         
                          signUp(_emailController.text,
                              _passwordController.text);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                            height: 47,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                  'Register',
                 style: GoogleFonts.openSans(
                   textStyle:TextStyle(
                     color: Colors.white,
                    // fontWeight:FontWeight.bold,
                     fontSize: 14
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
                  'Already have an account? ',
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
                                        parent: animation,
                                        curve: Curves.linear);
                                    return SharedAxisTransition(
                                        child: child,
                                        animation: animation,
                                        secondaryAnimation: secAnimation,
                                        transitionType:
                                            SharedAxisTransitionType
                                                .horizontal);
                                  },
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secAnimation) {
                                    return LoginScreen();
                                  }));
                            },
                            child: Text(
                  'Login',
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
                      ),
                      SizedBox(height: 50,),
                    ],
                  ),
                ),
              ),
            ),
          )
        );
  }
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
