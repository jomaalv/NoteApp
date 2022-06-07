import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class Shares extends StatefulWidget {
   String title, desc, day, month, year, color;
  Shares({
    required this.title,
    required this.desc,
    required this.day,
    required this.month,
    required this.year,
    required this.color,
  });


  @override
  State<Shares> createState() => _SharesState();
}

class _SharesState extends State<Shares> {
   final controller = ScreenshotController();

Future saveAndShare(Uint8List bytes)async{
   final directory=await getApplicationDocumentsDirectory();
   final image=File('${directory.path}/flutter.png');
   image.writeAsBytesSync(bytes);

   await Share.shareFiles([image.path]);
  }

  @override
  void initState() {
    setState(() {
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
       backgroundColor: Colors.white,
        body: Column(
          children: [
            builImage(),
            SizedBox(height: 100,),
            InkWell(
                    onTap: () async {
                     final image = await controller.captureFromWidget(await builImage());
            await saveAndShare(image);
                     
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 47,
                        width: MediaQuery.of(context).size.width ,
                        child: Center(
                          child:Text(
                  'Share Now',
                 style: GoogleFonts.openSans(
                   textStyle:TextStyle(
                     color: Colors.white,
                     fontWeight:FontWeight.bold,
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
          ],
        ),
      ),
    );
  }
   Widget builImage()=>Padding(
     padding: const EdgeInsets.symmetric(horizontal: 20),
     child: Container(
        height: MediaQuery.of(context).size.height/1.5,
         width: MediaQuery.of(context).size.width,
         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(20)
         ),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           SizedBox(height: 50,),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
                 Text(
                                    '"',
                                    style: GoogleFonts.openSans(
                                      textStyle:TextStyle(
                                        color: Colors.black,
                                        fontWeight:FontWeight.bold,
                                        fontSize: 20
                                      )
                                    ),
                                   ),
               Text(
                                     widget.title,
                                    style: GoogleFonts.openSans(
                                      textStyle:TextStyle(
                                        color: Colors.black,
                                        fontWeight:FontWeight.bold,
                                        fontSize: 20
                                      )
                                    ),
                                   ),
                                    Text(
                                    '"',
                                    style: GoogleFonts.openSans(
                                      textStyle:TextStyle(
                                        color: Colors.black,
                                        fontWeight:FontWeight.bold,
                                        fontSize: 20
                                      )
                                    ),
                                   ),
             ],
           ),
                               SizedBox(height: 30,),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                   widget.desc,
                                  style: GoogleFonts.openSans(
                                    textStyle:TextStyle(
                                      color: Colors.grey.shade600,
                                      //fontWeight:FontWeight.bold,
                                      fontSize: 16
                                    )
                                  ),
                               ),
                                ),
                                SizedBox(height: 30,),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Text(
                                   'On : ',
                                  style: GoogleFonts.openSans(
                                    textStyle:TextStyle(
                                      color: Colors.grey.shade700,
                                   //   fontWeight:FontWeight.bold,
                                      fontSize: 16
                                    )
                                  ),
                               ),
                                      Text(
                                   widget.day,
                                  style: GoogleFonts.openSans(
                                    textStyle:TextStyle(
                                      color: Colors.grey.shade900,
                                      fontWeight:FontWeight.bold,
                                      fontSize: 16
                                    )
                                  ),
                               ),
                               Text(
                                  ' ',
                                  style: GoogleFonts.openSans(
                                    textStyle:TextStyle(
                                      color: Colors.grey.shade900,
                                      fontWeight:FontWeight.bold,
                                      fontSize: 16
                                    )
                                  ),
                               ),
                                  Text(
                                   widget.month,
                                  style: GoogleFonts.openSans(
                                    textStyle:TextStyle(
                                      color: Colors.grey.shade900,
                                      fontWeight:FontWeight.bold,
                                      fontSize: 16
                                    )
                                  ),
                               ),
                               Text(
                                   ', ',
                                  style: GoogleFonts.openSans(
                                    textStyle:TextStyle(
                                      color: Colors.grey.shade900,
                                      fontWeight:FontWeight.bold,
                                      fontSize: 16
                                    )
                                  ),
                               ),
                                  Text(
                                   widget.year,
                                  style: GoogleFonts.openSans(
                                    textStyle:TextStyle(
                                      color: Colors.grey.shade900,
                                      fontWeight:FontWeight.bold,
                                      fontSize: 16
                                    )
                                  ),
                               ),
                                    ],
                                  ),
                                ),
                               
         ],
       ),
     ),
   );
 
}