import 'package:cce_reddam_house/components/myButton.dart';
import 'package:cce_reddam_house/components/textField.dart';
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
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  String selectedGrade = "8";
  String selectedClass = "R";
  String selectedHouse = "Connaught";


  var _gradeList = ["8", "9", "10", "11", "12"];
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

    //try creating a user

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

              const SizedBox(height: 30),

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



              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //   child: DropdownButtonFormField(
              //     // Initial Value
              //     value: dropdownvalue,
              //     // Down Arrow Icon
              //     // icon: const Icon(Icons.keyboard_arrow_down),

              //     // Array list of items
              //     items: _gradeList.map((String items) {
              //       return DropdownMenuItem(
              //         value: items,
              //         child: Text(items),
              //       );
              //     }).toList(),
              //     // After selecting the desired option,it will
              //     // change button value to selected value
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         dropdownvalue = newValue!;
              //       });
              //     },

              //     icon: const Icon(Icons.arrow_drop_down_circle,
              //         color: Color.fromARGB(255, 141, 122, 16)),
              //     decoration: const InputDecoration(
              //         labelText: "Grade", border: OutlineInputBorder()),
                    
              //   ),
              // ),

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

              const SizedBox(height: 25),

              MyButton(
                onTap: signUserUp,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
