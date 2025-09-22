import 'package:flutter/material.dart';
import 'package:password_manager/models/password_model.dart';
import 'package:password_manager/utils/app_color.dart';
import 'package:password_manager/utils/app_sizedbox.dart';
import 'package:password_manager/utils/app_sizes.dart';
import 'package:password_manager/views/widgets/search_filed_widget.dart';
import 'package:password_manager/views/widgets/text_feild.dart';

class AddEditItemScreen extends StatefulWidget {
  final PasswordModel? passwordModel;
  final ItemAddEdit type;
  AddEditItemScreen({
    super.key,
    required this.passwordModel,
    required this.type,
  });

  @override
  State<AddEditItemScreen> createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends State<AddEditItemScreen> {
  late TextEditingController nameController;
  late TextEditingController urlController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController noteController;
  late bool isread;

  @override
  void initState() {
    isread = widget.type==ItemAddEdit.edit?false:true;
    nameController = TextEditingController(
      text: widget.type == ItemAddEdit.add
          ? ""
          : (widget.passwordModel?.name??""),
    );
    urlController = TextEditingController(
      text: widget.type == ItemAddEdit.add
          ? ""
          : widget.passwordModel?.url ?? "",
    );
    usernameController = TextEditingController(
      text: widget.type == ItemAddEdit.add
          ? ""
          : widget.passwordModel?.userName ?? "",
    );
    passwordController = TextEditingController(
      text: widget.type == ItemAddEdit.add
          ? ""
          : widget.passwordModel?.password ?? "",
    );
    noteController = TextEditingController(
      text: widget.type == ItemAddEdit.add
          ? ""
          : widget.passwordModel?.note ?? "",
    );
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
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
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

                readOnly: isread,
                controller: nameController,
              ),
                SearchFiledWidget(
                  icon: null,
                  labelText: "Url",
                  readOnly: isread,
                  controller: urlController,
                ),
              SearchFiledWidget(
                icon: null,
                labelText: "Password",
                readOnly: isread,
                controller: nameController,
              ),
                SearchFiledWidget(
                  icon: null,
                  labelText: "User name",
                  readOnly: isread,
                  controller: usernameController,
                ),
                SearchFiledWidget(
                  icon: null,
                  labelText: "Note",
                  readOnly: isread,
                  controller: noteController,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ItemAddEdit { edit, add }
