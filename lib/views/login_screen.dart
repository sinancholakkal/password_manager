
import 'package:flutter/material.dart';
import 'package:password_manager/utils/app_color.dart';
import 'package:password_manager/utils/app_sizedbox.dart';
import 'package:password_manager/utils/app_sizes.dart';
import 'package:password_manager/utils/app_string.dart';
import 'package:password_manager/views/widgets/card_top_session.dart';
import 'package:password_manager/views/widgets/cardlogin_form_session.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Center(
          child: Card(
            color: bgcard,
            child: SizedBox(
              width: Klwidth,
              height: Klheight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSizedBox.h20,
                  //Icon and greet------
                  CardTopSession(text: AppStrings.welcomeback,),
                  //CardLoginFormSession--------
                  CardLoginFormSession(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

