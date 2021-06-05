import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medirep/components/constants.dart';
import 'package:medirep/components/headertext.dart';
import 'package:medirep/components/normaltext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:medirep/model/auth.dart';
import 'package:medirep/views/admin.dart';
import 'package:medirep/views/oops.dart';
import 'package:medirep/views/userdash.dart';
import 'package:connectivity/connectivity.dart';

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

  @override
  void dispose() {
    super.dispose();
  }

  var connected = true;

  Future<void> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        connected = true;
      });
    } else {
      setState(() {
        connected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkConnection();
    var size = MediaQuery.of(context).size;
    checkConnection();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: !connected
          ? Oops()
          : Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HeaderText("medirep"),
                    SpecialText("MEDICAL REPORTS MADE EASY".toLowerCase()),
                    SizedBox(height: no20),
                    Container(
                        width: size.width * .8,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(no40),
                            child: FlatButton(
                              onPressed: () async {
                                await signInWithGoogle().then((user) => {
                                      widget.user = user,
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
                              padding: EdgeInsets.all(no20),
                              color: red,
                            ))),
                    SizedBox(height: no20),
                    Container(
                        width: size.width * .8,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(no40),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Admin()),
                                );
                              },
                              child: NormalText("ADMINISTRATOR LOGIN"),
                              padding: EdgeInsets.all(no20),
                              color: red,
                            ))),
                  ],
                ),
              ))),
    );
  }
}
