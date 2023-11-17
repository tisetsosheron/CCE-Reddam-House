import 'package:flutter/material.dart';
import 'package:cce_reddam_house/Screens/teacher_home_page.dart';

class VerifyReceiptsPage extends StatefulWidget {
  final Function()? onTap;
  const VerifyReceiptsPage({super.key, this.onTap});

  @override
  State<VerifyReceiptsPage> createState() => _VerifyReceiptsPageState();
}

class _VerifyReceiptsPageState extends State<VerifyReceiptsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Notifications"),
          backgroundColor: Color.fromARGB(255, 141, 122, 16),
          leading: IconButton(
              icon: Icon(Icons.arrow_back), // Use the arrow back icon
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      TeacherHomePage(), // Navigate to HomePage
                ));
              })),
    );
  }
}
