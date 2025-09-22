import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/models/password_model.dart';
import 'package:password_manager/utils/app_color.dart';
import 'package:password_manager/utils/app_sizedbox.dart';
import 'package:password_manager/utils/app_sizes.dart';
import 'package:password_manager/views/add_edit_item_screen.dart';
import 'package:password_manager/views/widgets/search_filed_widget.dart';
import 'package:password_manager/views/widgets/text_feild.dart';

class ViewScreen extends StatefulWidget {
  final PasswordModel passwordModel;
  const ViewScreen({super.key, required this.passwordModel});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  late TextEditingController nameController;
  late TextEditingController urlController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController noteController;
  
  @override
  void initState() {
    nameController = TextEditingController(text: widget.passwordModel.name);
    urlController = TextEditingController(text: widget.passwordModel.url??"");
    usernameController = TextEditingController(text: widget.passwordModel.userName??"");
    passwordController = TextEditingController(text: widget.passwordModel.password);
    noteController = TextEditingController(text: widget.passwordModel.note??"");
    super.initState();
  }
  @override
  void dispose() {
    nameController.dispose();
    urlController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        title: TextWidget(text: "Instagram"),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: kWhite),
        centerTitle: true,
        actions: [IconButton(onPressed: () {
          context.push(
                      "/addedit",
                      extra: {'type': ItemAddEdit.edit, 'model': widget.passwordModel},
                    );
        }, icon: Icon(Icons.edit))],
      ),
      body: SafeArea(
        child: Padding(
          padding: screenPadding,
          child: Column(
            spacing: 20,
            children: [
              AppSizedBox.h70,
              SearchFiledWidget(
                icon: null,
                labelText: "Name",

                readOnly: true,
                controller: nameController,
              ),
              if(urlController.text.isNotEmpty)SearchFiledWidget(
                icon: null,
                labelText: "Url",
                readOnly: true,
                controller: urlController,
              ),
              SearchFiledWidget(
                icon: null,
                labelText: "Password",
                readOnly: true,
                controller: passwordController,
              )
              ,if(usernameController.text.isNotEmpty)SearchFiledWidget(
                icon: null,
                labelText: "User name",
                readOnly: true,
                controller: usernameController,
              ),
              if(noteController.text.isNotEmpty)SearchFiledWidget(
                maxLine: 4,
                icon: null,
                labelText: "Note",
                readOnly: true,
                controller: noteController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
