import 'package:blog/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final String hint;
  final String lable;
  final Icon? icon;
  final bool isPassword;
  final TextEditingController controller;

  const AuthField({
    super.key,
    required this.hint,
    required this.lable,
    required this.isPassword,
    required this.controller,
    this.icon,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: TextFormField(
        obscureText: !_showPassword,
        decoration: authInputDecoration(
          hint: widget.hint,
          lable: widget.lable,
          icon: widget.icon,
          isPassword: widget.isPassword,
        ),
        controller: widget.controller,
      ),
    );
  }

  InputDecoration authInputDecoration({
    required final String hint,
    required final String lable,
    required final Icon? icon,
    required final bool isPassword,
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
      prefixIcon: icon,
      suffixIcon: isPassword
          ? IconButton(
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
              icon: _showPassword
                  ? Icon(Icons.remove_red_eye_outlined)
                  : Icon(Icons.visibility_off_outlined),
            )
          : null,
    );
  }
}
