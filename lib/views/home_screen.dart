import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/state/auth_bloc/auth_bloc.dart';
import 'package:password_manager/utils/app_color.dart';
import 'package:password_manager/utils/app_sizedbox.dart';
import 'package:password_manager/utils/app_sizes.dart';
import 'package:password_manager/utils/app_string.dart';
import 'package:password_manager/views/widgets/search_filed_widget.dart';
import 'package:password_manager/views/widgets/text_feild.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Padding(
        padding: screenPadding,
        child: Column(
          children: [
            AppSizedBox.h120,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Const text vault------------
                TextWidget(
                  text: AppStrings.vault,
                  fontWeight: FontWeight.bold,
                  size: 44,
                ),
                //AddButton---------------
                AddButton(),
              ],
            ),
            //search field---------
            SearchFiledWidget(
              readOnly: true,
              hintText: "Search vault",
              borderColor: Color(0xFF0D0D0D),
              
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AuthBloc>().add(SignOutEvent());
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  void Function()? onTap;
   AddButton({
    super.key,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 84,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFF1E6F9F),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              TextWidget(
                text: "Add",
                size: 14,
                fontWeight: FontWeight.w700,
                color: kWhite,
              ),
              Icon(
                Icons.add_circle_outline,
                color: kWhite,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
