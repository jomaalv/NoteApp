import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kareem/landingpage.dart';

class EditNote extends StatefulWidget {
  String title, desc, day, month, year, color;
  EditNote({
    required this.title,
    required this.desc,
    required this.day,
    required this.month,
    required this.year,
    required this.color,
  });

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController day = TextEditingController();
  final TextEditingController month = TextEditingController();
  final TextEditingController year = TextEditingController();
  final TextEditingController color = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String fid = 'loading';
  String titles='loading';
  String descs = 'loading';
  String days = 'loading';
  String months = 'loading';
  String years = 'loading';
  String colorss = 'loading';

  Color colors = Colors.grey.shade100;

  getInfo() async {
    await FirebaseFirestore.instance
        .collection('MyNotes')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('All')
        .where('title', isEqualTo: widget.title)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        var idid = doc.id;
        setState(() {
          fid = idid;
        });
      });
    }).whenComplete(()async{
  var vari=await FirebaseFirestore.instance
        .collection('MyNotes')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('All')
        .doc(fid)
        .get();
        setState(() {
          titles=vari.data()?['title'];
          descs=vari.data()?['desc'];
          days=vari.data()?['day'];
          months=vari.data()?['month'];
          years=vari.data()?['year'];
          colorss=vari.data()?['color'];
        
        });
    }).whenComplete((){
      setState(() {
        title.text=titles;
        desc.text=descs;
        day.text=days;
        month.text=months;
        year.text=years;
        color.text=colorss;
        if(colorss=='Red'){
          colors=Colors.red;
        }else if(colorss=='Green'){
          colors=Colors.green;
        }else if(colorss=='Yellow'){
          colors=Colors.yellow;
        }else if(colorss=='Orange'){
          colors=Colors.orange;
        }else if(colorss=='Pink'){
          colors=Colors.pink;
        }else if(colorss=='Purple'){
          colors=Colors.purple;
        }else if(colorss=='Brown'){
          colors=Colors.brown;
        }else if(colorss=='Blue'){
          colors=Colors.blue;
        }else{
          return null;
        }
        isLoading=false;
      });
    });
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text(
          'Edit Note',
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17)),
        ),
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Row(
                          children: [
                            Text(
                              'Title',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        maxLength: 25,
                        controller: title,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Title';
                          }
                        },
                        onSaved: (value) {
                          title.text = value!;
                        },
                        decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.title,color: Colors.grey.shade500,size: 20,),
                          isDense: true,
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none),
                          hintText: 'Write title',
                          hintStyle: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  //  fontWeight:FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Row(
                          children: [
                            Text(
                              'Description',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: desc,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Description';
                          }
                        },
                        onSaved: (value) {
                          desc.text = value!;
                        },
                        maxLength: 300,
                        maxLines: 5,
                        decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.title,color: Colors.grey.shade500,size: 20,),
                          isDense: true,
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none),
                          hintText: 'Write description',
                          hintStyle: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  //  fontWeight:FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Row(
                          children: [
                            Text(
                              'Date For Meeting (optional)',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            controller: day,
                            decoration: InputDecoration(
                              // isDense: true,
                              hintText: 'Day',
                              hintStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                      //  fontWeight:FontWeight.bold,
                                      fontSize: 14)),

                              suffixIcon: PopupMenuButton(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '01';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '01',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '02';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '02',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '03';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '03',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '04';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '04',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '05';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '05',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '06';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '06',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '07';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '07',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '08';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '08',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '09';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '09',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '10';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '10',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '11';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '11',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '12';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '12',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '13';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '13',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '14';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '14',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '15';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '15',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '16';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '16',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '17';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '17',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '18';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '18',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '19';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '19',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '20';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '20',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '21';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '21',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '22';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '22',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '23';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '23',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '24';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '24',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '25';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '25',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '26';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '26',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '27';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '27',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '28';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '28',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '29';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '29',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '30';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '30',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            day.text = '31';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '31',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: month,
                            decoration: InputDecoration(
                              // isDense: true,
                              hintText: 'Month',
                              hintStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                      //  fontWeight:FontWeight.bold,
                                      fontSize: 14)),
                              suffixIcon: PopupMenuButton(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            month.text = 'Jan';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Jan',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            month.text = 'Feb';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Feb',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            month.text = 'Mar';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Mar',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            month.text = 'Apr';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Apr',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            month.text = 'May';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'May',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            month.text = 'Jun';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Jun',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            month.text = 'Jul';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Jul',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            month.text = 'Aug';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Aug',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            month.text = 'Sep';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Sep',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            month.text = 'Oct';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Oct',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            month.text = 'Nov';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Nov',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            month.text = 'Dec';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Dec',
                                                  style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: year,
                            decoration: InputDecoration(
                              // isDense: true,
                              hintText: 'Year',
                              hintStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                      //  fontWeight:FontWeight.bold,
                                      fontSize: 14)),
                              suffixIcon: PopupMenuButton(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            year.text = '2022';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '2022',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            year.text = '2023';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '2023',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            year.text = '2024';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '2024',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            year.text = '2025';
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '2025',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Row(
                          children: [
                            Text(
                              'Choose Color For This Note',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: color,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Choose Color';
                          }
                        },
                        onSaved: (value) {
                          color.text = value!;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          fillColor: colors,
                          filled: true,
                          hintText: 'Choose Color',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none),
                          hintStyle: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  //  fontWeight:FontWeight.bold,
                                  fontSize: 14)),
                          suffixIcon: PopupMenuButton(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 30,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        colors = Colors.red;
                                        color.text = 'Red';
                                      });
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Red',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        colors = Colors.green;
                                        color.text = 'Green';
                                      });
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Green',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        colors = Colors.yellow;
                                        color.text = 'Yellow';
                                      });
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                  shape: BoxShape.circle),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Yellow',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        colors = Colors.orange;
                                        color.text = 'Orange';
                                      });
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  shape: BoxShape.circle),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Orange',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        colors = Colors.pink;
                                        color.text = 'Pink';
                                      });
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.pink,
                                                  shape: BoxShape.circle),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Pink',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        colors = Colors.purple;
                                        color.text = 'Purple';
                                      });
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.purple,
                                                  shape: BoxShape.circle),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Purple',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        colors = Colors.brown;
                                        color.text = 'Brown';
                                      });
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.brown,
                                                  shape: BoxShape.circle),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Brown',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        colors = Colors.blue;
                                        color.text = 'Blue';
                                      });
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  shape: BoxShape.circle),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Blue',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            await FirebaseFirestore.instance
                                .collection('MyNotes')
                                .doc(_auth.currentUser!.uid)
                                .collection('All')
                                .doc(fid)
                                .update({
                              'title': title.text,
                              'desc': desc.text,
                              'day': day.text,
                              'month': month.text,
                              'year': year.text,
                              'color': color.text
                            }).whenComplete(() {
                              Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
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
                                        return LandingPage();
                                      }));
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            height: 47,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                'Save',
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        //fontWeight:FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.blue.shade700,
                                      Colors.blue.shade800
                                    ])),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
