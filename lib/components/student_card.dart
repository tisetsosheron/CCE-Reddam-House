import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cce_reddam_house/Screens/student_details.dart';

class StudentCard extends StatelessWidget{
  
  var _name;
  //var _grade;
  //var _class;
  var _hours;
  
  @override
  Widget build(BuildContext context){
    return InkWell(
      //takes user to student's detail page.
      onTap: (){
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => studentDetails()
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromARGB(239, 17, 17, 46).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: Image.asset('assets/icons/student.svg'),
            title: Text(
              _name,
              style: TextStyle(
                color: Color.fromARGB(240, 17, 17, 50),
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _hours,
              style: TextStyle(
                color: Color.fromARGB(240, 17, 17, 50).withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}