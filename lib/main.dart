import 'package:blog/core/theme/route.dart';
import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/auth/ui/bloc/auth_bloc.dart';
import 'package:blog/features/auth/ui/pages/signin_page.dart';
import 'package:blog/init_dependances.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => serviceLocator<AuthBloc>())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkTheme,
      home: const SigninPage(),
      routes: AppRout.appRoutes(context),
    );
  }
}
