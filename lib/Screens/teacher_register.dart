import 'package:cce_reddam_house/Screens/teacher_homepage.dart';
import 'package:cce_reddam_house/components/myButton.dart';
import 'package:cce_reddam_house/components/textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherRegisterPage extends StatefulWidget {
  final Function()? onTap;

  const TeacherRegisterPage({super.key, this.onTap});

  @override
  State<TeacherRegisterPage> createState() => _TeacherRegisterPageState();
}

class _TeacherRegisterPageState extends State<TeacherRegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final referenceController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();

  void signTeacherUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordController.text != confirmPasswordController.text) {
        throw FirebaseAuthException(
          code: 'passwords-do-not-match',
          message: "Passwords don't match",
        );
      }

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'name': nameController.text.trim(),
        'surname': surnameController.text.trim(),
        'email': emailController.text.trim(),
        'reference': referenceController.text.trim(),
        'role': 'Teacher',
      });

      Navigator.pop(context);
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TeacherHomePage()),
    ); // Close loading dialog
      // Optionally, show a success message or navigate to a new page.
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close loading dialog
      String errorMessage = getErrorMessage(e.code);
      showErrorMessage(errorMessage);
    }


  }

  String getErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      // Add more cases based on your needs.
      default:
        return 'An error occurred. Please try again.';
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Color.fromARGB(255, 8, 35, 58)),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 141, 122, 16),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 80,
                  child: Image.asset('lib/images/ReddamLogo.jpg'),
                ),

                const SizedBox(height: 20),

                // Name
                MyTextField(
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // Surname
                MyTextField(
                  controller: surnameController,
                  hintText: 'Surname',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // Email
                MyTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                  obscureText: false,
                ),

                const SizedBox(height: 10),
                MyTextField(
                  controller: referenceController,
                  hintText: 'Reference Number',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // Password
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // Confirm Password
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // Sign Up Button
                MyButton(onTap: signTeacherUp, text: 'Sign Up'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
