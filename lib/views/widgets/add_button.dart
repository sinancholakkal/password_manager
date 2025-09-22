import 'package:flutter/material.dart';
import 'package:password_manager/utils/app_color.dart';
import 'package:password_manager/views/widgets/text_feild.dart';

class AddButton extends StatelessWidget {
  void Function()? onTap;
  AddButton({super.key, this.onTap});

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
              Icon(Icons.add_circle_outline, color: kWhite, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
