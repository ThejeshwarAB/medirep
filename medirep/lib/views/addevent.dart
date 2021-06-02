import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medirep/components/constants.dart';
import 'package:medirep/components/normaltext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:medirep/components/topbar.dart';
import 'package:medirep/model/data.dart';
import 'package:medirep/views/admindash.dart';
// import 'package:medirep/views/AddEventdash.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _eventController = new TextEditingController();  
  final _detailsController = new TextEditingController();

  Map<String, dynamic> _mapValue = new Map();

  @override
  void initState() { 
    super.initState();
    _detailsController.text = "nil";
  }

  @override
  void dispose() {
    super.dispose();
    _eventController.dispose();
    _detailsController.dispose();
  }

  String _validate(String value) {
    if (value.isEmpty) {
      return "\t\t\tdata invalid";
    }
    return null;
  }
  
  DateTime _date = DateTime(2021);
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 30);

  void _chooseTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  void _chooseDate() async {
    final DateTime newTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (newTime != null) {
      setState(() {
       _date = newTime;
      });
    }
  }

  
Future<void> makeAsMap() {
    // _mapValue = {
    //   "reaction": DateFormat('dd-MM-yyyy').format(_date1),
    //   "recovery": DateFormat('dd-MM-yyyy').format(_date2),
    //   "medication": _medicationController.text,
    //   "severity": _reaction,
    //   "outcome": _outcome,
    //   "addon": _additionalController.text
    // };
    _mapValue["name"] = _eventController.text;
    _mapValue["info"] = _detailsController.text;
    _mapValue["date"] = DateFormat('dd-MM-yyyy').format(_date);
    _mapValue["time"] = _time.format(context);
    return null;
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
        key: _scaffoldKey,
          // extendBodyBehindAppBar: true,
          appBar: TopBar.getAppBar(),
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
                    // SizedBox(height: 20),
                    // HeaderText("medirep"),
                    // SizedBox(height: 20),
                    SpecialText("add new event details"),
                     SizedBox(height: 20),
                    Container(
                                      color: black,
                                      width: size.width * 0.25,
                                      height: 1,
                                    ),
                                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    Container(
                      width: size.width * .8,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: TextFormField(
                              controller: _eventController,
                              validator: (value) => _validate(value),
                              style: TextStyle(
                                  color: pureblack, fontWeight: bold, fontSize: 15),
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontWeight: bold,
                                      fontSize: 10),
                                  fillColor: white,
                                  filled: true,
                                  labelText: ("enter event name"),
                                  labelStyle: TextStyle(
                                      color: black,
                                      fontWeight: bold,
                                      fontSize: 15)))),
                    ),
                     SizedBox(height: 20),
                    Container(
                      width: size.width * .8,
                      // height: size.height * 0.1,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: TextFormField(
                            // maxLines: 3, 
                            
                              controller: _detailsController,
                              validator: (value) => _validate(value),
                              style: TextStyle(
                                  color: pureblack, fontWeight: bold, fontSize: 15),
                              decoration: InputDecoration(
    //                           contentPadding:
    // EdgeInsets.only(left: 0, bottom: 0.0, top: 25.0, right: 45),
  //  alignLabelWithHint: true,
                                  errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontWeight: bold,
                                      fontSize: 10),
                                  fillColor: white,
                                  filled: true,
                                  labelText: ("enter description"),
                                  labelStyle: TextStyle(
                                      color: black,
                                      fontWeight: bold,
                                      fontSize: 15)))),
                    ),
                    SizedBox(height: 20),        
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpecialText("date of event: "),
                        Container(
                            width: size.width * 0.35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: FlatButton(
                                  color: red,
                                  padding: EdgeInsets.all(20),
                                  onPressed: _chooseDate,
                                  child: NormalText(
                                    DateFormat('dd-MM-yyyy').format(_date),
                                  )),
                            )),
                      ],
                    ),
                     SizedBox(height: 20),        
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpecialText("time of event: "),
                        Container(
                            width: size.width * 0.35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: FlatButton(
                                  color: red,
                                  padding: EdgeInsets.all(20),
                                  onPressed: _chooseTime,
                                  child: NormalText(
                                    "${_time.format(context)}",
                                  )),
                            )),
                      ],
                    ),
                   
                    SizedBox(height: 20),
                    Container(
                        width: size.width * .8,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: FlatButton(
                              onPressed: () async {
                                   if (_formKey.currentState.validate()) {
                                      await makeAsMap();
                                  // await addReportData(_mapValue);
                                  await addEventData(_mapValue);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => UserDash(widget.user)),
                                  print("adding event");
                                  var snackBar = SnackBar(content: Text("event added successfully"), duration: Duration(seconds: 3),);
                                  _scaffoldKey.currentState.showSnackBar( snackBar );
                                  await Future.delayed(Duration(seconds: 2));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminDash()),
                                );
                              }},
                              child: NormalText("ADD NEW EVENT"),
                              padding: EdgeInsets.all(20),
                              color: Colors.red[500],
                            ))),
                            SizedBox(height: 20),
                  ],
                ),
              ),
            )),
          )),
    );
  }
}
