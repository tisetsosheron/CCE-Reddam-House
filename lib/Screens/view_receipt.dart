// receipt_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cce_reddam_house/Screens/award_page.dart';

class ReceiptPage extends StatefulWidget {
  final Function()? onTap;

  const ReceiptPage({Key? key, this.onTap});

  @override
  State<ReceiptPage> createState() => _ReceiptPage();
}

class _ReceiptPage extends State<ReceiptPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final usersCollection = FirebaseFirestore.instance.collection("logged_hours");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipt Page"),
        backgroundColor: Color.fromARGB(255, 141, 122, 16),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AwardHoursPage(),
              ),
            );
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!.docs;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final userData =
                          users[index].data() as Map<String, dynamic>;
                      final receiptNumber = userData['receipt_number'];
                      final fileUrl = userData['file_url'];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Receipt Number: $receiptNumber',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _viewReceipt(fileUrl),
                              child: Text('View Receipt'),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(
                                  255,
                                  141,
                                  122,
                                  16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () => _handleAccept(userData),
                                  child: Text('Accept'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () => _handleReject(userData),
                                  child: Text('Reject'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  // Function to launch the URL in a web browser
  void _viewReceipt(String fileUrl) async {
    if (await canLaunch(fileUrl)) {
      await launch(fileUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $fileUrl'),
        ),
      );
    }
  }

  // Function to handle the "Accept" button
  void _handleAccept(Map<String, dynamic> userData) {
    // Implement logic for accepting receipt
    // You can update the Firestore collection or perform any other action
    // based on your application's requirements.
    print('Receipt Accepted');
  }

  // Function to handle the "Reject" button
  void _handleReject(Map<String, dynamic> userData) {
    // Implement logic for rejecting receipt
    // You can update the Firestore collection or perform any other action
    // based on your application's requirements.
    print('Receipt Rejected');
  }
}
