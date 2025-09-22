import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/state/auth_bloc/auth_bloc.dart';
import 'package:password_manager/utils/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      floatingActionButton: FloatingActionButton(onPressed: () {
        context.read<AuthBloc>().add(SignOutEvent());
      },child: Icon(Icons.logout),),
    );
  }
}