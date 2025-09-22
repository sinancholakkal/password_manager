import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final TextOverflow textOverflow;
  final int maxLine;

  const TextWidget(
      {super.key,
      required this.text,
      this.color = Colors.white,
      this.size = 20,
      this.fontWeight,
      this.textOverflow = TextOverflow.ellipsis,
      this.maxLine =1});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight),
    );
  }
}