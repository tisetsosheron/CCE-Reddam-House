import 'package:cce_reddam_house/components/text_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherProfilePage extends StatefulWidget {
  const TeacherProfilePage({super.key});

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final teachersCollection = FirebaseFirestore.instance.collection("Users");

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Edit $field",
                style:
                    const TextStyle(color: Color.fromARGB(255, 180, 177, 177)),
              ),
              content: TextField(
                autofocus: true,
                style: TextStyle(color: Color.fromARGB(255, 3, 34, 59)),
                decoration: InputDecoration(
                  hintText: "Enter new $field",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 3, 34, 59)),
                ),
                onChanged: (value) {
                  newValue = value;
                },
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Color.fromARGB(255, 3, 34, 59)),
                    )),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(newValue),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Color.fromARGB(255, 3, 34, 59)),
                    )),
              ],
            ));

    if (newValue.trim().isNotEmpty) {
      await teachersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
        backgroundColor: Color.fromARGB(255, 3, 34, 59),
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
              // if(userData != null){
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

                  MyTextBox(
                    text: currentUser.email!,
                    sectionName: 'email',
                    onPressed: () => editField('email'),
                  ),

                  //grade
                  MyTextBox(
                    text: userData['reference'],
                    sectionName: 'Reference Number',
                    onPressed: () => editField('reference'),
                  ),
                ],
              );
              //}
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
