import 'package:flutter/material.dart';
import 'package:medirep/views/login.dart';
import 'components/constants.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return LayoutBuilder(//return LayoutBuilder
        builder: (context, constraints) {
      return OrientationBuilder(//return OrientationBuilder
          builder: (context, orientation) {
            SizerUtil().init(constraints, orientation);
          return MaterialApp(
        title: 'medirep',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: font,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
          textTheme: TextTheme(
              bodyText2: TextStyle(
            color: Colors.red[500],
          )),
        ),
        home: Login()
      );}
    );
  });
}
  }