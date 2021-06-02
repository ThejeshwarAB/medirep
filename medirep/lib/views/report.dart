import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medirep/components/constants.dart';
import 'package:medirep/components/regulartext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:medirep/components/topbar.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  void initState() {
    super.initState();
  }

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
          //  extendBodyBehindAppBar: true,
          appBar: TopBar.getAppBar(),
          backgroundColor: Colors.transparent,
          body: Center(
              child: Column(
            children: [
              SpecialText("all reports"),
              SizedBox(height: 20),
              Container(
                color: black,
                width: size.width * 0.25,
                height: 1,
              ),
              SizedBox(height: 20),
              // SizedBox(height: 20),
              Expanded(
                child: StreamBuilder(
                    stream:
                        Firestore.instance.collection('reports').snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("Please wait..."),
                        );
                      } else {
                        return ListView(
                            children: snapshot.data.documents.map((document) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: size.width * .8,
                                  // alignment: Alignment.center,
                                  // width: MediaQuery.of(context).size.width / 1.2,
                                  // height: MediaQuery.of(context).size.height / 5,
                                  decoration: BoxDecoration(
                                    // color: white,
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                        color: pureblack,
                                        // blurRadius: 5,
                                        spreadRadius: 0.05,
                                        blurRadius: 2.5,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Column(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              color: purewhite,
                                              // borderRadius: BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: pureblack,
                                                  blurRadius: 4,
                                                  // spreadRadius: 2,
                                                  // blurRadius: 2,
                                                  // offset: Offset(0, 3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            // color: white,
                                            width: size.width * .8,
                                            height: size.height * .6,
                                            padding: EdgeInsets.all(30),
                                            alignment: Alignment.bottomCenter,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SpecialText(document['doctor'] +
                                                    "'s report"),
                                                RegularText("designation: " +
                                                    document["designation"]),
                                                RegularText("phone: " +
                                                    document["mobile"]),
                                                RegularText("email: " +
                                                    document["mobile"]),
                                                Container(
                                                  color: black,
                                                  width: size.width * 0.25,
                                                  height: 1,
                                                ),
                                                RegularText("patient: " +
                                                    document['patient'] +
                                                    "(" +
                                                    document['gender'] +
                                                    ")"),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    RegularText("weight: " +
                                                        document['weight']),
                                                    SizedBox(width: 20),
                                                    RegularText("age: " +
                                                        document['age']),
                                                  ],
                                                ),
                                                RegularText("reaction date: " +
                                                    document['reaction']),
                                                RegularText("recovery date: " +
                                                    document['recovery']),
                                                Container(
                                                  color: black,
                                                  width: size.width * 0.25,
                                                  height: 1,
                                                ),
                                                RegularText("medication: "),
                                                Text(
                                                  document["medication"],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight: bold,
                                                      color: black),
                                                ),
                                                Container(
                                                  color: black,
                                                  width: size.width * 0.25,
                                                  height: 1,
                                                ),
                                                RegularText("severity: " +
                                                    document['severity']),
                                                RegularText("outcome: " +
                                                    document['outcome']),
                                                RegularText(
                                                    "additional info: " +
                                                        document['addon']),
                                              ],
                                            )),
                                        // SizedBox(height: 20,)
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          );
                        }).toList());
                      }
                    }),
              ),
            ],
          ))),
    );
  }
}
