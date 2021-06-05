import 'package:flutter/material.dart';
import 'constants.dart';

class RegularText extends StatelessWidget {
  final text;
  RegularText(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 15, fontWeight: bold, color: pureblack),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
