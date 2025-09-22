import 'package:flutter/material.dart';
import 'package:password_manager/utils/app_color.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLine;
  final IconData? prefixIcon;
  final String labeltext;

  final TypeOfField type;
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.validator,
    this.maxLine = 1,
    this.prefixIcon,
    this.labeltext = "",
    this.type = TypeOfField.normal,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.type == TypeOfField.normal ? false : hide,
      maxLines: widget.maxLine,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      controller: widget.controller,

      decoration: InputDecoration(
        suffixIcon: (widget.type == TypeOfField.password)
            ? IconButton(
                onPressed: () {
                  setState(() {
                    hide = !hide;
                  });
                },
                icon: Icon(hide ? Icons.visibility_off : Icons.visibility),
              )
            : null,
        label: Text(widget.labeltext),
        labelStyle: TextStyle(color: kBlue,fontWeight: FontWeight.bold),
        prefixIcon: (widget.prefixIcon != null)
            ? Icon(widget.prefixIcon)
            : null,
        border: InputBorder.none,
        filled: true,
        fillColor: kWhite,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

enum TypeOfField { normal, password }
