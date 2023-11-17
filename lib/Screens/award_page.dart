import 'package:cce_reddam_house/Screens/award_grade.dart';
import 'package:cce_reddam_house/Screens/profile_page.dart';
import 'package:cce_reddam_house/Screens/loginPage.dart';
import 'package:cce_reddam_house/Screens/award_class.dart';
import 'package:cce_reddam_house/Screens/award_grade.dart';
import 'package:cce_reddam_house/Screens/displayStudents.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cce_reddam_house/components/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AwardHoursPage extends StatefulWidget {
  final Function()? onTap;
  const AwardHoursPage({super.key, this.onTap});

  @override
  State<AwardHoursPage> createState() => _AwardHoursPageState();
}

class _AwardHoursPageState extends State<AwardHoursPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Choose Class/Grade'),
          backgroundColor: Color.fromARGB(255, 141, 122, 16),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginPage(),
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
            'Please select whether to award a grade or class',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AwardClassPage(),
                  ),
                );
              },
              child: Text('Class'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 141, 122, 16),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AwardGradePage(),
                  ),
                );
              },
              child: Text('Grade'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 141, 122, 16),
              ),
            ),
          ),
        ]),
      ))),
    );
  }
}
