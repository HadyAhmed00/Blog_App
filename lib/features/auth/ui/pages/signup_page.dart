import 'package:blog/core/common/widget/loader.dart';
import 'package:blog/core/theme/app_pallete.dart';
import 'package:blog/core/utiles/show_snackbar.dart';
import 'package:blog/features/auth/ui/bloc/auth_bloc.dart';
import 'package:blog/features/auth/ui/widgets/AuthButton.dart';
import 'package:blog/features/auth/ui/widgets/AuthField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static final route = "/signUp";

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Controlers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            //show snakbar
            showSnackBar(context, state.massage);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Loader();
          }
          return Expanded(
            child: Form(
              key: signupFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AuthField(
                    hint: "Enter Your Name",
                    lable: "Name",
                    icon: const Icon(Icons.person_2_outlined),
                    isPassword: false,
                    controller: _nameController,
                  ),
                  AuthField(
                    hint: "Enter Your Email",
                    lable: "Email",
                    icon: Icon(Icons.email_outlined),
                    isPassword: false,
                    controller: _emailController,
                  ),
                  AuthField(
                    hint: "Enter Your Password",
                    lable: "Password",
                    icon: Icon(Icons.lock_outline_rounded),
                    isPassword: true,
                    controller: _passwordController,
                  ),
                  AuthButton(
                    child: Text(
                      "SingUp",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    onClick: () {
                      context.read<AuthBloc>().add(
                        AuthSignUp(
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: RichText(
                      text: TextSpan(
                        text: "Already Have an Account ",
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "SingU p",
                            style: TextStyle(color: AppPallete.gradient2),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pop();
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text("Already Have an Account!"),
                  //     TextButton(
                  //       onPressed: () {},
                  //       child: const Text(
                  //         "Sign In",
                  //         style: TextStyle(color: AppPallete.gradient2),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
