import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medirep/components/constants.dart';
import 'package:medirep/components/headertext.dart';
import 'package:medirep/components/labeltext.dart';
import 'package:medirep/components/regulartext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:medirep/views/admindash.dart';
import 'package:medirep/views/oops.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  void initState() {
    super.initState();
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
              //  extendBodyBehindAppBar: true,
              appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: HeaderText(
                    "medirep",
                  ),
                  centerTitle: true,
                  elevation: 0,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  leading: new IconButton(
                    icon: new Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminDash()),
                    ),
                  )),
              backgroundColor: Colors.transparent,
              body: Center(
                  child: Column(
                children: [
                  SpecialText("all reports"),
                  SizedBox(height: no20),
                  Container(
                    color: black,
                    width: size.width * 0.25,
                    height: 1,
                  ),
                  SizedBox(height: no20),
                  // SizedBox(height: no20),
                  Expanded(
                    child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('reports')
                            .orderBy('timestamp', descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: SpecialText("Please wait..."),
                            );
                          } else if (snapshot.data.documents.length == 0) {
                            return Center(
                              child: SpecialText("No data!"),
                            );
                          } else {
                            return ListView(
                                children:
                                    snapshot.data.documents.map((document) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: no10,
                                    ),
                                    Container(
                                      width: size.width * .9,
                                      // alignment: Alignment.center,
                                      // width: MediaQuery.of(context).size.width / 1.2,
                                      // height: MediaQuery.of(context).size.height / 5,
                                      decoration: BoxDecoration(
                                        // color: white,
                                        borderRadius:
                                            BorderRadius.circular(no40),
                                        boxShadow: [
                                          BoxShadow(
                                            color: pureblack,
                                            // blurRadius: 5,
                                            spreadRadius: 0.05,
                                            blurRadius: 2.5,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(no40),
                                        child: Column(
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                  color: purewhite,
                                                  // borderRadius: BorderRadius.circular(no20),
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
                                                width: size.width * .9,
                                                // height: size.height * 0.8,
                                                padding: EdgeInsets.all(no20),
                                                // alignment: Alignment.topRight,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ExpansionTile(
                                                      childrenPadding:
                                                          EdgeInsets.all(no10),
                                                      title: Column(
                                                        children: [
                                                          RegularText(document[
                                                                  'doctor'] +
                                                              "'s report"),
                                                          RegularText(DateFormat(
                                                                  'dd.MM.yyyy – kk:mm a')
                                                              .format(document[
                                                                      "timestamp"]
                                                                  .toDate())
                                                              .toString()),
                                                        ],
                                                      ),
                                                      children: [
                                                        // SpecialText(
                                                        //     document['doctor'] +
                                                        //         "'s report"),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            LabelText(
                                                                "designation: "),
                                                            RegularText(document[
                                                                "designation"]),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            LabelText(
                                                                "phone: "),
                                                            RegularText(
                                                                document[
                                                                    "mobile"]),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            LabelText(
                                                                "email: "),
                                                            RegularText(
                                                                document[
                                                                    "email"]),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            LabelText(
                                                                "patient: "),
                                                            RegularText(document[
                                                                    'patient'] +
                                                                "(" +
                                                                document[
                                                                    'gender'] +
                                                                ")"),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                LabelText(
                                                                    "weight: "),
                                                                RegularText(
                                                                    document[
                                                                        'weight']),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: no10,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                LabelText(
                                                                    "age: "),
                                                                RegularText(
                                                                    document[
                                                                        'age']),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            LabelText(
                                                                "reaction date: "),
                                                            RegularText(document[
                                                                'reaction']),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            LabelText(
                                                                "recovery date: "),
                                                            RegularText(document[
                                                                'recovery']),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5),
                                                        Container(
                                                          color: black,
                                                          width: size.width * 1,
                                                          height: 1,
                                                        ),
                                                        SizedBox(height: no10),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            // LabelText("medication: "),
                                                            Flexible(
                                                              child: Text(
                                                                document[
                                                                    "medication"],
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                // maxLines: 1,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        bold,
                                                                    color:
                                                                        pureblack),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: no10),
                                                        Container(
                                                          color: black,
                                                          width: size.width * 1,
                                                          height: 1,
                                                        ),
                                                        SizedBox(height: 5),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              LabelText(
                                                                  "severity: "),
                                                              RegularText(document[
                                                                  'severity']),
                                                            ]),
                                                        SizedBox(height: 5),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              LabelText(
                                                                  "outcome: "),
                                                              RegularText(
                                                                  document[
                                                                      'outcome']),
                                                            ]),
                                                        SizedBox(height: 5),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              LabelText(
                                                                  "info: "),
                                                              RegularText(
                                                                  document[
                                                                      'addon']),
                                                            ]),
                                                        // RegularText("outcome: " +
                                                        //     document['outcome']),
                                                        // RegularText(
                                                        //     "additional info: " +
                                                        //         document['addon']),
                                                      ],
                                                    ),
                                                    //   SpecialText(document['doctor'] +
                                                    //       "'s report"),
                                                    //   Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment.center,
                                                    //     children: [
                                                    //       LabelText("designation: "),
                                                    //       RegularText(document[
                                                    //           "designation"]),
                                                    //     ],
                                                    //   ),
                                                    //   Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment.center,
                                                    //     children: [
                                                    //       LabelText("phone: "),
                                                    //       RegularText(
                                                    //           document["mobile"]),
                                                    //     ],
                                                    //   ),
                                                    //  Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment.center,
                                                    //     children: [
                                                    //       LabelText("email: "),
                                                    //       RegularText(
                                                    //           document["mobile"]),
                                                    //     ],
                                                    //   ),
                                                    //   Container(
                                                    //     color: black,
                                                    //     width: size.width * 0.25,
                                                    //     height: 1,
                                                    //   ),
                                                    //   Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment.center,
                                                    //     children: [
                                                    //       LabelText("patient: "),
                                                    //       RegularText(
                                                    //       document['patient'] +
                                                    //       "(" +
                                                    //       document['gender'] +
                                                    //       ")"),
                                                    //     ],
                                                    //   ),
                                                    //   Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment.center,
                                                    //     children: [
                                                    //    Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment.center,
                                                    //     children: [
                                                    //       LabelText("weight: "),
                                                    //       RegularText(
                                                    //       document['weight']
                                                    //     ),
                                                    //     ],
                                                    //   ),
                                                    //   SizedBox(width: 30,),
                                                    //   Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment.center,
                                                    //     children: [
                                                    //       LabelText("age: "),
                                                    //       RegularText(
                                                    //       document['age']
                                                    //     ),
                                                    //     ],
                                                    //   ),
                                                    //     ],
                                                    //   ),
                                                    //   Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment.center,
                                                    //     children: [
                                                    //       LabelText("reaction date: "),
                                                    //       RegularText(
                                                    //       document['reaction']
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    //   Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment.center,
                                                    //     children: [
                                                    //       LabelText("recovery date: "),
                                                    //       RegularText(
                                                    //       document['recovery']
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    //   Container(
                                                    //     color: black,
                                                    //     width: size.width * 0.25,
                                                    //     height: 1,
                                                    //   ),
                                                    //   LabelText("medication:"),
                                                    //   Text(
                                                    //     document["medication"],
                                                    //     textAlign: TextAlign.center,
                                                    //     overflow: TextOverflow.visible,
                                                    //     maxLines: 1,
                                                    //     style: TextStyle(
                                                    //         fontWeight: bold,
                                                    //         color: pureblack),
                                                    //   ),
                                                    //   Container(
                                                    //     color: black,
                                                    //     width: size.width * 0.25,
                                                    //     height: 1,
                                                    //   ),
                                                    //   RegularText("severity: " +
                                                    //       document['severity']),
                                                    //   RegularText("outcome: " +
                                                    //       document['outcome']),
                                                    //   RegularText(
                                                    //       "additional info: " +
                                                    //           document['addon']),
                                                  ],
                                                )),
                                            // SizedBox(height: no20,)
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: no10,
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
