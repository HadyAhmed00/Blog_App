import 'package:blog/core/common/widget/loader.dart';
import 'package:blog/core/utiles/show_snackbar.dart';
import 'package:blog/features/auth/ui/bloc/auth_bloc.dart';
import 'package:blog/features/auth/ui/pages/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_pallete.dart';
import '../widgets/AuthButton.dart' show AuthButton;
import '../widgets/AuthField.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  static final String route = "/signIn";

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final sinInFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthFailed){
            showSnackBar(context, state.massage);
          }
        },
        builder: (context, state) {
          if(state is AuthLoading){
            return Loader();
          }
          return Form(
            key: sinInFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Text(
                    "SignIn",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AuthField(
                  hint: "Enter Your Email",
                  lable: "Email",
                  icon: const Icon(Icons.email_outlined),
                  isPassword: false,
                  controller: _emailController,
                ),
                AuthField(
                  hint: "Enter Your Password",
                  lable: "Password",
                  icon: const Icon(Icons.lock_outline_rounded),
                  isPassword: true,
                  controller: _passwordController,
                ),
                AuthButton(
                  child: const Text(
                    "SingIn",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  onClick: () {
                    context.read<AuthBloc>().add(
                      AuthSignIn(
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
                      text: "Don't Have an account? ",
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "SingUp",
                          style: TextStyle(color: AppPallete.gradient2),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamed(SignupPage.route);
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
          );
        },
      ),
    );
  }
}
