import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_projec/screens/chairman.dart';
import 'package:final_year_projec/screens/president.dart';
import 'package:final_year_projec/screens/secretary.dart';
import 'package:final_year_projec/screens/treasurer.dart';
import 'package:final_year_projec/screens/vice_president.dart';
import 'package:final_year_projec/screens/vote.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:google_fonts/google_fonts.dart';

final _firestore = FirebaseFirestore.instance;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var buttontext = "CLICK";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Text('Ballot',
                  style: GoogleFonts.architectsDaughter(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 10))),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "PRESIDENT"),
              Tab(text: "VICE PRESIDENT"),
              Tab(
                text: 'SECRETARY',
              ),
              Tab(
                text: 'CHAIRMAN',
              ),
              Tab(
                text: 'TREASURER',
              )
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicator: RectangularIndicator(
              bottomLeftRadius: 100,
              bottomRightRadius: 100,
              topLeftRadius: 100,
              topRightRadius: 100,
            ),
          ),
        ),
        body: TabBarView(children: [
          president(),
          vice_president(),
          secretary(),
          chairman(),
          treasurer(),
        ]),
        // floatingActionButton: new FloatingActionButton.extended(
        //   backgroundColor: Colors.black,
        //   focusColor: Colors.grey,
        //   icon: Icon(Icons.how_to_vote_sharp),
        //   label: Text('VOTE'),
        //   onPressed: () {
        //     Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => vote()));
        //   },
        // ),
      ),
    );
  }
}
