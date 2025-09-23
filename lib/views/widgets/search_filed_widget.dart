

import 'package:flutter/material.dart';
import 'package:password_manager/utils/app_color.dart';

class SearchFiledWidget extends StatelessWidget {
   SearchFiledWidget({
    super.key,
     this.labelText,
    this.borderColor,
    this.height,
    this.controller,
    this.validator,
    this.maxLine,
    this.readOnly,
    this.ontap,
    this.hintText,
    this.icon = const Icon(Icons.search),
    this.onChanged
  });
  final Widget? icon;
  final String? labelText;
  final Color? borderColor;
  final double? height;
  final TextEditingController? controller;
  String? Function(String?)? validator;
  final int? maxLine;
  final bool? readOnly;
  void Function()? ontap;
  final String? hintText;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      onTap: ontap,
      onChanged:onChanged,
      readOnly: readOnly??false,
      maxLines: maxLine,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      style: TextStyle(color: kWhite, height: height),
      decoration: InputDecoration(
        prefixIcon: icon,
        label: (labelText==null)?null:Text(labelText!),
        hintText: hintText,
        filled: true,
        fillColor: Color(0xFF262626),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor ?? kWhite),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor ?? kWhite),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor ?? kWhite),
        ),
      ),
    );
  }
}
