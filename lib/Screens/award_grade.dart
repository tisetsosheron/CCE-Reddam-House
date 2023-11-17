import 'package:cce_reddam_house/Screens/authPage.dart';
import 'package:cce_reddam_house/Screens/displayStudents.dart';
import 'package:cce_reddam_house/Screens/register_page.dart';
import 'package:cce_reddam_house/Screens/loginPage.dart';
import 'package:cce_reddam_house/Screens/uploadTimetable.dart';
import 'package:cce_reddam_house/Screens/award_page.dart';
import 'package:cce_reddam_house/Screens/award_class.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../components/drop_down.dart';

class AwardGradePage extends StatefulWidget {
  final Function()? onTap;
  const AwardGradePage({super.key, this.onTap});

  @override
  State<AwardGradePage> createState() => _AwardGradePageState();
}

class _AwardGradePageState extends State<AwardGradePage> {
  //Controls
  String selectedGrade = "8";
  

  final _gradeList = ["8", "9", "10", "11", "12"];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Award Grade'),
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
          Text(
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




          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        StudentDetailsPage(selectedGrade: selectedGrade), // Replace HomePage with your actual homepage widget
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
