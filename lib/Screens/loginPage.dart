import 'package:cce_reddam_house/components/myButton.dart';
import 'package:cce_reddam_house/components/square.dart';
import 'package:cce_reddam_house/components/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //try sign in

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      //Pop loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //Pop loading circle
      Navigator.pop(context);

      showErrorMessage(e.code.toLowerCase());
    }
  }

  //show error message
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(message,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 8, 35, 58))),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 100,
                child: Image.asset('lib/images/ReddamLogo.jpg'),
              ),

              const SizedBox(height: 30),

              const Text('Welcome Back!',
                  style: TextStyle(
                      color: Color.fromARGB(255, 19, 55, 85),
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),

              const SizedBox(height: 25),

              //email
              MyTextField(
                controller: emailController,
                hintText: 'Email Address',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              //password
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              ///forgot password
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text('Forgot Password?',
                          style:
                              TextStyle(color: Color.fromARGB(255, 18, 52, 78)))
                    ],
                  )),

              const SizedBox(height: 25),

              MyButton(
                onTap: signUserIn,
              ),

              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: const [
                    Expanded(
                        child: Divider(
                            thickness: 0.5,
                            color: Color.fromARGB(255, 15, 56, 90))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style:
                            TextStyle(color: Color.fromARGB(255, 13, 50, 80)),
                      ),
                    ),
                    Expanded(
                        child: Divider(thickness: 0.5, color: Colors.blueGrey))
                  ],
                ),
              ),

              const SizedBox(height: 50),

              //apple and google signs

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  //google button
                  SquareTile(imagePath: 'lib/images/google.jpg'),

                  SizedBox(height: 25),

                  //apple button
                  SquareTile(imagePath: 'lib/images/R.png'),
                ],
              ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No Account yet?'),
                  SizedBox(height: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Register here',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
