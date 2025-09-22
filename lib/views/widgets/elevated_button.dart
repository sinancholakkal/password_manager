import 'package:flutter/material.dart';
import 'package:password_manager/utils/app_color.dart';

class ElevatedWidget extends StatelessWidget {
  final String text;
  Function()? onPressed;
   ElevatedWidget({
    super.key,
    required this.text,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: KBcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(text,style: TextStyle(color: kWhite),),
      ),
    );
  }
}
