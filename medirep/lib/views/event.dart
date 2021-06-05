import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medirep/components/constants.dart';
import 'package:medirep/components/headertext.dart';
import 'package:medirep/components/labeltext.dart';
import 'package:medirep/components/regulartext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:medirep/views/oops.dart';

class Event extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
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
                    onPressed: () => Navigator.of(context).pop(),
                  )),
              backgroundColor: Colors.transparent,
              body: Center(
                  child: Column(
                children: [
                  SpecialText("all events"),
                  SizedBox(height: no10),
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
                            .collection('events')
                            .orderBy('timestamp', descending: false)
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
                                                0), // changes position of shadow
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
                                                      color: red,
                                                      blurRadius: 4,
                                                      // spreadRadius: 2,
                                                      // blurRadius: 2,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                // color: white,
                                                width: size.width * .9,
                                                height: size.height * .25,
                                                padding: EdgeInsets.all(30),
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SpecialText(
                                                        document['name']),
                                                    RegularText("(added " +
                                                        DateFormat(
                                                                'dd.MM.yyyy – kk:mm a')
                                                            .format(document[
                                                                    "timestamp"]
                                                                .toDate())
                                                            .toString() +
                                                        ")"),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            LabelText("date: "),
                                                            RegularText(
                                                                document[
                                                                    'date']),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            LabelText("time: "),
                                                            RegularText(
                                                                document[
                                                                    'time']),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        LabelText("info: "),
                                                        RegularText(
                                                            document['info']),
                                                      ],
                                                    ),
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
