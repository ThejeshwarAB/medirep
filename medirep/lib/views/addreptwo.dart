import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medirep/components/constants.dart';
import 'package:medirep/components/headertext.dart';
import 'package:medirep/components/normaltext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:medirep/model/data.dart';
import 'package:medirep/views/oops.dart';
import 'package:medirep/views/userdash.dart';
import 'package:flutter/cupertino.dart';
// import 'package:medirep/views/AddRepTwodash.dart';

class AddRepTwo extends StatefulWidget {
  final FirebaseUser user;
  final Map _mapValue;
  AddRepTwo(this.user, this._mapValue);
  @override
  _AddRepTwoState createState() => _AddRepTwoState();
}

class _AddRepTwoState extends State<AddRepTwo> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _medicationController = new TextEditingController();
  final _additionalController = new TextEditingController();

  Map<String, dynamic> _mapValue = new Map();

  @override
  void initState() {
    super.initState();
    _mapValue = widget._mapValue;
    print(_mapValue);
    _additionalController.text = "nil";
  }

  @override
  void dispose() {
    super.dispose();
    _medicationController.dispose();
    _additionalController.dispose();
  }

  String _validate(String value) {
    if (value.isEmpty) {
      return "\t\t\tdata invalid";
    }
    return null;
  }

  DateTime _date1 = DateTime(2021);
  DateTime _date2 = DateTime(2021);

  void _chooseTimeOne() async {
    final DateTime newTime1 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (newTime1 != null) {
      setState(() {
        _date1 = newTime1;
      });
    }
  }

  void _chooseTimeTwo() async {
    final DateTime newTime2 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (newTime2 != null) {
      setState(() {
        _date2 = newTime2;
      });
    }
  }

  String _reaction = "recovered";
  final _reactions = [
    "recovered",
    "admitted in hospital",
    "admitted in ICU",
  ];

  String _outcome = "recovered";
  final _outcomes = [
    "recovered",
    "expired",
    "unknown",
  ];

  Future<void> makeAsMap() {
    // _mapValue = {
    //   "reaction": DateFormat('dd-MM-yyyy').format(_date1),
    //   "recovery": DateFormat('dd-MM-yyyy').format(_date2),
    //   "medication": _medicationController.text,
    //   "severity": _reaction,
    //   "outcome": _outcome,
    //   "addon": _additionalController.text
    // };
    _mapValue["reaction"] = DateFormat('dd-MM-yyyy').format(_date1);
    _mapValue["recovery"] = DateFormat('dd-MM-yyyy').format(_date2);
    _mapValue["medication"] = _medicationController.text;
    _mapValue["severity"] = _reaction;
    _mapValue["outcome"] = _outcome;
    _mapValue["addon"] = _additionalController.text;
    return null;
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
              key: _scaffoldKey,
              // extendBodyBehindAppBar: true,
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
              body: Container(
                height: size.height,
                width: double.infinity,
                child: Center(
                    child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // SizedBox(height: no20),
                        // HeaderText("medirep"),
                        // SizedBox(height: no20),
                        SpecialText("add medical observations"),
                        SizedBox(height: no10),
                        // SpecialText("date of reaction: " +
                        //     DateFormat('dd-MM-yyyy').format(_time)),
                        Container(
                          color: black,
                          width: size.width * 0.25,
                          height: 1,
                        ),
                        SizedBox(height: no10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpecialText("date of reaction: "),
                            Container(
                                width: size.width * 0.35,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(no40),
                                  child: FlatButton(
                                      color: red,
                                      padding: EdgeInsets.all(no20),
                                      onPressed: _chooseTimeOne,
                                      child: NormalText(
                                        DateFormat('dd-MM-yyyy').format(_date1),
                                      )),
                                )),
                          ],
                        ),
                        SizedBox(height: no10),
                        // SpecialText("date of recovery: " +
                        //     DateFormat('dd-MM-yyyy').format(_time)),
                        // SizedBox(height: no20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpecialText("date of recovery: "),
                            Container(
                                width: size.width * 0.35,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(no40),
                                  child: FlatButton(
                                      color: red,
                                      padding: EdgeInsets.all(no20),
                                      onPressed: _chooseTimeTwo,
                                      child: NormalText(
                                        DateFormat('dd-MM-yyyy').format(_date2),
                                      )),
                                )),
                          ],
                        ),

                        SizedBox(height: no10),
                        Container(
                          width: size.width * .8,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(no40),
                              child: TextFormField(
                                  controller: _medicationController,
                                  maxLines: 3,
                                  validator: (value) => _validate(value),
                                  // controller: _nameController,
                                  // validator: (value) =>
                                  //     _validateName(value),
                                  style: TextStyle(
                                      color: pureblack,
                                      fontWeight: bold,
                                      fontSize: no15),
                                  decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      errorStyle: TextStyle(
                                          color: Colors.red,
                                          fontWeight: bold,
                                          fontSize: no15),
                                      fillColor: white,
                                      filled: true,
                                      labelText: ("suspected medication(s)"),
                                      labelStyle: TextStyle(
                                          color: black,
                                          fontWeight: bold,
                                          fontSize: no15)))),
                        ),
                        SizedBox(height: no10),
                        Container(
                          width: size.width * 0.8,
                          alignment: Alignment.center,
                          // mainaxisalignment: MainAxisAlignment.center,
                          // height: size.height * 0.1,
                          // decoration: BoxDecoration(color: white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SpecialText("severity:"),
                              SizedBox(width: no20),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(no40),
                                child: Container(
                                  padding:
                                      EdgeInsets.fromLTRB(no20, 0, no10, 0),
                                  color: white,
                                  child: DropdownButton(
                                    focusColor: white,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconEnabledColor: red,
                                    iconSize: 30,
                                    items: _reactions
                                        .map((String item) =>
                                            DropdownMenuItem<String>(
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight: bold,
                                                      fontSize: no15),
                                                ),
                                                value: item))
                                        .toList(),
                                    onChanged: (String value) {
                                      setState(() {
                                        //  print("previous ${this._designation}");
                                        //  print("selected $value");
                                        _reaction = value;
                                      });
                                    },
                                    value: _reaction,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: no10),
                        Container(
                          width: size.width * 0.8,
                          alignment: Alignment.center,
                          // mainaxisalignment: MainAxisAlignment.center,
                          // height: size.height * 0.1,
                          // decoration: BoxDecoration(color: white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SpecialText("outcome obsvd:"),
                              SizedBox(width: no20),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(no40),
                                child: Container(
                                  padding:
                                      EdgeInsets.fromLTRB(no20, 0, no10, 0),
                                  color: white,
                                  child: DropdownButton(
                                    focusColor: white,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconEnabledColor: red,
                                    iconSize: 30,
                                    items: _outcomes
                                        .map((String item) =>
                                            DropdownMenuItem<String>(
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight: bold,
                                                      fontSize: no15),
                                                ),
                                                value: item))
                                        .toList(),
                                    onChanged: (String value) {
                                      setState(() {
                                        //  print("previous ${this._designation}");
                                        //  print("selected $value");
                                        _outcome = value;
                                      });
                                    },
                                    value: _outcome,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: no10),

                        Container(
                          width: size.width * .8,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(no40),
                              child: TextFormField(
                                  controller: _additionalController,
                                  // maxLines: 3,
                                  validator: (value) => _validate(value),
                                  // controller: _nameController,
                                  // validator: (value) =>
                                  //     _validateName(value),
                                  style: TextStyle(
                                      color: pureblack,
                                      fontWeight: bold,
                                      fontSize: no15),
                                  decoration: InputDecoration(
                                      // alignLabelWithHint: true,
                                      errorStyle: TextStyle(
                                          color: Colors.red,
                                          fontWeight: bold,
                                          fontSize: no15),
                                      fillColor: white,
                                      filled: true,
                                      labelText: ("additional information"),
                                      labelStyle: TextStyle(
                                          color: black,
                                          fontWeight: bold,
                                          fontSize: no15)))),
                        ),
                        SizedBox(height: no10),
                        Container(
                            width: size.width * .8,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(no40),
                                child: FlatButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      await makeAsMap();
                                      // await addReportData(_mapValue);
                                      await addReportData(_mapValue);
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => UserDash(widget.user)),
                                      print("adding report");
                                      var snackBar = SnackBar(
                                        content:
                                            Text("report added successfully"),
                                        duration: Duration(seconds: 3),
                                      );
                                      _scaffoldKey.currentState
                                          .showSnackBar(snackBar);
                                      await Future.delayed(
                                          Duration(seconds: 2));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserDash(widget.user)),
                                      );
                                    }
                                  },
                                  child: NormalText("ADD MEDICAL REPORT"),
                                  padding: EdgeInsets.all(no20),
                                  color: Colors.red[500],
                                ))),
                        SizedBox(height: no10),
                      ],
                    ),
                  ),
                )),
              )),
    );
  }
}
