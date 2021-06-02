import 'package:flutter/material.dart';
import 'constants.dart';

class HeaderText extends StatelessWidget {
  final text;
  HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: 40, fontWeight: bold));
  }
}