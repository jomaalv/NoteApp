// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animations/animations.dart';

import 'package:flutter/material.dart';
import 'package:kareem/welcomescreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //String? finalEmail;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AnimatedSplashScreen(
        splash: ClipRRect(
            child: Image.asset(
          'assets/logo.png',
          fit: BoxFit.cover,
        )),
        nextScreen: WelcomeScreen(),
        splashIconSize: 100,
        duration: 1000,
        splashTransition: SplashTransition.fadeTransition,
      ),
    ]);
  }
}
