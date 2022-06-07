// ignore_for_file: prefer_const_constructors

import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kareem/loginscreen.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({ Key? key }) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  final _auth=FirebaseAuth.instance;

  void reset(String email)async{
    if(_formKey.currentState!.validate()){
      await _auth.sendPasswordResetEmail(email: email).then((value) => {
        Fluttertoast.showToast(msg: 
        'Request sent o your Email'),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen())),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: SafeArea(
      
          child: Form(
            key: _formKey,
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
                     Text('Reset',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 35),)
                   ],
                 ),
               ),
               SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Text("Reset Email link will be sent to your Email Address\nAfter click on Send Request, open your Gmail  account and change password from there",
            style: TextStyle(color: Colors.grey.shade700,fontSize: 13),),
              ),
             ),
                  ],
                ),
             SizedBox(height: 30,),
               Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                validator: (value){
                if(value!.isEmpty){
            return 'Enter Email';
                }
                },
                onSaved: (value)
                {
                _emailController.text=value!;
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
                    borderRadius: BorderRadius.circular(5)
                  ),
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800
                  ),
                  hintText: 'Email',
                  
                  prefixIcon: Icon(Icons.mail,color: Colors.black,),
                ),
              ),
            ),
            
            SizedBox(height: 40,),
             InkWell(
             onTap: (){
                reset(_emailController.text);
             },
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 30),
               child: Container(
                height: 47,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                  'Send Request',
                 style: GoogleFonts.openSans(
                   textStyle:TextStyle(
                     color: Colors.white,
                     //fontWeight:FontWeight.bold,
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
                    colors: [Colors.blue.shade700,Colors.blue.shade900])
                ),
                ),
             ),
             ),
             SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
              Text('OR',style: TextStyle(color: Colors.grey.shade500),),
              
            ],),
            SizedBox(height: 20,),
             Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  'Dont want to reset? ',
                 style: GoogleFonts.openSans(
                   textStyle:TextStyle(
                     color: Colors.black,
                   //  fontWeight:FontWeight.bold,
                     fontSize: 14
                   )
                 ),
                ),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
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
              )
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}