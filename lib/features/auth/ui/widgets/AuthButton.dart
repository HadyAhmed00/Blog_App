import 'package:blog/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onClick;

  const AuthButton({super.key, required this.child,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppPallete.gradient1,
              AppPallete.gradient2,
              AppPallete.gradient3,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight
          ),
          borderRadius: BorderRadius.all(Radius.circular(7))
        ),
        child: ElevatedButton(
          onPressed: onClick,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent
          ),
          child: child,
        ),
      ),
    );
  }
}
