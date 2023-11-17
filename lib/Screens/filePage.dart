import 'package:cce_reddam_house/api/firebase_donwload_api.dart';
import 'package:cce_reddam_house/components/firebase_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class FilePage extends StatelessWidget {
  final FirebaseFile file;

  const FilePage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final isFile = ['.jpeg', '.jpg', '.png', '.pdf'].any(file.name.contains);

    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () async {
              await FirebaseDownloadApi.downloadFile(file.ref);

              final snackBar = SnackBar(
                content: Text('Downloaded ${file.name}'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: PDFView(
        filePath: file.url,
      ),
    );
  }
}
