import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratcher/scratcher.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List posting = [
      'president',
      'vice_president',
      'chairman',
      'secretary',
      'treasurer',
    ];
    int a;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Text('Results',
                  style: GoogleFonts.architectsDaughter(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 10))),
        ),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return buildStreamBuilderResults(posting[index]);
            }));
  }

  StreamBuilder<QuerySnapshot> buildStreamBuilderResults(posting) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(posting)
            .orderBy('number_of_vote', descending: true)
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Center(child: CircularProgressIndicator());

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: PhysicalModel(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.blue[100],
                shadowColor: Colors.black,
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        '${toupper(posting)} Elect',
                        style: GoogleFonts.droidSans(fontSize: 25),
                      ),
                      Text(
                        snapshot.data.docs[0]['name'],
                        style: GoogleFonts.songMyung(fontSize: 35),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

toupper(String a) {
  return a.toUpperCase();
}
