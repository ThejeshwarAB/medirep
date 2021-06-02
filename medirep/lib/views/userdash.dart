import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medirep/components/headertext.dart';
import 'package:medirep/components/normaltext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:medirep/components/topbar.dart';
import 'package:medirep/views/addrepone.dart';
import 'package:medirep/views/event.dart';
import 'package:medirep/views/login.dart';
import 'package:medirep/views/viewpdf.dart';

class UserDash extends StatefulWidget {
  final FirebaseUser user;
  UserDash(this.user);
  @override
  _UserDashState createState() => _UserDashState();
}

class _UserDashState extends State<UserDash> {
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
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
      backgroundColor: Colors.transparent,
      title: SpecialText("medirep"),
      centerTitle: true,
      elevation: 1,
      iconTheme: IconThemeData(
        color: Colors.black, 
      ),
      // leading: new IconButton(
      //     icon: new Icon(Icons.arrow_back_ios),
      //     onPressed: () => Navigator.push(
      //                             context,
      //                             MaterialPageRoute(
      //                                 builder: (context) => Login()),
      //                           ),
      //   ),
    ),
          backgroundColor: Colors.transparent,
          body: Center(
              child: SingleChildScrollView(
                              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                // SizedBox(height: 20),
                // HeaderText("medirep"),
                // SizedBox(height: 10),
                SpecialText("user dashboard"),
                SizedBox(height: 20),
                Container(
                    // height: size.height * 0.2,
                    width: size.width * 0.8,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: FlatButton(
                          onPressed: () {
                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewPdf()),
                                );
                          },
                          child: NormalText("VIEW INSTRUCTIONS PDF"),
                          padding: EdgeInsets.all(20),
                          color: Colors.red[500],
                        ))),
                SizedBox(height: 20),
                Container(
                    // height: size.height * 0.2,
                    width: size.width * 0.8,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: FlatButton(
                          onPressed: () { Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddRepOne(widget.user)),
                                );},
                          child: NormalText("ADD ADR REPORT"),
                          padding: EdgeInsets.all(20),
                          color: Colors.red[500],
                        ))),
                SizedBox(height: 20),
                Container(
                    // height: size.height * 0.2,
                    width: size.width * 0.8,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: FlatButton(
                          onPressed: () {
                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Event()),
                                );
                          },
                          child: NormalText("VIEW IMPORTANT EVENTS"),
                          padding: EdgeInsets.all(20),
                          color: Colors.red[500],
                        ))),
                SizedBox(height: 20),
            ],
          ),
              ))),
    );
  }
}
