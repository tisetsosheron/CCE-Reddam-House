import 'package:cce_reddam_house/components/text_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> editField(String field) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color.fromARGB(255, 141, 122, 16),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            //get user data
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [
                  const SizedBox(height: 50),

                  //profile picture
                  const Icon(
                    Icons.person,
                    size: 72,
                  ),
                  const SizedBox(height: 10),

                  //user email
                  Text(
                    currentUser.email!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color.fromARGB(255, 3, 34, 59)),
                  ),

                  const SizedBox(height: 50),

                  //user details
                  const Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text(
                      'My Details',
                      style: TextStyle(color: Color.fromARGB(255, 3, 34, 59)),
                    ),
                  ),

                  //name
                  MyTextBox(
                    text: userData['name'],
                    sectionName: 'Name',
                    onPressed: () => editField('name'),
                  ),

                  //surname
                  MyTextBox(
                    text: userData['surname'],
                    sectionName: 'Surname',
                    onPressed: () => editField('surname'),
                  ),

                  //grade
                  MyTextBox(
                    text: userData['grade'],
                    sectionName: 'Grade',
                    onPressed: () => editField('grade'),
                  )

                  //grade

                  //class

                  //house
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
