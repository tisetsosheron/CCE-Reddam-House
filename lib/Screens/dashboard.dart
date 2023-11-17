import 'package:cce_reddam_house/components/category_card.dart';
import 'package:cce_reddam_house/components/student_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//teacher's homepage

class dashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color.(0xffffffff),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset('assets/icons/menu.svg'),
                        //SvgPicture.asset('assets/icons/profile.svg'),
                      ),
                      SvgPicture.asset('assets/icons/profile.svg'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Most hours',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Color.fromARGB(240, 17, 17, 69),
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: SearchBar(),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Grades',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0x001122CC),
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildCategoryList(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Most hours',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0x001122CC),
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildHighestStudents(),
              ],
            ),
          ),
        ));
  }

  //Display all the grades
  buildCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          CategoryCard('Grade 12', 'assets/icons/twelve.svg',
              Color.fromARGB(237, 233, 236, 24)),
          SizedBox(
            width: 10,
          ),
          CategoryCard('Grade 11', 'assets/icons/eleven.svg',
              Color.fromARGB(236, 222, 236, 24)),
          SizedBox(
            width: 10,
          ),
          CategoryCard('Grade 10', 'assets/icons/ten.svg',
              Color.fromARGB(237, 233, 236, 24)),
          SizedBox(
            width: 10,
          ),
          CategoryCard('Grade 9', 'assets/icons/nine.svg',
              Color.fromARGB(237, 233, 236, 24)),
          SizedBox(
            width: 10,
          ),
          CategoryCard('Grade 8', 'assets/icons/eight.svg',
              Color.fromARGB(237, 233, 236, 24)),
        ],
      ),
    );
  }

  //Should display the top 5 students in the school with most hours
  buildHighestStudents() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: <Widget>[
          //Should get the info from firebase and sort
          StudentCard(
              //'Name'
              //'Hours'
              //'assets/icons/student.svg'
              ),
        ],
      ),
    );
  }
}
