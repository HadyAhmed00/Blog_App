import 'dart:ffi';

import 'package:blog/core/common/cubits/user_login/user_login_cubit.dart';
import 'package:blog/core/theme/route.dart';
import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/auth/ui/bloc/auth_bloc.dart';
import 'package:blog/features/auth/ui/pages/signin_page.dart';
import 'package:blog/init_dependances.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/blog/ui/pages/blog_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<UserLoginCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkTheme,
      home: BlocSelector<UserLoginCubit, UserLoginState, bool>(
        selector: (state) {
          return state is UserIsLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return BlogPage();
          } else {
            return SigninPage();
          }
        },
      ),
      routes: AppRout.appRoutes(context),
    );
  }
}
