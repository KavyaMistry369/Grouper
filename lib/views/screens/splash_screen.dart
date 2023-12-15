import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/utils/routes.dart';


class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  MyTimer(){
    Timer.periodic(const Duration(seconds: 5), (timer) {
      Navigator.of(context).pushReplacementNamed(MyRoutes.LR);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                "https://img.freepik.com/premium-vector/purple-icon-with-speech-bubble-word-chat-it_876006-14.jpg",
                width: 150,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Grouper",
                style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            CupertinoButton(
              child: Text("Continue",style: GoogleFonts.poppins(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(MyRoutes.LR);
              },
              color: Colors.deepPurple,
            )
          ],
        ),
      ),
    );
  }
}