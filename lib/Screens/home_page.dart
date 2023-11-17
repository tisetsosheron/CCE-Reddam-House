import 'package:cce_reddam_house/Screens/learners_ttable.dart';
import 'package:cce_reddam_house/Screens/log_hours.dart';
import 'package:cce_reddam_house/Screens/loginPage.dart';
import 'package:cce_reddam_house/Screens/policy.dart';
import 'package:cce_reddam_house/Screens/profile_page.dart';
import 'package:cce_reddam_house/Screens/student_award_page.dart';
import 'package:cce_reddam_house/components/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void goToLogHoursPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LogHoursPage(),
      ),
    );
  }

  void goToAwardsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AwardsPage(),
      ),
    );
  }

  void goToPolicyPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PolicyPage(),
      ),
    );
  }

  void goToTimetablePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LearnersTtablePage(),
      ),
    );
  }

  final user = FirebaseAuth.instance.currentUser;

  //navigate to profile page
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
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffa49831),
        ),
        drawer: MyDrawer(
          onProfileTap: goToProfilePage,
          onSignOut: signUserOut,
          onSearch: () {},
        ),
        body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 26.0, horizontal: 36.0),
                child: Text("Dashboard",
                    style: TextStyle(
                      color: Color.fromARGB(255, 3, 34, 59),
                      fontWeight: FontWeight.bold,
                      fontSize: 34.0,
                    ))),
            Padding(
                padding: EdgeInsets.all(18.0),
                child: Center(
                    child: Wrap(spacing: 20.0, runSpacing: 20.0, children: [
                  InkWell(
                    onTap: goToTimetablePage,
                    child: SizedBox(
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
                                const Text("Upcoming Events",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    )),
                              ])),
                        )),
                  ),
                  InkWell(
                    onTap: goToLogHoursPage,
                    child: SizedBox(
                        width: 140.0,
                        height: 180.0,
                        child: Card(
                          color: Color(0xffa49831),
                          child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(children: [
                                Image.asset('lib/images/clock.png',
                                    width: 40.0, height: 40.0),
                                SizedBox(height: 20.0),
                                const Text("Log Hours",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ))
                              ])),
                        )),
                  ),
                  InkWell(
                    onTap: goToAwardsPage,
                    child: SizedBox(
                        width: 140.0,
                        height: 180.0,
                        child: Card(
                          color: Color(0xffa49831),
                          child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(children: [
                                Image.asset('lib/images/clock.png',
                                    width: 40.0, height: 40.0),
                                SizedBox(height: 20.0),
                                const Text("Awards",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ))
                              ])),
                        )),
                  ),
                  InkWell(
                      onTap: goToPolicyPage,
                      child: SizedBox(
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
                                    const Text("Policy Info",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ))
                                  ]))))),
                ])))
          ]),
        ));
  }
}
