import 'package:cce_reddam_house/Screens/register_page.dart';
import 'package:cce_reddam_house/Screens/teacher_register.dart';
import 'package:cce_reddam_house/components/myButton.dart';
import 'package:cce_reddam_house/components/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'forgotPassword.dart';

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

      // Navigate to the homepage after successful login
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomePage()),
      // );
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

              // const Text('Welcome Back!',
              //     style: TextStyle(
              //         color: Color.fromARGB(255, 19, 55, 85),
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold)),

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
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          }));
                        },
                        child: const Text('Forgot Password?',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )),

              const SizedBox(height: 25),

              MyButton(
                onTap: signUserIn,
                text: 'Login',
              ),

              const SizedBox(height: 25),

              //apple and google signs

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: const [
              //     //google button
              //     SquareTile(imagePath: 'lib/images/google.jpg'),

              //     SizedBox(height: 25),

              //     //apple button
              //     SquareTile(imagePath: 'lib/images/R.png'),
              //   ],
              // ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Student? ', style: TextStyle(fontSize: 15)),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RegisterPage(); // Navigate to student registration page
                      }));
                    },
                    child: const Text(
                      'Register here',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                            thickness: 0.5,
                            color: Color.fromARGB(255, 15, 56, 90))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or',
                        style:
                            TextStyle(color: Color.fromARGB(255, 13, 50, 80)),
                      ),
                    ),
                    Expanded(
                        child: Divider(thickness: 0.5, color: Colors.blueGrey))
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Teacher? ', style: TextStyle(fontSize: 15)),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return TeacherRegisterPage(); // Navigate to student registration page
                      }));
                    },
                    child: const Text(
                      'Register here',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
