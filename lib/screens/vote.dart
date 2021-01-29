import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class vote extends StatefulWidget {
  @override
  _voteState createState() => _voteState();
}

class _voteState extends State<vote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Text('Ballot',
                style: GoogleFonts.architectsDaughter(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 10))),
        automaticallyImplyLeading: false,
      ),
      body: Container(),
    );
  }
}
