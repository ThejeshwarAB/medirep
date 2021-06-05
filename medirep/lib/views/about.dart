import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medirep/components/constants.dart';
import 'package:medirep/components/headertext.dart';
import 'package:medirep/components/normaltext.dart';
import 'package:medirep/components/regulartext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:medirep/views/oops.dart';

class About extends StatefulWidget {
  final FirebaseUser user;
  About({this.user});
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  PDFDocument document;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  void _loadPdf() async {
    print("Pdf loaded");
    document = await PDFDocument.fromAsset('assets/files/about.pdf');
    setState(() {
      _loaded = true;
    });
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
              body: Center(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // SizedBox(height: no20),
                    // HeaderText("medirep"),
                    // SizedBox(height: 10),
                    SpecialText("about us"),
                    SizedBox(height: no10),
                    Container(
                        height: size.height * 0.8,
                        width: size.width * .95,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(no40),
                            child: FlatButton(
                              onPressed: () {},
                              child: (_loaded)
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(no20),
                                      child: PDFViewer(
                                        document: document,
                                        zoomSteps: 1,
                                        lazyLoad: false,
                                        scrollDirection: Axis.vertical,
                                      ),
                                    )
                                  : NormalText("Please wait..."),
                              padding: EdgeInsets.all(no10),
                              color: red,
                            ))),
                    SizedBox(height: no10),
                    RegularText("app developed by ThejeshwarAB©"),
                    SizedBox(height: no10),
                  ],
                ),
              ))),
    );
  }
}
