import 'package:flutter/material.dart';
import 'package:cce_reddam_house/Screens/home_page.dart';
import 'package:cce_reddam_house/components/myButton.dart';

class LearnersTtablePage extends StatefulWidget {
  LearnersTtablePage({super.key});

  @override
  State<LearnersTtablePage> createState() => _LearnersTtablePageState();
}

class _LearnersTtablePageState extends State<LearnersTtablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("View TimeTable"),
            backgroundColor: Color.fromARGB(255, 141, 122, 16),
            leading: IconButton(
                icon: Icon(Icons.arrow_back), // Use the arrow back icon
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => HomePage(), // Navigate to HomePage
                  ));
                })),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("To view the timetable, click on the button below:",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 16.0,
                    ))),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          HomePage(), // Replace HomePage with your actual homepage widget
                    ),
                  );
                },
                child: Text('View Timetable'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(
                      255, 141, 122, 16), // Change color as needed
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "To download the timetable, click on the button below:",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 16.0,
                    ))),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          HomePage(), // Replace HomePage with your actual homepage widget
                    ),
                  );
                },
                child: Text('Download Timetable'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(
                      255, 141, 122, 16), // Change color as needed
                ),
              ),
            ),
          ],
        )));
  }
}
