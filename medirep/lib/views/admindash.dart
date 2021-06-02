import 'package:flutter/material.dart';
import 'package:medirep/components/headertext.dart';
import 'package:medirep/components/normaltext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:medirep/components/topbar.dart';
import 'package:medirep/views/addevent.dart';
import 'package:medirep/views/report.dart';

class AdminDash extends StatefulWidget {
  @override
  _AdminDashState createState() => _AdminDashState();
}

class _AdminDashState extends State<AdminDash> {
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
         extendBodyBehindAppBar: true,
        appBar: TopBar.getAppBar(),
          backgroundColor: Colors.transparent,
          body: Center(
              child: SingleChildScrollView(
                              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                SizedBox(height: 20),
                HeaderText("medirep"),
                // SizedBox(height: 10),
                SpecialText("admin dashboard"),
                SizedBox(height: 10),
                Container(
                    // height: size.height * 0.15,
                    width: size.width * 0.75,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: FlatButton(
                          onPressed: () {
                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Report()),
                                );
                          },
                          child: NormalText("VIEW ALL MEDICAL REPORTS"),
                          padding: EdgeInsets.all(20),
                          color: Colors.red[500],
                        ))),
                // SizedBox(height: 10),
                // Container(
                //     height: size.height * 0.2,
                //     width: size.width * 0.9,
                //     child: ClipRRect(
                //         borderRadius: BorderRadius.circular(40),
                //         child: FlatButton(
                //           onPressed: () {},
                //           child: NormalText("ADD NEW MEDICAL REPORT"),
                //           padding: EdgeInsets.all(20),
                //           color: Colors.red[500],
                //         ))),
                // SizedBox(height: 10),
                  SizedBox(height: 20),
                Container(
                    // height: size.height * 0.15,
                    width: size.width * 0.75,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddEvent()),
                                );
                          },
                          child: NormalText("ADD NEW EVENT DETAILS"),
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
