import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: EdgeInsets.symmetric(horizontal:30),
          decoration:BoxDecoration(
            color: Color(0x00664433),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            decoration: InputDecoration.collapsed(
              hintText: 'Search for grade, class or student',
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight, 

          child: MaterialButton(
            onPressed: () {},
            color: Color(0x00A95411),
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: SvgPicture.asset('assets/icons/search.svg'),
          ),
        ),
      ],
    );
  }
}