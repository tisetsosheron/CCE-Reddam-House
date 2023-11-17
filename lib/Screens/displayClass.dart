// student_details_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cce_reddam_house/Screens/award_page.dart';
import 'package:cce_reddam_house/components/text_box.dart';
import 'package:cce_reddam_house/components/textField.dart';
import 'package:cce_reddam_house/components/myButton.dart';

class ClassDetailsPage extends StatefulWidget {
  final String selectedGrade;
  final String selectedClass;
  final Function()? onTap;

  const ClassDetailsPage({Key? key,
   required this.selectedGrade,
   required this.selectedClass,
  this.onTap});

  @override
  State<ClassDetailsPage> createState() => _ClassDetailsPage();
}

class _ClassDetailsPage extends State<ClassDetailsPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final usersCollection = FirebaseFirestore.instance.collection("Users");
  late List<bool> checkboxStates = []; //List to store checkbox states
  final hoursController =
      TextEditingController(); //for entering number of hours

  @override
  void initState() {
    super.initState();
    checkboxStates = []; // Initialize the list in initState
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Award Page"),
          backgroundColor: Color.fromARGB(255, 141, 122, 16),
          leading: IconButton(
              icon: Icon(Icons.arrow_back), // Use the arrow back icon
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      AwardHoursPage(), // Navigate to HomePage
                ));
              })),
      body: StreamBuilder<QuerySnapshot>(
        // stream: usersCollection.snapshots(),
        stream: usersCollection
            .where('grade', isEqualTo: widget.selectedGrade)
            .where('class', isEqualTo: widget.selectedClass)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!.docs;

            //Initialize the checkbox states list based on the number of users
            if (checkboxStates.isEmpty) {
              checkboxStates = List.generate(users.length, (index) => false);
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final userData =
                          users[index].data() as Map<String, dynamic>;

                      return TextBox(
                        name: userData['name'],
                        surname: userData['surname'],
                        isChecked: checkboxStates[index],
                        onCheckboxChanged: (bool? value) {
                          setState(() {
                            checkboxStates[index] = value ?? false;
                          });
                        },
                      );
                    },
                  ),
                ),

                //const SizedBox(height: 10),
                // Text field for the number of hours
                MyTextField(
                  controller: hoursController,
                  hintText: 'Enter number of hours',
                  obscureText: false,
                ),

                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              AwardHoursPage(), // Replace HomePage with your actual homepage widget
                        ),
                      );
                    },
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 141, 122, 16), // Change color as needed
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  final String name;
  final String surname;
  final bool isChecked;
  final ValueChanged<bool?>? onCheckboxChanged;

  const TextBox({
    required this.name,
    required this.surname,
    this.isChecked = false,
    this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 3, 34, 59)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: TextStyle(color: Color.fromARGB(255, 3, 34, 59)),
          ),
          Row(
            children: [
              Text(
                name,
                style: TextStyle(color: Color.fromARGB(255, 3, 34, 59)),
              ),
              const SizedBox(
                  width: 8.0), // Add some spacing between name and surname
              Text(
                surname,
                style: TextStyle(color: Color.fromARGB(255, 3, 34, 59)),
              ),
              const SizedBox(width: 8.0), // Add some spacing
              Checkbox(
                value: isChecked,
                onChanged: onCheckboxChanged,
                activeColor: Color.fromARGB(255, 141, 122, 16),
                checkColor: Color.fromARGB(255, 255, 255, 255),
              ),
              // if (isChecked)
              //   Icon(
              //     Icons.check,
              //     color: Colors.black, // Customize the color if needed
              //   ),
            ],
          ),
        ],
      ),
    );
  }
}
