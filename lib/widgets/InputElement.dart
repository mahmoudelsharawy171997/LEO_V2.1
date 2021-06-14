import 'package:flutter/material.dart';
import '../constants.dart';

class InputElement extends StatelessWidget {
  InputElement({Key key,@required this.title, this.data,}) : super(key: key);
  final String title;
   final String data;
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if(data==null){
      controller.text='';
    }else{
      controller.text=data;
    }
    print('input field');
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          TextFormField(
            controller: controller,
            style: TextStyle(color: Colors.black),
            validator: (value) {
              if (value.isEmpty) {
                return 'this field requred!';
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: mainColor, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: mainColor, width: 1.0,),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}