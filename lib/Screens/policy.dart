import 'package:flutter/material.dart';
import 'package:cce_reddam_house/Screens/home_page.dart';

class PolicyPage extends StatefulWidget {
  final Function()? onTap;
  const PolicyPage({super.key, this.onTap});

  @override
  State<PolicyPage> createState() => _PolicyState();
}

class _PolicyState extends State<PolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Terms & Conditions"),
            backgroundColor: Color.fromARGB(255, 141, 122, 16),
            leading: IconButton(
                icon: Icon(Icons.arrow_back), // Use the arrow back icon
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => HomePage(), // Navigate to HomePage
                  ));
                })),
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 30),
          Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "1. PURPOSE",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              )),
          Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "The purpose of this App is to allow learners and teachers to provide and access the information regarding the Community Enagement Services done by learners",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(height: 5),
          Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "2. CONDITIONS OF USE",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              )),
          Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "Access to this app gives the status of User and information included in the policy page. The terms and conditions aim to inform users of the uses, reaponsibilities and other circumstances that govern when using the app.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(height: 5),
          Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "3. USERS CONSIDERATION",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              )),
          Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "A user will be defined as a teacher or learner who accesses and uses the App. Navigation, access and uses of the App requires prior registration.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(height: 5),
          Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "4. SECURITY MEASURES",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              )),
          Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "Reddam House will be provided with the reference number that will allow them to access the teachers' side of the app and to restrict the learners from registering as teachers. The reasonable steps will be taken to secure a user's information and guarantees confidelity and availability of the necessary information.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(height: 5),
          Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "5. PERSONAL DATA",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              )),
          Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "When registering and logging in, it is necessary to provide some personal data. Users will guarantee its truthfulness, accuracy and validity.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              )),
        ])));
  }
}
