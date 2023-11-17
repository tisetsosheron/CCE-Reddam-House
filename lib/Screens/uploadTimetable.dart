
import 'package:cce_reddam_house/Screens/loginPage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TimeTablePage extends StatefulWidget {
  final Function()? onTap;
  const TimeTablePage({super.key, this.onTap});

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  String? filePath;

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Upload Timetable"),
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
            'Please upload the timetable',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),

          //button for uploading the receipt
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: _selectFile,
              child: Text('Upload TIMETABLE'),
              style: ElevatedButton.styleFrom(
                primary:
                    Color.fromARGB(255, 141, 122, 16), // Match app bar color
              ),
            ),
          ),
          if (filePath != null) // Show selected file path
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Selected file: $filePath',
                style: TextStyle(color: Colors.black),
              ),
            ),

          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => 
                    LoginPage(), 
                  ),
                );
              },
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                primary:
                  Color.fromARGB(255, 141, 122, 16), 
              ),
            ),

          ),




        ]),
      ))),
    );
  }
}
