import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_projec/common/buildstreambuilder.dart';
import 'package:final_year_projec/screens/homepage.dart';
import 'package:final_year_projec/screens/result.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  bool _validateemail = false;
  bool _validatepassword = false;
  bool _validatename = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'HELLO',
                      style: GoogleFonts.allerta(
                        color: Colors.black,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('${"VOTER's"}',
                        style: GoogleFonts.allerta(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  TextField(
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black38, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintStyle: new TextStyle(color: Colors.black38),
                      hintText: "Name",
                      errorText: _validatename ? 'Value Can\'t Be Empty' : null,
                      //fillColor: Colors.white70
                    ),
                    controller: namecontroller,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black38, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintStyle: new TextStyle(color: Colors.black38),
                      hintText: "Email",
                      errorText:
                          _validateemail ? 'Value Can\'t Be Empty' : null,
                      //fillColor: Colors.white70
                    ),
                    controller: emailcontroller,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black38, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,

                      hintStyle: new TextStyle(color: Colors.black38),
                      hintText: "Password",
                      errorText:
                          _validatepassword ? 'Value Can\'t Be Empty' : null,
                      //fillColor: Colors.white70
                    ),
                    controller: passwordcontroller,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black)),
                      color: Colors.black,
                      child: Text(
                        'SignIn',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        signInWithEmailPassword(context);
                        setState(() {
                          emailcontroller.text.isEmpty
                              ? _validatename = true
                              : _validatename = false;
                          emailcontroller.text.isEmpty
                              ? _validateemail = true
                              : _validateemail = false;
                          passwordcontroller.text.isEmpty
                              ? _validatepassword = true
                              : _validatepassword = false;
                        });
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signInWithEmailPassword(context) async {
    UserCredential firebaseUser;
    try {
      firebaseUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
    } catch (e) {
      print(e.toString());
    } finally {
      if (firebaseUser != null) {
        print("SIGNED IN");
        checkExist();

        print(firebaseUser.user);
        buildStreamBuilderSignIn();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => buildStreamBuilderSignIn()));
      } else {
        Widget okButton = FlatButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.all(10.0),
          title: Text(
            "Error",
            style: GoogleFonts.allerta(),
          ),
          backgroundColor: Colors.green,
          content: Text(
            "Check email or password",
            style: GoogleFonts.quicksand(),
          ),
          actions: [
            okButton,
          ],
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    }
  }

  StreamBuilder<QuerySnapshot> buildStreamBuilderSignIn() {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('vote_or_result').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return snapshot.data.docs[0]['vote_or_result'] == true
              ? MyHomePage()
              : Result();
        });
  }

  checkExist() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection("users_votes")
          .doc(firebaseUser.uid)
          .get()
          .then((doc) {
        if (doc.exists == false) {
          FirebaseFirestore.instance
              .collection("users_votes")
              .doc(firebaseUser.uid)
              .set({
            "uid": firebaseUser.uid,
            "name": namecontroller.text,
            "president": '',
            'vice_president': '',
            'secretary': '',
            'treasurer': '',
            'chairman': '',
          }).then((_) {
            print("success!");
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
