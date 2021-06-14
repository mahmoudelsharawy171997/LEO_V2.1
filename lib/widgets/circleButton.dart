import 'package:flutter/material.dart';
import '../constants.dart';

class CircleButton extends StatelessWidget {

  final String title;
  final IconData icon;
  final Function function;

  const CircleButton({this.title, this.icon, this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100.0),
      onTap: function,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  mainColor,
                  Colors.blue[800],
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(icon,color: Colors.white,size: 40,),
          ),
          Text(title,style: TextStyle(color: Colors.black,fontSize: 20,),),
        ],
      ),
    );
  }
}
