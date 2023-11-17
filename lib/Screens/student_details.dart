import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class studentDetails extends StatefulWidget{
  @override
  _studentState createState() => _studentState();
}

class _studentState extends State<studentDetails>{
  //values taken from database
  var _pasHours;
  var _actColHours;
  var _actHours;
  var _name;
  var _grade;
  var _hours;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity, 
          decoration: BoxDecoration(

          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/icons/back.svg',
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,

              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding:EdgeInsets.only(top: 30, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(
                            //change to student image
                            'assets/icons/student.svg',
                            height: 120,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                _name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromARGB(240, 17, 17, 70),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                            
                                'Grade: $_grade',
                                
                                style: TextStyle(
                                  color: Color.fromARGB(240, 17, 17, 70).withOpacity(0.7),
                                ),
                              ),
                              
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text('Hours', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Color.fromARGB(240, 17, 17, 70),
                        ),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      Text(
                        'Active hours: $_actHours',
                        style: TextStyle(
                          height: 1.6,
                          color: Color.fromARGB(240, 17, 17, 70).withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Passive hours: $_pasHours',
                        
                        style: TextStyle(
                          height: 1.6,
                          color:
                              Color.fromARGB(240, 17, 17, 70).withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Active collection hours: $_actColHours',
                        
                        style: TextStyle(
                          height: 1.6,
                          color:
                              Color.fromARGB(240, 17, 17, 70).withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      
      ),
    );
  }
}