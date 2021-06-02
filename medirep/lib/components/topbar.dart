
import 'package:flutter/material.dart';
import 'package:medirep/components/specialtext.dart';

class TopBar {
  static getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: SpecialText("medirep"),
      centerTitle: true,
      elevation: 1,
      iconTheme: IconThemeData(
        color: Colors.black, 
      ),
      // leading: new IconButton(
      //     icon: new Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(),)
    );
  }

}