import 'package:flutter/material.dart';
import 'package:medirep/components/constants.dart';
import 'package:medirep/components/headertext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class Oops extends StatefulWidget {
  // final FirebaseUser user;
  // Oops(this.user);
  @override
  _OopsState createState() => _OopsState();
}

class _OopsState extends State<Oops> {
  PDFDocument document;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  void _loadPdf() async {
    print("Pdf loaded");
    print(_loaded);
    document = await PDFDocument.fromAsset('assets/files/info.pdf');
    setState(() {
      _loaded = true;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          // extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: HeaderText(
              "medirep",
            ),
            centerTitle: true,
            elevation: 0,
            // iconTheme: IconThemeData(
            //   color: Colors.black,
            // ),
            // leading: new IconButton(
            //   icon: new Icon(Icons.arrow_back_ios),
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => UserDash(widget.user)),
            //   ),
            // )
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpecialText("OOPS, Please check your internet!".toLowerCase()),
                SizedBox(height: no10),
                SpecialText("Restart app when internet restores".toLowerCase()),
              ],
            ),
          )),
    );
  }
}
