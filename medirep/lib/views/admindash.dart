import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:medirep/components/constants.dart';
import 'package:medirep/components/headertext.dart';
import 'package:medirep/components/normaltext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:medirep/views/about.dart';
import 'package:medirep/views/addevent.dart';
import 'package:medirep/views/login.dart';
import 'package:medirep/views/oops.dart';
import 'package:medirep/views/report.dart';

class AdminDash extends StatefulWidget {
  @override
  _AdminDashState createState() => _AdminDashState();
}

class _AdminDashState extends State<AdminDash> {
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

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: !connected
          ? Oops()
          : WillPopScope(
                      onWillPop: () async => false,
                      child: Scaffold(
                // extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: HeaderText(
                    "medirep",
                  ),
                  centerTitle: true,
                  elevation: 0,
                  iconTheme: IconThemeData(
                    color: pureblack,
                  ),
                  leading: new IconButton(
                    icon: new Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: pureblack,
                      ),
                      iconSize: 30,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => About()),
                      ),
                    )
                  ],
                ),
                backgroundColor: Colors.transparent,
                body: Center(
                    child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: no20),
                      // HeaderText("medirep"),
                      // SizedBox(height: no10),
                      SpecialText("admin dashboard"),
                      SizedBox(height: no10),
                      Container(
                          // height: size.height * 0.no10,
                          width: size.width * 0.75,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(no40),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Report()),
                                  );
                                },
                                child: NormalText("VIEW ALL MEDICAL REPORTS"),
                                padding: EdgeInsets.all(no20),
                                color: Colors.red[500],
                              ))),
                      // SizedBox(height: no10),
                      // Container(
                      //     height: size.height * 0.2,
                      //     width: size.width * 0.9,
                      //     child: ClipRRect(
                      //         borderRadius: BorderRadius.circular(no40),
                      //         child: FlatButton(
                      //           onPressed: () {},
                      //           child: NormalText("ADD NEW MEDICAL REPORT"),
                      //           padding: EdgeInsets.all(no20),
                      //           color: Colors.red[500],
                      //         ))),
                      // SizedBox(height: no10),
                      SizedBox(height: no20),
                      Container(
                          // height: size.height * 0.no10,
                          width: size.width * 0.75,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(no40),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddEvent()),
                                  );
                                },
                                child: NormalText("ADD NEW EVENT DETAILS"),
                                padding: EdgeInsets.all(no20),
                                color: Colors.red[500],
                              ))),
                      SizedBox(height: no20),
                    ],
                  ),
                ))),
          ),
    );
  }
}
