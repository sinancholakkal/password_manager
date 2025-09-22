import 'package:flutter/material.dart';
import 'package:password_manager/utils/app_color.dart';
import 'package:password_manager/utils/app_sizedbox.dart';
import 'package:password_manager/utils/app_sizes.dart';
import 'package:password_manager/utils/app_string.dart';
import 'package:password_manager/views/widgets/cardregister_form_session.dart';
import 'package:password_manager/views/widgets/card_top_session.dart';



class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Center(
          child: Card(
            color: bgcard,
            child: SizedBox(
              width: KRwidth,
              height: KRheight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSizedBox.h20,
                  //Icon and greet------
                  CardTopSession(text: AppStrings.createAnAcc,),
                  //CardLoginFormSession--------
                 CardRegisterFormSession()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}