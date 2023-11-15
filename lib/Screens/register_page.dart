import 'package:cce_reddam_house/components/myButton.dart';
import 'package:cce_reddam_house/components/textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/drop_down.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  String selectedGrade = "8";
  String selectedClass = "R";
  String selectedHouse = "Connaught";

  final _gradeList = ["8", "9", "10", "11", "12"];
  final _classList = ["R", "E", "D", "A", "M", "H"];
  final _houseList = ["Connaught", "Leinster", "Munster", "Ulster"];

  //sign user up method
  void signUserUp() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //Check if password is confirmed
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      showErrorMessage("Passwords don't match");
      return;
    }

    //try creating a user
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'name': nameController.text.trim(),
        'surname': surnameController.text.trim(),
        'email': emailController.text.trim(),
        'grade': selectedGrade,
        'class': selectedClass,
        'house': selectedHouse,
      });

      //add user details
      // addUserDetails(
      //     nameController.text.trim(),
      //     surnameController.text.trim(),
      //     emailController.text.trim(),
      //     selectedGrade,
      //     selectedClass,
      //     selectedHouse);

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code.toLowerCase());
    }
  }

  Future addUserDetails(String name, String surname, String email, String grade,
      String classL, String house) async {
    await FirebaseFirestore.instance.collection('Users').add({
      'name': name,
      'surname': surname,
      'email': email,
      'grade': grade,
      'class': classL,
      'house': house,
    });
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

              //name
              MyTextField(
                controller: nameController,
                hintText: 'name',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              //surname
              MyTextField(
                controller: surnameController,
                hintText: 'surname',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              //grades Drop down
              CustomDropdown(
                items: _gradeList,
                value: selectedGrade,
                onChanged: (newValue) {
                  setState(() {
                    selectedGrade = newValue;
                  });
                },
                labelText: "Grade",
              ),

              const SizedBox(height: 10),

              //class drop down
              CustomDropdown(
                items: _classList,
                value: selectedClass,
                onChanged: (newValue) {
                  setState(() {
                    selectedClass = newValue;
                  });
                },
                labelText: "Class",
              ),

              const SizedBox(height: 10),

              //house drop down
              CustomDropdown(
                items: _houseList,
                value: selectedHouse,
                onChanged: (newValue) {
                  setState(() {
                    selectedHouse = newValue;
                  });
                },
                labelText: "House",
              ),

              const SizedBox(height: 10),

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

              //confirm password
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              MyButton(onTap: signUserUp, text: 'Sign Up'),
            ],
          ),
        ),
      )),
    );
  }
}
