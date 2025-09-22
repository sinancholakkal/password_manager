import 'package:flutter/material.dart';
import 'package:password_manager/utils/app_color.dart';
import 'package:password_manager/utils/app_string.dart';
import 'package:password_manager/views/widgets/custom_button.dart';

Future<dynamic> showDiolog({
  required BuildContext context,
  required String title,
  required String content,
  void Function()? cancelTap,
  void Function()? confirmTap
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          //Confirm button
          CustomButton(text: AppStrings.conform,width: 110,height: 40,color: KBcolor,onTap: confirmTap,),
          //Cancel button
          CustomButton(text: AppStrings.cancel,onTap: cancelTap,),
        ],
      );
    },
  );
}

