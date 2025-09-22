import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/state/auth_bloc/auth_bloc.dart';
import 'package:password_manager/utils/app_color.dart';
import 'package:password_manager/utils/app_string.dart';
import 'package:password_manager/utils/validators.dart';
import 'package:password_manager/views/widgets/elevated_button.dart';
import 'package:password_manager/views/widgets/loading.dart';
import 'package:password_manager/views/widgets/rich_text_widget.dart';
import 'package:password_manager/views/widgets/text_feild.dart';
import 'package:password_manager/views/widgets/text_form_widget.dart';
import 'package:password_manager/views/widgets/toast.dart';

class CardLoginFormSession extends StatefulWidget {
  const CardLoginFormSession({super.key});

  @override
  State<CardLoginFormSession> createState() => _CardLoginFormSessionState();
}

class _CardLoginFormSessionState extends State<CardLoginFormSession> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          loadingWidget(context);
        } else if (state is AuthSuccessState) {
          context.pop();
          flutterToast(msg: AppStrings.lSuccessMsg);
          context.go("/home");
        } else if (state is AuthErrorState) {
          context.pop();
          flutterToast(msg: state.errorMessage);
        }},
        child:Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              spacing: 22,
              children: [
                TextFormFieldWidget(
                  labeltext: AppStrings.email,
                  controller: emailController,
                  prefixIcon: Icons.email_outlined,
                  validator: (p0) {
                    return Validation.emailValidation(p0);
                  },
                ),
                TextFormFieldWidget(
                  type: TypeOfField.password,
                  labeltext: AppStrings.password,
                  controller: passwordController,
                  prefixIcon: Icons.lock_outline_rounded,
                  validator: (p0) {
                    return Validation.passWordValidation(p0);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.lock_outline, color: kBlue, size: 18),

                    TextWidget(
                      text: AppStrings.forgotPassword,
                      color: kBlue,
                      size: 16,
                    ),
                  ],
                ),
                //Button for navigation---------------
                ElevatedWidget(
                  text: AppStrings.login,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log(" Validated--------------------");
                      context.read<AuthBloc>().add(
                        SignInEvent(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ),
                      );
                      log("Event called");
                    } else {
                      log("Not Validated--------------------");
                    }
                  },
                ),
                //Rich text widget-----------
                RichTextWidget(
                  text: AppStrings.dontaccount,
                  eventText: " ${AppStrings.register}",
                  onTap: () {
                    context.go("/register");
                  },
                ),
              ],
            ),
          ),
        )
    
      
    );
  }
}
