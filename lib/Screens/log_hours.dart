import 'dart:io';

import 'package:cce_reddam_house/Screens/home_page.dart';
import 'package:cce_reddam_house/components/elevated_button.dart';
import 'package:cce_reddam_house/components/textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../api/firebase_api.dart';
import '../components/drop_down.dart';

class LogHoursPage extends StatefulWidget {
  final Function()? onTap;
  const LogHoursPage({super.key, this.onTap});

  @override
  State<LogHoursPage> createState() => _LogHoursPageState();
}

class _LogHoursPageState extends State<LogHoursPage> {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  final hoursController = TextEditingController();
  final receiptController = TextEditingController();
  String selectedHour = "";
  String selectedActivity = "";
  String? filePath;
  File? image;
  File? file;
  UploadTask? taskFile;
  UploadTask? taskImage;

  final _hoursList = ["", "Passive Hours", "Active Collection", "Active Time"];
  List<String> _activityList = [
    "",
    "Donations",
    "External",
    "Blankets",
    "Bottle tops and tags",
    "Eco bricks",
    "67 Hours",
    "Elandsvlei",
    "Jars of hope",
    "Sandwiches",
    "Santa shoebox",
    "Squares",
    "Tutoring"
  ];

  final Map<String, List<String>> _dependentActivities = {
    "Passive Hours": ["", "Donations", "External"],
    "Active Collection": [
      "",
      "Blankets",
      "Bottle tops and tags(max 50)",
      "Eco bricks(max 50)",
      "External"
    ],
    "Active Time": [
      "",
      "67 hours"
          "Elandsvlei",
      "External"
          "Jars of hope",
      "Sandwiches",
      "Santa shoebox",
      "Squares(50)",
      "Tutoring"
    ],
  };

  void _updateActivitiesList(String selectedHour) {
    setState(() {
      selectedActivity = _dependentActivities[selectedHour]![0];
      _activityList = _dependentActivities[selectedHour]!;
    });
  }

  bool isExternalActivitySelected() {
    return selectedActivity == "External";
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future selectPicture() async {
    final pickedPicture =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (pickedPicture == null) return;
    final path = pickedPicture.files.single.path!;

    setState(() {
      image = File(path);
    });
  }

  Future uploadFiles(BuildContext context) async {
    if (file == null && image == null) return;

    if (file != null) {
      final fileName = basename(file!.path);
      final destination = 'file/$fileName';
      taskFile = FirebaseApi.uploadFile(destination, file!);
    }

    if (image != null) {
      final imageName = basename(image!.path);
      final destination = 'image/$imageName';
      taskImage = FirebaseApi.uploadFile(destination, image!);
    }

    if (taskFile == null && taskImage == null) return;
    final snapshot1 = await taskFile!.whenComplete(() {});
    final fileURL = await snapshot1.ref.getDownloadURL();
    final snapshot2 = await taskImage!.whenComplete(() {});
    final imageURL = await snapshot2.ref.getDownloadURL();

    // Store the URLs and other information in Firestore
    await _firestore.collection('logged_hours').doc(currentUser.email!).set({
      'type_hour': selectedHour,
      'activity': selectedActivity,
      'hours': hoursController.text,
      'receipt_number': receiptController.text,
      'file_url': fileURL,
      'image_url': imageURL,
    });

    // Clear the text controllers and reset selected file and image after successful upload

    // Show the "Submitted" message in a Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Submitted'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Navigate to the homepage after the Snackbar is dismissed
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
    );
    selectedHour = "";
    selectedActivity = "";
    hoursController.clear();
    receiptController.clear();
    setState(() {
      file = null;
      image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    final imageName =
        image != null ? basename(image!.path) : 'No File Selected';
    return Scaffold(
      appBar: AppBar(
          title: Text("Log Hours", style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 3, 34, 59),
          leading: IconButton(
              icon: Icon(Icons.arrow_back), // Use the arrow back icon
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomePage(), // Navigate to HomePage
                ));
              })),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 20),
          // drop down for the type of hour
          CustomDropdown(
            items: _hoursList,
            value: selectedHour,
            onChanged: (newValue) {
              setState(() {
                selectedHour = newValue;
                _updateActivitiesList(newValue);
              });
            },
            labelText: "Please select an hour",
          ),
          const SizedBox(height: 10),

          // drop down for the type of activity
          CustomDropdown(
            items: _activityList,
            value: selectedActivity,
            onChanged: (newValue) {
              setState(() {
                selectedActivity = newValue;
              });
            },
            labelText: "Please select an activity",
          ),

          const SizedBox(height: 10),

          //textfield for the number of hours
          MyTextField(
            controller: hoursController,
            hintText: 'Enter number of hours',
            obscureText: false,
            enabled: isExternalActivitySelected(),
          ),
          const SizedBox(height: 10),

          //textfield for the receipt numbers
          MyTextField(
            controller: receiptController,
            hintText: 'Enter receipt number',
            obscureText: false,
          ),
          const SizedBox(height: 10),

          const Text(
            'Please upload the receipt',
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
          const SizedBox(
            height: 8,
          ),

          Text(
            fileName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),

          SizedBox(height: 10),

          const Text(
            'Please upload picture (Optional)',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),

          ButtonWidget(
            icon: Icons.attach_file,
            text: "Select Picture",
            onClicked: selectPicture,
          ),

          SizedBox(height: 8),
          Text(
            imageName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),

          SizedBox(height: 10),

          ButtonWidget(
            icon: Icons.upload,
            text: "Submit",
            onClicked: () => uploadFiles(context),
          ),
        ]),
      ))),
    );
  }
}
