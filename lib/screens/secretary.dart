import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_projec/common/buildstreambuilder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class secretary extends StatefulWidget {
  @override
  _secretaryState createState() => _secretaryState();
}

class _secretaryState extends State<secretary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildStreamBuilder(
        "secretary",
      ),
    );
  }
}
