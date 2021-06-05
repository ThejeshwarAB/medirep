import 'package:flutter/material.dart';
import 'constants.dart';

class HeaderText extends StatelessWidget {
  final text;
  HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text.toLowerCase(),
        style: TextStyle(fontSize: no30, fontWeight: bold, color: red));
  }
}
