import 'package:flutter/material.dart';
import 'package:password_manager/utils/app_color.dart';
import 'package:password_manager/views/widgets/text_feild.dart';


class CardTopSession extends StatelessWidget {
  final String text;
  const CardTopSession({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextWidget(
          text: text,
          color: kWhite,
          fontWeight: FontWeight.bold,
          size: 26,
        );
  }
}
