import 'package:flutter/material.dart';
import 'package:leo_v1/screens/login.dart';

import '../constants.dart';
class footer extends StatelessWidget {
  const footer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              mainColor,
              Colors.blue[800],
            ],
          )
      ),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: Icon(Icons.logout,color: Colors.white,), onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => logIn()),
            );
          }),
          Image.asset('images/footer.png'),
        ],
      ),
    );
  }
}