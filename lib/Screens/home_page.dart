import 'package:cce_reddam_house/Screens/profile_page.dart';
import 'package:cce_reddam_house/components/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  //document IDs
  List<String> docIDs = [];

  //get docIDs
  Future getDocID() async {
    await FirebaseFirestore.instance.collection('Users').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }

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
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 141, 122, 16),
        ),
        drawer: MyDrawer(
          onProfileTap: goToProfilePage,
          onSignOut: signUserOut,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              //         Text(
              //           "Logged In as: ${user.email!}",
              //           style: const TextStyle(fontSize: 20),
              //         ),
              //         Expanded(
              //           child:FutureBuilder(
              //             future: getDocID(),
              //             builder:(context,snapshot){
              //             return  ListView.builder(
              //               itemCount: docIDs.length,
              //               itemBuilder: (context,index){
              //                 // ignore: prefer_const_constructors
              //                 return ListTile(
              //                   title: Text(docIDs[index]),
              //           );
              //         },
              //       );
              //     }
              //   ),
              // )
            ],
          ),
        ));
  }
}
