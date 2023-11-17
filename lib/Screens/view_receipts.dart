// receipt_page.dart
import 'package:cce_reddam_house/Screens/teacher_home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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
                builder: (context) => TeacherHomePage(),
              ),
            );
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!.docs; //Directly access doccuments

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

  void _viewReceipt(String fileUrl) {
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WebviewScaffold(
            url: fileUrl,
            appBar: AppBar(
              title: Text('Receipt'),
              backgroundColor: Color.fromARGB(255, 141, 122, 16),
            ),
          ),
        ),
      );
    } catch (e) {
      print('WebView Error: $e');
      // Handle the error accordingly, for example, show a dialog or a toast
    }
  }
}
