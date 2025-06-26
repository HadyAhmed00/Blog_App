import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String lable;

  const BlogEditor({
    super.key,
    required this.controller,
    required this.hint,
    required this.lable,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: authInputDecoration(lable: lable, hint: hint),
      maxLines: null,
    );
  }

  InputDecoration authInputDecoration({
    required final String hint,
    required final String lable,
  }) {
    return InputDecoration(
      hintText: hint,
      labelText: lable,
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: AppPallete.borderColor),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppPallete.borderColor),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppPallete.gradient2),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
