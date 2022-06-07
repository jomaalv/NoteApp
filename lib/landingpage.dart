import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kareem/loginscreen.dart';
import 'package:kareem/newnote.dart';
import 'package:kareem/editnote.dart';
import 'package:kareem/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isLoading=false;
  String fid = 'loading';
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  signOut() async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signOut()
          .then((value) => {
                Fluttertoast.showToast(msg: 'Logout Successfully'),
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                    transitionDuration: const Duration(seconds: 1),
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
                    })),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation,
                  Widget child) {
                animation =
                    CurvedAnimation(parent: animation, curve: Curves.linear);
                return SharedAxisTransition(
                    child: child,
                    animation: animation,
                    secondaryAnimation: secAnimation,
                    transitionType: SharedAxisTransitionType.horizontal);
              },
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secAnimation) {
                return NewNote();
              }));
        },
        backgroundColor: Colors.blue.shade700,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue.shade700,
            size: 0,
          ),
        ),
        //  toolbarHeight: 60,
        flexibleSpace: Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue.shade700, Colors.blue.shade800])),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Container(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            'assets/logo.png',
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Center(
                        child: Text(
                          'My Notes',
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        // backgroundColor: Colors.blue.shade900,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    final SharedPreferences _pref =
                        await SharedPreferences.getInstance();
                    _pref.remove('email');
                    signOut();
                  },
                  child: Container(
                    height: 25,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.white, spreadRadius: 1)
                        ]),
                    child: Center(
                      child: Text(
                        'Log Out',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: isLoading?
      Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      )
      :Container(
        height: MediaQuery.of(context).size.height / 1.2,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('MyNotes')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('All')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Stack(children: [
                          Container(
                            height: 170,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade200,
                                      spreadRadius: 4,
                                      blurRadius: 5,
                                      offset: Offset(3, 3))
                                ]),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    height: 170,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(100),
                                            topRight: Radius.circular(100),
                                            bottomLeft: Radius.circular(100),
                                            bottomRight: Radius.circular(100)),
                                        color: snapshot.data!.docs[index]
                                                    ['color'] ==
                                                'Red'
                                            ? Colors.red
                                            : snapshot.data!.docs[index]
                                                        ['color'] ==
                                                    'Green'
                                                ? Colors.green
                                                : snapshot.data!.docs[index]
                                                            ['color'] ==
                                                        'Yellow'
                                                    ? Colors.yellow
                                                    : snapshot.data!.docs[index]
                                                                ['color'] ==
                                                            'Orange'
                                                        ? Colors.orange
                                                        : snapshot.data!.docs[index]
                                                                    ['color'] ==
                                                                'Pink'
                                                            ? Colors.pink
                                                            : snapshot.data!.docs[index]
                                                                        ['color'] ==
                                                                    'Purple'
                                                                ? Colors.purple
                                                                : snapshot.data!.docs[index]['color'] == 'Brown'
                                                                    ? Colors.brown
                                                                    : snapshot.data!.docs[index]['color'] == 'Blue'
                                                                        ? Colors.blue
                                                                        : null),
                                  ),
                                ),
                                Container(
                                  height: 170,
                                  width:
                                      MediaQuery.of(context).size.width / 1.4,
                                  // color: Colors.green,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]['title'],
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['desc'],
                                        // overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                                color: Colors.grey.shade500,
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 11)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'On : ',
                                            // overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    color: Colors.grey.shade700,
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 13)),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]['day'],
                                            // overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13)),
                                          ),
                                          Text(
                                            ' ',
                                            // overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13)),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]['month'],
                                            // overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13)),
                                          ),
                                          Text(
                                            ', ',
                                            // overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13)),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]['year'],
                                            // overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PopupMenuButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  transitionDuration:
                                                      Duration(seconds: 1),
                                                  transitionsBuilder:
                                                      (BuildContext context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secAnimation,
                                                          Widget child) {
                                                    animation = CurvedAnimation(
                                                        parent: animation,
                                                        curve: Curves.linear);
                                                    return SharedAxisTransition(
                                                        child: child,
                                                        animation: animation,
                                                        secondaryAnimation:
                                                            secAnimation,
                                                        transitionType:
                                                            SharedAxisTransitionType
                                                                .horizontal);
                                                  },
                                                  pageBuilder:
                                                      (BuildContext context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secAnimation) {
                                                    return EditNote(
                                                      title: snapshot.data!
                                                          .docs[index]['title'],
                                                      desc: snapshot.data!
                                                          .docs[index]['desc'],
                                                      day: snapshot.data!
                                                          .docs[index]['day'],
                                                      month: snapshot.data!
                                                          .docs[index]['month'],
                                                      year: snapshot.data!
                                                          .docs[index]['year'],
                                                      color: snapshot.data!
                                                          .docs[index]['color'],
                                                    );
                                                  }));
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 150,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                color: Colors.grey.shade800,
                                                size: 25,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Edit',
                                                // overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          setState(() {
                                            isLoading=true;
                                          });
                                          await FirebaseFirestore.instance
                                              .collection('MyNotes')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection('All')
                                              .where('title',
                                                  isEqualTo: snapshot.data!
                                                      .docs[index]['title'])
                                              .get()
                                              .then((QuerySnapshot snapshot) {
                                            snapshot.docs.forEach(
                                                (DocumentSnapshot doc) {
                                              var idid = doc.id;
                                              setState(() {
                                                fid = idid;
                                              });
                                            });
                                          }).whenComplete(()async{
                                          await FirebaseFirestore.instance.collection('MyNotes')
                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                          .collection('All')
                                          .doc(fid)
                                          .delete();
                                          }).whenComplete((){
                                            setState(() {
                                              isLoading=false;
                                            });
                                          });
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 150,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.grey.shade800,
                                                size: 25,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Delete',
                                                // overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                           Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  transitionDuration:
                                                      Duration(seconds: 1),
                                                  transitionsBuilder:
                                                      (BuildContext context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secAnimation,
                                                          Widget child) {
                                                    animation = CurvedAnimation(
                                                        parent: animation,
                                                        curve: Curves.linear);
                                                    return SharedAxisTransition(
                                                        child: child,
                                                        animation: animation,
                                                        secondaryAnimation:
                                                            secAnimation,
                                                        transitionType:
                                                            SharedAxisTransitionType
                                                                .horizontal);
                                                  },
                                                  pageBuilder:
                                                      (BuildContext context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secAnimation) {
                                                    return Shares(
                                                      title: snapshot.data!
                                                          .docs[index]['title'],
                                                      desc: snapshot.data!
                                                          .docs[index]['desc'],
                                                      day: snapshot.data!
                                                          .docs[index]['day'],
                                                      month: snapshot.data!
                                                          .docs[index]['month'],
                                                      year: snapshot.data!
                                                          .docs[index]['year'],
                                                      color: snapshot.data!
                                                          .docs[index]['color'],
                                                    );
                                                  }));
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 150,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.share,
                                                color: Colors.grey.shade800,
                                                size: 25,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Share',
                                                // overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            ],
                          )
                        ]),
                      );
                    });
              }
              return Container();
            }),
      ),
    );
  }
}
