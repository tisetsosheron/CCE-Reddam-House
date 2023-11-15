import 'package:cce_reddam_house/Screens/loginPage.dart';
import 'package:cce_reddam_house/Screens/login_or_register.dart';
import 'package:cce_reddam_house/Screens/teacher_homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
// Import the teacher home page

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            User? user = snapshot.data;
            return FutureBuilder<DocumentSnapshot>(
              // Check the role in the 'Users' collection
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(user!.email)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic>? userData =
                      userSnapshot.data?.data() as Map<String, dynamic>?;

                  // Check if the 'role' field exists
                  String role = userData?['role'] ?? 'Student';

                  // Navigate to the appropriate home page based on role
                  if (role == 'Teacher') {
                    return TeacherHomePage();
                  } else {
                    return HomePage();
                  }
                } else {
                  // Loading state
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            // User is not logged in
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}





// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         //user is logged in
//         if (snapshot.hasData) {
//           return HomePage();
//         }
        
//         //user is not logged in
//         else {
//           return LoginOrRegisterPage();
//         }
//       },
//     ));
//   }
// }
