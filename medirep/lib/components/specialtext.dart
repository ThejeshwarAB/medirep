import 'package:flutter/material.dart';
import 'constants.dart';

class SpecialText extends StatelessWidget {
  final text;
  SpecialText(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: 20, fontWeight: bold, color: pureblack));
  }
}
