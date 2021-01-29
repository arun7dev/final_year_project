import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var firebaseUser = FirebaseAuth.instance.currentUser;

class buildStreamBuilder extends StatefulWidget {
  String collection_name;

  buildStreamBuilder(this.collection_name);

  @override
  _buildStreamBuilderState createState() => _buildStreamBuilderState();
}

class _buildStreamBuilderState extends State<buildStreamBuilder> {
  bool vote_or_voted;
  var text;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users_votes")
            .doc(firebaseUser.uid)
            .snapshots(),
        builder: (context, snapshot1) {
          if (!snapshot1.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(widget.collection_name)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text(toupper(widget.collection_name),
                            style: GoogleFonts.oswald(
                              fontSize: 40,
                            ))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs[0]
                                ['number_of_candidates'],
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                  child: ExpansionCard(
                                borderRadius: 30,
                                trailing: Icon(
                                  Icons.info_outline,
                                  color: Colors.black,
                                ),
                                title: Container(
                                  decoration: BoxDecoration(
                                    //color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            snapshot.data.docs[index + 1]
                                                ['name'],
                                            style: GoogleFonts.songMyung(
                                              fontSize: 30,
                                              color: Colors.black,
                                            )),
                                        Text(
                                          snapshot.data.docs[index + 1]
                                              ['department'],
                                          style: GoogleFonts.saira(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          //color: Colors.pinkAccent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              child: Text(
                                                snapshot.data.docs[index + 1]
                                                    ['about'],
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              child: Text(
                                                snapshot.data.docs[index + 1]
                                                    ['achievement'],
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  RaisedButton(
                                      color: Colors.black,
                                      child: Text(
                                        snapshot1.data[
                                                    widget.collection_name] ==
                                                ''
                                            ? 'VOTE'
                                            : 'VOTED',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        //alertdialogue
                                        Widget cancelButton = FlatButton(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                        Widget continueButton = FlatButton(
                                          child: Text("Confirm Vote"),
                                          onPressed: () {
                                            counter(snapshot, index,
                                                widget.collection_name);
                                            create_user_vote_in_firestore(
                                                widget.collection_name,
                                                snapshot.data.docs[index + 1]
                                                    ['name']);
                                            Navigator.pop(context);
                                            setState(() {
                                              vote_or_voted == false
                                                  ? vote_or_voted = true
                                                  : null;
                                            });
                                          },
                                        );

                                        // set up the AlertDialog
                                        AlertDialog alert = AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0))),
                                            contentPadding:
                                                EdgeInsets.all(10.0),
                                            title: snapshot1.data[widget
                                                        .collection_name] ==
                                                    ''
                                                ? Text("Vote")
                                                : Text('Voted'),
                                            content: snapshot1.data[widget
                                                        .collection_name] ==
                                                    ''
                                                ? Text(
                                                    "I want my ${widget.collection_name} to be ${snapshot.data.docs[index + 1]['name']}")
                                                : Text(
                                                    "You Already Voted for ${widget.collection_name}"),
                                            actions: snapshot1
                                                        .data[widget.collection_name] ==
                                                    ''
                                                ? [
                                                    cancelButton,
                                                    continueButton,
                                                  ]
                                                : [cancelButton]);

                                        // show the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      })
                                ],
                              ));
                            }),
                      ),
                    ),
                  ],
                );
              });
        });
  }
}

toupper(String a) {
  return a.toUpperCase();
}

void create_user_vote_in_firestore(collection_name, name) {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  FirebaseFirestore.instance
      .collection("users_votes")
      .doc(firebaseUser.uid)
      .update({
    collection_name: name,
  }).then((_) {
    print("success!");
  });
}

get_vote_or_voted(collection_name) async {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final String _collection = 'users_votes';
  String a;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  getData() async {
    return await _fireStore.collection(_collection).doc(firebaseUser.uid).get();
  }

  getData().then((val) async {
    a = await val.data()["${collection_name}"];
    print("${a.isEmpty} getting value");
  });

  return a.isNotEmpty;
}

set_vote_or_voted(
  text,
) async {
  bool b;
  if (await text == "") {
    b = false;
    print('if null text');
  } else {
    b = true;
    print('if text is available');
  }
  return b;
}

counter(snapshot, index, collection_name) async {
  await FirebaseFirestore.instance
      .collection(collection_name)
      .doc((index + 1).toString())
      .update({'number_of_vote': FieldValue.increment(1)});
}
