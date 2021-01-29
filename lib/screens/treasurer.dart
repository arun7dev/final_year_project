import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_projec/common/buildstreambuilder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class treasurer extends StatefulWidget {
  @override
  _treasurerState createState() => _treasurerState();
}

class _treasurerState extends State<treasurer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildStreamBuilder(
        'treasurer',
      ),
    );
  }
}
