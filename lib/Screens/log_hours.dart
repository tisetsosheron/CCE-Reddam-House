import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cce_reddam_house/components/myButton.dart';
import 'package:cce_reddam_house/components/textField.dart';
import 'package:cce_reddam_house/Screens/home_page.dart';
import 'package:cce_reddam_house/Screens/loginPage.dart';
import '../components/drop_down.dart';

class LogHoursPage extends StatefulWidget {
  final Function()? onTap;
  const LogHoursPage({super.key, this.onTap});

  @override
  State<LogHoursPage> createState() => _LogHoursPageState();
}

class _LogHoursPageState extends State<LogHoursPage> {
  final hoursController = TextEditingController();
  final receiptController = TextEditingController();
  String selectedHour = "Passive Hours";
  String selectedActivity = "Donations";
  String? filePath;

  final _hoursList = ["Passive Hours", "Active Collection", "Active Time"];
  final _activityList = [
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

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Receipt Uploaded Successfully'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Log Hours"),
          backgroundColor: Color.fromARGB(255, 141, 122, 16),
          leading: IconButton(
              icon: Icon(Icons.arrow_back), // Use the arrow back icon
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginPage(), // Navigate to HomePage
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
          Center(
            //add a quote
            child: Text(
              '"Everyone can be great, because everyone can serve"- Martin Luther King, Jr.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          //drop down for the type of hour
          CustomDropdown(
            items: _hoursList,
            value: selectedHour,
            onChanged: (newValue) {
              setState(() {
                selectedHour = newValue;
              });
            },
            labelText: "Please select an hour",
          ),
          const SizedBox(height: 10),

          //drop down for the type of activity
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
          ),
          const SizedBox(height: 10),

          //textfield for the receipt numbers
          MyTextField(
            controller: receiptController,
            hintText: 'Enter receipt number',
            obscureText: false,
          ),
          const SizedBox(height: 10),

          Text(
            'Please upload the receipt',
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
              child: Text('Upload PDF'),
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
                        LoginPage(), // Replace HomePage with your actual homepage widget
                  ),
                );
              },
              child: Text('Submit'),
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
