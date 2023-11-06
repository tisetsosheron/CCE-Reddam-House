import 'package:cce_reddam_house/Screens/register_page.dart';
import 'package:flutter/material.dart';

import 'loginPage.dart';


class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;

  //toggle between  login and register page

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {

      return LoginPage(
        onTap: togglePages,
      );
    } else{
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
