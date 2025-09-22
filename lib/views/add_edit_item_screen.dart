import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/models/password_model.dart';
import 'package:password_manager/state/firestore_bloc/firestore_bloc_dart_bloc.dart';
import 'package:password_manager/utils/app_color.dart';
import 'package:password_manager/utils/app_sizedbox.dart';
import 'package:password_manager/utils/app_sizes.dart';
import 'package:password_manager/utils/app_string.dart';
import 'package:password_manager/utils/validators.dart';
import 'package:password_manager/views/widgets/elevated_button.dart';
import 'package:password_manager/views/widgets/loading.dart';
import 'package:password_manager/views/widgets/search_filed_widget.dart';
import 'package:password_manager/views/widgets/text_feild.dart';
import 'package:password_manager/views/widgets/toast.dart';

class AddEditItemScreen extends StatefulWidget {
  final PasswordModel? passwordModel;
  final ItemAddEdit type;
  const AddEditItemScreen({
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
  final _formKey = GlobalKey<FormState>();
  late bool isEdit;

  @override
  void initState() {
    isEdit = widget.type == ItemAddEdit.edit ? true : false;
    isread = false;
    nameController = TextEditingController(
      text: widget.type == ItemAddEdit.add
          ? ""
          : (widget.passwordModel?.name ?? ""),
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
    return BlocListener<FirestoreBlocDartBloc, FirestoreBlocDartState>(
      listener: (context, state) {
        if(state is SuccessState){
           context.pop();
          flutterToast(msg: isEdit?AppStrings.updateMsg:AppStrings.addMsg);
          context.go("/home");
        }else if(state is LoadingState){
          loadingWidget(context);
        }
      },
      child: Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          title: TextWidget(
            text: !isEdit ? "Add vault" : widget.passwordModel?.name ?? "",
          ),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: kWhite),
          centerTitle: true,
          actions: isEdit
              ? [IconButton(onPressed: () {}, icon: Icon(Icons.edit))]
              : null,
        ),
        body: SafeArea(
          child: Padding(
            padding: screenPadding,
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 20,
                children: [
                  AppSizedBox.h70,
                  SearchFiledWidget(
                    validator: (value) {
                      return Validation.nameValidate(value: value);
                    },
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
                    validator: (value) {
                      return Validation.nameValidate(value: value);
                    },
                    icon: null,
                    labelText: "Password",
                    readOnly: isread,
                    controller: passwordController,
                  ),
                  SearchFiledWidget(
                    icon: null,
                    labelText: "User name",
                    readOnly: isread,
                    controller: usernameController,
                  ),
                  SearchFiledWidget(
                    maxLine: 4,
                    icon: null,
                    labelText: "Note",
                    readOnly: isread,
                    controller: noteController,
                  ),

                  //ElevatedWidget(text: isEdit?"Update":"Add New",)
                  ElevatedWidget(
                    text: isEdit ? "Update" : "Add New",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        log(" Validated--------------------");
                        final model = PasswordModel(
                          name: nameController.text.trim(),
                          password: passwordController.text.trim(),
                          note: noteController.text.trim(),
                          url: urlController.text.trim(),
                          userName: usernameController.text.trim(),
                        );

                        if (isEdit) {
                          model.id = widget.passwordModel!.id;
                          context.read<FirestoreBlocDartBloc>().add(
                            UpdateDataEvent(model: model),
                          );
                        } else {
                          context.read<FirestoreBlocDartBloc>().add(
                            AddDataEvent(model: model),
                          );
                        }
                      } else {
                        log("Not Validated--------------------");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum ItemAddEdit { edit, add }
