import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/state/auth_bloc/auth_bloc.dart';
import 'package:password_manager/utils/app_string.dart';
import 'package:password_manager/utils/validators.dart';
import 'package:password_manager/views/widgets/elevated_button.dart';
import 'package:password_manager/views/widgets/loading.dart';
import 'package:password_manager/views/widgets/rich_text_widget.dart';
import 'package:password_manager/views/widgets/text_form_widget.dart';
import 'package:password_manager/views/widgets/toast.dart';

class CardRegisterFormSession extends StatefulWidget {
  const CardRegisterFormSession({super.key});

  @override
  State<CardRegisterFormSession> createState() =>
      _CardRegisterFormSessionState();
}

class _CardRegisterFormSessionState extends State<CardRegisterFormSession> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final conformPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    conformPasswordController.dispose();
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
          flutterToast(msg: AppStrings.createdAcc);
          context.go("/home");
        } else if (state is AuthErrorState) {
          context.pop();
          flutterToast(msg: state.errorMessage);
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            spacing: 22,
            children: [
              //Email field---
              TextFormFieldWidget(
                labeltext: AppStrings.email,
                controller: emailController,
                validator: (p0) {
                  return Validation.emailValidation(p0);
                },
              ),

              //Password field-------
              TextFormFieldWidget(
                type: TypeOfField.password,
                labeltext: AppStrings.password,
                controller: passwordController,
                validator: (p0) {
                  return Validation.passWordValidation(p0);
                },
              ),
              //Conform paswrd field--------
              TextFormFieldWidget(
                type: TypeOfField.password,
                labeltext: AppStrings.conformpassword,
                controller: conformPasswordController,
                validator: (p0) {
                  return Validation.conformPasswordValidation(
                    conformPassword: conformPasswordController.text,
                    password: passwordController.text,
                    value: p0,
                  );
                },
              ),

              //Button for register---------------
              ElevatedWidget(
                text: AppStrings.register,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    log(" Validated--------------------");
                    context.read<AuthBloc>().add(
                      SignUpEvent(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ),
                    );
                  } else {
                    log("Not Validated--------------------");
                  }
                },
              ),
              //Rich text widget-----------
              RichTextWidget(
                text: AppStrings.alreadycc,
                eventText: " ${AppStrings.login}",
                onTap: () {
                  context.go("/login");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
