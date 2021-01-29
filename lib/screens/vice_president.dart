import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_projec/common/buildstreambuilder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

bool vote_or_voted;

class vice_president extends StatefulWidget {
  @override
  _vice_presidentState createState() => _vice_presidentState();
}

class _vice_presidentState extends State<vice_president> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      vote_or_voted = vote_or_voted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: buildStreamBuilder(
          "vice_president",
        ));
  }
}
