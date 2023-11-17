import 'package:cce_reddam_house/Screens/profile_page.dart';
import 'package:cce_reddam_house/components/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherHomePage extends StatefulWidget {
  final Function()? onTap;
  const TeacherHomePage({super.key, this.onTap});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  //navigate to ptofile page
  void goToProfilePage() {
    //pop the menu drawer
    Navigator.pop(context);

    //go to a new page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ));
  }

  //sign user out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Color.fromARGB(255, 3, 34, 59)),
        drawer: MyDrawer(
          onProfileTap: goToProfilePage,
          onSignOut: signUserOut,
        ),
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 26.0, horizontal: 36.0),
              child: Text("Dashboard",
                  style: TextStyle(
                    color: Color.fromARGB(255, 3, 34, 59),
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold,
                    //letterSpacing: 2.0,
                  ))),
          Padding(
              padding: EdgeInsets.all(18.0),
              child: Center(
                  child: Wrap(spacing: 20.0, runSpacing: 20.0, children: [
                SizedBox(
                    width: 140.0,
                    height: 180.0,
                    child: Card(
                      color: Color(0xffa49831),
                      child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(children: [
                            Image.asset('lib/images/ttable.png',
                                width: 40.0, height: 40.0),
                            SizedBox(height: 20.0),
                            Text("Timetable",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                )),
                          ])),
                    )),
                SizedBox(
                    width: 140.0,
                    height: 180.0,
                    child: Card(
                      color: Color(0xffa49831),
                      child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(children: [
                            Image.asset('lib/images/receipt.png',
                                width: 40.0, height: 40.0),
                            SizedBox(height: 20.0),
                            Text("Receipts",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ))
                          ])),
                    )),
                SizedBox(
                    width: 140.0,
                    height: 180.0,
                    child: Card(
                        color: Color(0xffa49831),
                        child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(children: [
                              Image.asset('lib/images/award.png',
                                  width: 40.0, height: 40.0),
                              SizedBox(height: 20.0),
                              Text("Awards",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ))
                            ])))),
                SizedBox(
                    width: 140.0,
                    height: 180.0,
                    child: Card(
                        color: Color(0xffa49831),
                        child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(children: [
                              Image.asset('lib/images/policy.png',
                                  width: 40.0, height: 40.0),
                              SizedBox(height: 20.0),
                              Text("Policy Info",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ))
                            ]))))
              ])))
        ])));
  }
}