import 'package:flutter/material.dart';

import '../constants.dart';

class OutputData extends StatelessWidget {
  const OutputData({this.data, this.title,});
  final String data;
  final String title;
  @override
  Widget build(BuildContext context) {

    print('output field');
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5,top: 10),
            child: Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: mainColor),),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: mainColor),
              borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.all(10),
            child: Text(data,style: TextStyle(fontSize: 20),),
          )
        ],
      ),
    );
  }
}
