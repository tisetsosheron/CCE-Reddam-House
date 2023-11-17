import 'dart:io';

import 'package:cce_reddam_house/Screens/teacher_home_page.dart';
import 'package:cce_reddam_house/api/firebase_api.dart';
import 'package:cce_reddam_house/components/elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class TimeTablePage extends StatefulWidget {
  final Function()? onTap;
  const TimeTablePage({super.key, this.onTap});

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  String? filePath;
  File? timetable;
  UploadTask? taskFile;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => timetable = File(path));
  }

  Future uploadFiles() async {
    if (timetable == null) return;

    if (timetable != null) {
      final fileName = basename(timetable!.path);
      final destination = 'timetables/$fileName';
      taskFile = FirebaseApi.uploadFile(destination, timetable!);
    }

    if (taskFile == null) return;
    final snapshot1 = await taskFile!.whenComplete(() {});
    final fileURL = await snapshot1.ref.getDownloadURL();

    await FirebaseFirestore.instance.collection("Timetables").add({
      'timetableURL': fileURL,
    });

    setState(() {
      timetable = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _fileName =
        timetable != null ? basename(timetable!.path) : 'No File Selected';
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Upload Timetable",
          ),
          backgroundColor: Color.fromARGB(255, 141, 122, 16),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TeacherHomePage(),
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
            'Please upload the timetable',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          ButtonWidget(
            icon: Icons.attach_file,
            text: "Select pdf",
            onClicked: selectFile,
          ),
          SizedBox(height: 8),
          Text(
            _fileName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          ButtonWidget(
            icon: Icons.upload,
            text: "Submit",
            onClicked: () => uploadFiles(),
          ),
        ]),
      ))),
    );
  }
}
