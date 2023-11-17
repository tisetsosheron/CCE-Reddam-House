import 'package:cce_reddam_house/Screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AwardsPage extends StatefulWidget {
  final Function()? onTap;

  const AwardsPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<AwardsPage> createState() => _AwardsPageState();
}

class _AwardsPageState extends State<AwardsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool eligibleForAward = false;

  @override
  void initState() {
    super.initState();
    checkLoggedHours();
  }

  Future<void> checkLoggedHours() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('students').doc(user.uid).get();

      int loggedHours = snapshot.get('logged_hours') ?? 0;

      if (loggedHours > 20) {
        setState(() {
          eligibleForAward = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Awards"),
        backgroundColor: Color.fromARGB(255, 141, 122, 16),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Use the arrow back icon
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomePage(), // Navigate to HomePage
            ));
          },
        ),
      ),
      body: Center(
        child: eligibleForAward
            ? Text('Congratulations! You are eligible for an award!')
            : Text('Keep working to reach 20 logged hours for an award.'),
      ),
    );
  }
}
