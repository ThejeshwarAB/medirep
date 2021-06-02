import 'package:flutter/material.dart';
import 'constants.dart';

class NormalText extends StatelessWidget {
  final text;
  NormalText(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 15, 
            fontWeight: bold, 
            color: purewhite),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
