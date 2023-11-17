import 'package:cce_reddam_house/components/text_box_studentD.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> studentData;

  const StudentDetailsPage({Key? key, required this.studentData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 34, 59),
        title: const Text(
          'Student Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBoxStudentD(
              text: 'Name: ${studentData['name']}',
            ),
            TextBoxStudentD(text: 'Email: ${studentData['email']}'),
            TextBoxStudentD(
              text: 'Grade: ${studentData['grade']}',
            ),
            TextBoxStudentD(
              text: 'Class: ${studentData['class']}',
            ),
            TextBoxStudentD(
              text: 'House: ${studentData['house']}',
            ),
            SizedBox(height: 20),
            Text('Logged Hours:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            // Use StreamBuilder to get the logged hours for the student
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('logged_hours')
                  .doc(studentData['email'])
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                // Access the data for the specific student
                var studentHoursData =
                    snapshot.data!.data() as Map<String, dynamic>;

                // Access individual fields if needed
                var typeHour = studentHoursData['type_hour'];
                var activity = studentHoursData['activity'];
                var hours = studentHoursData['hours'];

                // Display the details as needed
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBoxStudentD(text: 'Type Hour: $typeHour'),
                    TextBoxStudentD(text: 'Activity: $activity'),
                    TextBoxStudentD(text:'Hours: $hours'),

                    // Add more fields as needed
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
