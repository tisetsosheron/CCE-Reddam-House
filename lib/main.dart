import 'package:cce_reddam_house/Screens/authPage.dart';
import 'package:cce_reddam_house/Screens/home_page.dart';
import 'package:cce_reddam_house/Screens/register_page.dart';
import 'package:cce_reddam_house/Screens/uploadTimetable.dart';
import 'package:cce_reddam_house/Screens/award_page.dart';
import 'package:cce_reddam_house/Screens/award_class.dart';
import 'package:cce_reddam_house/Screens/award_grade.dart';
import 'package:cce_reddam_house/Screens/displayStudents.dart';
import 'package:cce_reddam_house/Screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: TeacherHomePage(),

    );
  }
}
