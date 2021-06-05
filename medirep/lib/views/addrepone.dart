import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medirep/components/constants.dart';
import 'package:medirep/components/headertext.dart';
import 'package:medirep/components/normaltext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:medirep/views/addreptwo.dart';
import 'package:medirep/views/oops.dart';
// import 'package:medirep/views/addrepotwo.dart';
// import 'package:medirep/views/AddRepOnedash.dart';

class AddRepOne extends StatefulWidget {
  final FirebaseUser user;
  AddRepOne(this.user);
  @override
  _AddRepOneState createState() => _AddRepOneState();
}

class _AddRepOneState extends State<AddRepOne> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _doctorController = new TextEditingController();
  final _mobileController = new TextEditingController();
  final _patientController = new TextEditingController();
  final _weightController = new TextEditingController();
  final _ageController = new TextEditingController();
  // final _observationController = new TextEditingController();

  Map<String, dynamic> _mapValue = new Map();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _doctorController.dispose();
    _patientController.dispose();
  }

  String _validate(String value) {
    if (value.isEmpty) {
      return "\t\t\tdata invalid";
    }
    return null;
  }

  Future<void> makeAsMap() {
    _mapValue = {
      "doctor": _doctorController.text,
      "mobile": _mobileController.text,
      "email": widget.user.providerData[0].email,
      "designation": _designation,
      "patient": _patientController.text,
      "weight": _weightController.text,
      "age": _ageController.text,
      "gender": _gender,
    };
    return null;
  }

  String _designation = "doctor";
  final _designations = [
    "doctor",
    "staff nurse",
    "pg student",
    "other staff",
    "pharmacist"
  ];

  String _gender = "male";
  final _genders = [
    "male",
    "female",
    "other",
  ];

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
    // String _chosenValue;
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
                        SpecialText("enter your details"),
                        SizedBox(height: no20),
                        Container(
                          width: size.width * .8,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(no40),
                              child: TextFormField(
                                  controller: _doctorController,
                                  validator: (value) => _validate(value),
                                  style: TextStyle(
                                      color: pureblack,
                                      fontWeight: bold,
                                      fontSize: no15),
                                  decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                          color: Colors.red,
                                          fontWeight: bold,
                                          fontSize: no10),
                                      fillColor: white,
                                      filled: true,
                                      labelText: ("enter your name"),
                                      labelStyle: TextStyle(
                                          color: black,
                                          fontWeight: bold,
                                          fontSize: no15)))),
                        ),
                        SizedBox(height: no20),
                        Container(
                          width: size.width * .8,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(no40),
                              child: TextFormField(
                                  controller: _mobileController,
                                  validator: (value) => _validate(value),
                                  style: TextStyle(
                                      color: pureblack,
                                      fontWeight: bold,
                                      fontSize: no15),
                                  decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                          color: Colors.red,
                                          fontWeight: bold,
                                          fontSize: no10),
                                      fillColor: white,
                                      filled: true,
                                      labelText: ("enter your mobile"),
                                      labelStyle: TextStyle(
                                          color: black,
                                          fontWeight: bold,
                                          fontSize: no15)))),
                        ),

                        SizedBox(height: no20),
                        // Text("Working as", style: TextStyle(
                        //                   color: pureblack,
                        //                   fontWeight: bold,
                        //                   fontSize: no15) ,
                        //                   textAlign: TextAlign.left,),
                        Container(
                          width: size.width * 0.8,
                          alignment: Alignment.center,
                          // mainaxisalignment: MainAxisAlignment.center,
                          // height: size.height * 0.1,
                          // decoration: BoxDecoration(color: white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SpecialText("designation:"),
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
                                    items: _designations
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
                                        _designation = value;
                                      });
                                    },
                                    value: _designation,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: no20),
                        Container(
                          color: black,
                          width: size.width * 0.25,
                          height: 1,
                        ),
                        SizedBox(height: no20),
                        SpecialText("enter patient details"),
                        SizedBox(height: no20),
                        Container(
                          width: size.width * .8,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(no40),
                              child: TextFormField(
                                  controller: _patientController,
                                  validator: (value) => _validate(value),
                                  style: TextStyle(
                                      color: pureblack,
                                      fontWeight: bold,
                                      fontSize: no15),
                                  decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                          color: Colors.red,
                                          fontWeight: bold,
                                          fontSize: no10),
                                      fillColor: white,
                                      filled: true,
                                      labelText: ("enter patient name"),
                                      labelStyle: TextStyle(
                                          color: black,
                                          fontWeight: bold,
                                          fontSize: no15)))),
                        ),
                        SizedBox(height: no20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * .4,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(no40),
                                  child: TextFormField(
                                      controller: _weightController,
                                      validator: (value) => _validate(value),
                                      style: TextStyle(
                                          color: pureblack,
                                          fontWeight: bold,
                                          fontSize: no15),
                                      decoration: InputDecoration(
                                          errorStyle: TextStyle(
                                              color: Colors.red,
                                              fontWeight: bold,
                                              fontSize: no10),
                                          fillColor: white,
                                          filled: true,
                                          labelText: ("weight in kgs"),
                                          labelStyle: TextStyle(
                                              color: black,
                                              fontWeight: bold,
                                              fontSize: no15)))),
                            ),
                            SizedBox(width: no10),
                            Container(
                              width: size.width * .4,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(no40),
                                  child: TextFormField(
                                      controller: _ageController,
                                      validator: (value) => _validate(value),
                                      style: TextStyle(
                                          color: pureblack,
                                          fontWeight: bold,
                                          fontSize: no15),
                                      decoration: InputDecoration(
                                          errorStyle: TextStyle(
                                              color: Colors.red,
                                              fontWeight: bold,
                                              fontSize: no10),
                                          fillColor: white,
                                          filled: true,
                                          labelText: ("age in number"),
                                          labelStyle: TextStyle(
                                              color: black,
                                              fontWeight: bold,
                                              fontSize: no15)))),
                            ),
                          ],
                        ),

                        SizedBox(height: no20),
                        // Text("Working as", style: TextStyle(
                        //                   color: pureblack,
                        //                   fontWeight: bold,
                        //                   fontSize: no15) ,
                        //                   textAlign: TextAlign.left,),
                        Container(
                          width: size.width * 0.8,
                          alignment: Alignment.center,
                          // mainaxisalignment: MainAxisAlignment.center,
                          // height: size.height * 0.1,
                          // decoration: BoxDecoration(color: white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SpecialText("patient gender:"),
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
                                    items: _genders
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
                                        _gender = value;
                                      });
                                    },
                                    value: _gender,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: no20),
                        Container(
                            width: size.width * .75,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(no40),
                                child: FlatButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      await makeAsMap();
                                      // await addReportData(_mapValue);
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => UserDash(widget.user)),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddRepTwo(
                                                widget.user, _mapValue)),
                                      );
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           UserDash(widget.user)),
                                      // );
                                    }
                                  },
                                  child: NormalText("CONTINUE NEXT PAGE"),
                                  padding: EdgeInsets.all(no20),
                                  color: Colors.red[500],
                                ))),
                        SizedBox(height: no20),
                      ],
                    ),
                  ),
                )),
              )),
    );
  }
}
