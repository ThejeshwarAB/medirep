import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medirep/components/headertext.dart';
import 'package:medirep/components/normaltext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:medirep/model/auth.dart';
// import 'package:medirep/model/data.dart';
import 'package:medirep/views/admin.dart';
import 'package:medirep/views/userdash.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  FirebaseUser user;
  var userReference;
  final databaseReference = Firestore.instance;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    signOutGoogle();
  }

  // Map<String, dynamic> _mapValue = new Map();

  // Future<void> makeAsMap() {
  //   _mapValue = {
  //     "id": widget.user.providerData[0].email,
  //   };
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: SingleChildScrollView(
                              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                HeaderText("medirep"),
                SpecialText("MEDICAL REPORTS MADE EASY".toLowerCase()),
                SizedBox(height: 20),
                Container(
                    width: size.width * .75,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: FlatButton(
                          onPressed: () async {
                            await signInWithGoogle().then((user) => {
                                  widget.user = user,
                                  // widget.userReference = widget.databaseReference
                                  //     .collection('users')
                                  //     .document(
                                  //         widget.user.providerData[0].email),
                                  // widget.userReference
                                  //     .get()
                                  //     .then((docSnapshot) => {
                                  //           if (!docSnapshot.exists)
                                  //             {
                                  //               makeAsMap(),
                                  //               addUserData(_mapValue)
                                  //             },
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserDash(widget.user)),
                                            )
                                          // })
                                });
                          },
                          child: NormalText("LOGIN USING GOOGLE"),
                          padding: EdgeInsets.all(20),
                          color: Colors.red[500],
                        ))),
                SizedBox(height: 20),
                Container(
                    width: size.width * .75,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Admin()),
                            );
                          },
                          child: NormalText("ADMINISTRATOR LOGIN"),
                          padding: EdgeInsets.all(20),
                          color: Colors.red[500],
                        ))),
            ],
          ),
              ))),
    );
  }
}
