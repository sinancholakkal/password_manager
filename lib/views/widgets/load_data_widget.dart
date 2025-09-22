import 'package:flutter/material.dart';
import 'package:password_manager/utils/app_color.dart';

class LoadDataWidget extends StatelessWidget {
  const LoadDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: kWhite,
        strokeWidth: 3,
      ),
    );
  }
}