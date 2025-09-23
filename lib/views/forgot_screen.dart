import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/state/auth_bloc/auth_bloc.dart';
import 'package:password_manager/utils/app_color.dart';
import 'package:password_manager/utils/app_sizes.dart';
import 'package:password_manager/utils/app_string.dart';
import 'package:password_manager/views/widgets/text_feild.dart';
import 'package:password_manager/views/widgets/text_form_widget.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  late TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text:"Forgot Password"),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: kWhite),
      ),
      backgroundColor: bgcolor,
      body: Padding(
        padding: screenPadding,
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormFieldWidget(controller: emailController, validator: null,labeltext: AppStrings.email,),
            ElevatedButton(onPressed: (){
              context.read<AuthBloc>().add(ForgotEvent(email: emailController.text.trim()));
            }, child: Text("Reset"))
          ],
        ),
      ),
    );
  }
}