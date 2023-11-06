import 'package:cce_reddam_house/Screens/loginPage.dart';
import 'package:cce_reddam_house/Screens/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //user is logged in
        if (snapshot.hasData) {
          return HomePage();
        }
        
        //user is not logged in
        else {
          return LoginOrRegisterPage();
        }
      },
    ));
  }
}
