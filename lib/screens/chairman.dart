import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_projec/common/buildstreambuilder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class chairman extends StatefulWidget {
  @override
  _chairmanState createState() => _chairmanState();
}

class _chairmanState extends State<chairman> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildStreamBuilder(
        'chairman',
      ),
    );
  }
}
