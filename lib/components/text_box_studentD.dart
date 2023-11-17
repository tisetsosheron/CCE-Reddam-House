import 'package:flutter/material.dart';

class TextBoxStudentD extends StatelessWidget {
  final String text;

  const TextBoxStudentD({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 180, 177, 177),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.only(
        left: 15,
        bottom: 15,
      ),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
          ],
        ),
      ]),
    );
  }
}
