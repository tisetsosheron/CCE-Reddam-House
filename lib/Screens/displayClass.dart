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

  const ClassDetailsPage(
      {Key? key,
      required this.selectedGrade,
      required this.selectedClass,
      this.onTap});

  @override
  State<ClassDetailsPage> createState() => _ClassDetailsPage();
}

class _ClassDetailsPage extends State<ClassDetailsPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final usersCollection = FirebaseFirestore.instance.collection("Users");
  final hoursCollection =
      FirebaseFirestore.instance.collection('Hours'); //accessing
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
                      print("Submit button pressed");
                      updateFirestore();
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         AwardHoursPage(), // Replace HomePage with your actual homepage widget
                      //   ),
                      // );
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

  // Function to update Firestore with selected learners and hours
  void updateFirestore() async {
    // Get the selected learners
    print("Updating Firestore...");
    final selectedLearners = checkboxStates
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    // Get the number of hours from the text field
    final numberOfHours = int.tryParse(hoursController.text) ?? 0;

    // // Update Firestore for each selected learner
    // for (int index in selectedLearners) {
    //   final userData = (await usersCollection.doc(index.toString()).get()).data();

    //   // Add the student to the 'Hours' collection
    //   await hoursCollection.add({
    //     'name': userData?['name'],
    //     'surname': userData?['surname'],
    //     'total_hours': numberOfHours,
    //   });
    // }

    for (int index in selectedLearners) {
      final userDoc = await usersCollection.doc(index.toString()).get();

      if (userDoc.exists) {
        // Only update if the user document exists
        final userData = userDoc.data();

        // Add the student to the 'Hours' collection
        await hoursCollection.add({
          'name': userData?['name'] ?? '', // Default to an empty string if null
          'surname':
              userData?['surname'] ?? '', // Default to an empty string if null
          'total_hours': numberOfHours,
        });
      }
    }
    // Update Firestore for each selected learner
    // for (int index in selectedLearners) {
    //   final learnerDoc = await hoursCollection.doc(index.toString()).get();
    //   final currentTotalHours = learnerDoc.data()?['total_hours'] ?? 0;

    //   // Update the total_hours for the learner
    //   await hoursCollection.doc(index.toString()).update({
    //     'total_hours': currentTotalHours + numberOfHours,
    //   });
    // }

    // Navigate to the AwardHoursPage
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => AwardHoursPage(),
      ),
    );
    print("Firestore update completed.");
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
