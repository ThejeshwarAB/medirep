import 'package:flutter/material.dart';
import 'package:medirep/components/headertext.dart';
import 'package:medirep/components/normaltext.dart';
import 'package:medirep/components/specialtext.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:medirep/components/topbar.dart';

class ViewPdf extends StatefulWidget {
  @override
  _ViewPdfState createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  PDFDocument document;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  void _loadPdf() async {
    print("Pdf loaded");
    document = await PDFDocument.fromAsset('assets/files/ThejeshwarAB.pdf');
    setState(() {
      _loaded = true;
    });
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
          // extendBodyBehindAppBar: true,
          appBar: TopBar.getAppBar(),
          backgroundColor: Colors.transparent,
          body: Center(
              child: SingleChildScrollView(
                              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                // SizedBox(height: 20),
                // HeaderText("medirep"),
                // SizedBox(height: 10),
                SpecialText("view intructions pdf"),
                SizedBox(height: 10),
                Container(
                    height: size.height * 0.8,
                    width: size.width * .95,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: FlatButton(
                          onPressed: () {},
                          child: (_loaded)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: PDFViewer(
                                    document: document,
                                    zoomSteps: 1,
                                    lazyLoad: false,
                                    scrollDirection: Axis.vertical,
                                  ),
                                )
                              : NormalText("Please wait..."),
                          padding: EdgeInsets.all(10),
                          color: Colors.red[500],
                        ))),
                SizedBox(height: 20),
            ],
          ),
              ))),
    );
  }
}
