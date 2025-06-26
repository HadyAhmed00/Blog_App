import 'package:blog/features/auth/ui/pages/signin_page.dart';
import 'package:blog/features/auth/ui/pages/signup_page.dart';
import 'package:blog/features/blog/ui/pages/add_blog_page.dart';
import 'package:flutter/cupertino.dart';

class AppRout {
  static Map<String, WidgetBuilder> appRoutes(var context) => {
    SigninPage.route: (context) => SigninPage(),
    SignupPage.route: (context) => SignupPage(),
    AddBlogPage.route: (context) => AddBlogPage(),
  };
}
