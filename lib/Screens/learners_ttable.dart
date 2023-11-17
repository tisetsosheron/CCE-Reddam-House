import 'package:cce_reddam_house/Screens/filePage.dart';
import 'package:cce_reddam_house/Screens/home_page.dart';
import 'package:cce_reddam_house/api/firebase_donwload_api.dart';
import 'package:cce_reddam_house/components/firebase_file.dart';
import 'package:flutter/material.dart';

class LearnersTtablePage extends StatefulWidget {
  LearnersTtablePage({super.key});

  @override
  State<LearnersTtablePage> createState() => _LearnersTtablePageState();
}

class _LearnersTtablePageState extends State<LearnersTtablePage> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseDownloadApi.listAll('/timetables');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("View TimeTable"),
          backgroundColor: Color.fromARGB(255, 141, 122, 16),
          leading: IconButton(
              icon: Icon(Icons.arrow_back), // Use the arrow back icon
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
              })),
      body: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occurred!'));
              } else {
                final files = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(files.length),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          final file = files[index];

                          return buildFile(context, file);
                        },
                      ),
                    ),
                  ],
                );
              }
          }
        },
      ),
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
        leading: ClipOval(
          child: Image.network(
            file.url,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          file.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FilePage(file: file),
        )),
      );

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        leading: Container(
          width: 52,
          height: 52,
          child: const Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$length Files',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );
}
      
     

            // const Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: Text("To view the timetable, click on the button below:",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontStyle: FontStyle.italic,
            //           fontSize: 16.0,
            //         ))),
            // const SizedBox(height: 30),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.of(context).pushReplacement(
            //         MaterialPageRoute(
            //           builder: (context) =>
            //               HomePage(), // Replace HomePage with your actual homepage widget
            //         ),
            //       );
            //     },
            //     child: Text('View Timetable'),
            //     style: ElevatedButton.styleFrom(
            //       primary: Color.fromARGB(
            //           255, 141, 122, 16), // Change color as needed
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 30),
            // const Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: Text(
            //         "To download the timetable, click on the button below:",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontStyle: FontStyle.italic,
            //           fontSize: 16.0,
            //         ))),
            // const SizedBox(height: 30),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.of(context).pushReplacement(
            //         MaterialPageRoute(
            //           builder: (context) =>
            //               HomePage(), // Replace HomePage with your actual homepage widget
            //         ),
            //       );
            //     },
            //     child: Text('Download Timetable'),
            //     style: ElevatedButton.styleFrom(
            //       primary: Color.fromARGB(
            //           255, 141, 122, 16), // Change color as needed
            //     ),
            //   ),
            // ),
  