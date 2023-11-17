import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget{
  var _grade;
  var _imageURL;
  var _backGColor;

//displays all the grades on teacher dashboard

  CategoryCard(this._grade, this._imageURL, this._backGColor);
  
  @override
  Widget build(BuildContext context){
    return Container(
      width: 130,
      height: 160,
      child: Stack(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: 110,
              height: 137,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  _grade,
                  style: TextStyle(
                    color: Color.fromARGB(240, 10, 10, 80),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              height: 84,
              width: 84,
              decoration: BoxDecoration(
                color: Color.fromARGB(239, 215, 218, 15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(_imageURL)
            ),
          ),
        ]
      ),
    );
  }
}