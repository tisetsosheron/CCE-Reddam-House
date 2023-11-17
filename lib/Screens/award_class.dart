import 'package:cce_reddam_house/Screens/award_page.dart';
import 'package:cce_reddam_house/Screens/displayClass.dart';
import 'package:flutter/material.dart';

import '../components/drop_down.dart';

class AwardClassPage extends StatefulWidget {
  final Function()? onTap;
  const AwardClassPage({super.key, this.onTap});

  @override
  State<AwardClassPage> createState() => _AwardClassPageState();
}

class _AwardClassPageState extends State<AwardClassPage> {
  //Controls
  String selectedGrade = "8";
  String selectedClass = "R";

  final _gradeList = ["8", "9", "10", "11", "12"];
  final _classList = ["R", "E", "D", "A", "M", "H"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Award Class'),
          backgroundColor: Color.fromARGB(255, 141, 122, 16),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AwardHoursPage(),
                ));
              })),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Please select a grade',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 20),
          //drop down for the type of grade
          CustomDropdown(
            items: _gradeList,
            value: selectedGrade,
            onChanged: (newValue) {
              setState(() {
                selectedGrade = newValue;
              });
            },
            labelText: "Please select a Grade",
          ),

          const SizedBox(height: 10),

          const Text(
            'Please select a class',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 20),
          //drop down for the type of class
          CustomDropdown(
            items: _classList,
            value: selectedClass,
            onChanged: (newValue) {
              setState(() {
                selectedClass = newValue;
              });
            },
            labelText: "Please select a class",
          ),

          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ClassDetailsPage(
                      selectedGrade: selectedGrade,
                      selectedClass: selectedClass,
                    ), // Replace HomePage with your actual homepage widget
                  ),
                );
              },
              child: Text('Get Learners'),
              style: ElevatedButton.styleFrom(
                primary:
                    Color.fromARGB(255, 141, 122, 16), // Change color as needed
              ),
            ),
          ),
          const SizedBox(height: 10),
        ]),
      ))),
    );
  }
}
