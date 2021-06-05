import 'package:flutter/material.dart';
import 'constants.dart';

class LabelText extends StatelessWidget {
  final text;
  LabelText(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: no15, fontWeight: bold, color: black),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
