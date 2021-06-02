import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medirep/components/constants.dart';
import 'package:medirep/components/headertext.dart';
import 'package:medirep/components/normaltext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:medirep/components/topbar.dart';
import 'package:medirep/views/admindash.dart';
import 'package:medirep/views/login.dart';

// ignore: must_be_immutable
class Admin extends StatefulWidget {
  var userReference;
  final databaseReference = Firestore.instance;
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  String _value = "LOGIN AS ADMIN";
  final _nameController = new TextEditingController();
  final _passController = new TextEditingController();

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
          body: Container(
            height: size.height,
            width: double.infinity,
            child: Center(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HeaderText("medirep"),
                  // SizedBox(height: 20),
                  SpecialText("admin login"),
                  SizedBox(height: 20),
                  Container(
                    width: size.width * .75,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: TextFormField(
                          controller: _nameController,
                            // controller: _nameController,
                            // validator: (value) =>
                            //     _validateName(value),
                            style: TextStyle(
                                color: pureblack,
                                fontWeight: bold,
                                fontSize: 15),
                            decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontWeight: bold,
                                    fontSize: 15),
                                fillColor: white,
                                filled: true,
                                labelText: ("enter username"),
                                labelStyle: TextStyle(
                                    color: black,
                                    fontWeight: bold,
                                    fontSize: 15)))),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: size.width * .75,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: TextFormField(
                          controller: _passController,
                            // controller: _nameController,
                            // validator: (value) =>
                            //     _validateName(value),
                            style: TextStyle(
                                color: pureblack,
                                fontWeight: bold,
                                fontSize: 15),
                            decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontWeight: bold,
                                    fontSize: 15),
                                fillColor: white,
                                filled: true,
                                labelText: ("enter password"),
                                labelStyle: TextStyle(
                                    color: black,
                                    fontWeight: bold,
                                    fontSize: 15)))),
                  ),
                  SizedBox(height: 20),
                  Container(
                      width: size.width * .75,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: FlatButton(
                            onPressed: () async {
                              final QuerySnapshot result = await widget
                                  .databaseReference
                                  .collection('admin')
                                  .where('name', isEqualTo: _nameController.text)
                                  .where('pass', isEqualTo: _passController.text)
                                  .getDocuments();

                              final List<DocumentSnapshot> documents =
                                  result.documents;

                              if (documents.length > 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminDash()),
                                );
                              } else {
                                {
                                  setState(() {
                                    _value = "INVALID CREDENTIALS";
                                  });
                                  await Future.delayed(Duration(seconds: 2));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                }
                              }
                            },
                            child: NormalText(_value),
                            padding: EdgeInsets.all(20),
                            color: Colors.red[500],
                          ))),
                ],
              ),
            )),
          )),
    );
  }
}
