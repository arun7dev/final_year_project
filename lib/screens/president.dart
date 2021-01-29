import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:final_year_projec/common/buildcard.dart';
import 'package:final_year_projec/common/buildstreambuilder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class president extends StatefulWidget {
  @override
  _presidentState createState() => _presidentState();
}

class _presidentState extends State<president> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildStreamBuilder(
        'president',
      ),
    );
  }
}
