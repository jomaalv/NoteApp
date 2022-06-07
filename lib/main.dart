// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kareem/splashscreen.dart';





void main(List<String> args)async{
  await WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(TextApp());
}

class TextApp extends StatelessWidget {
  const TextApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));
     return MaterialApp(
      home: SplashScreen(),
      title: 'My Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
    );
  }
}