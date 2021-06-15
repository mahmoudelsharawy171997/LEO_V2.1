import 'package:flutter/material.dart';
import 'package:leo_v1/widgets/footer.dart';
import 'package:leo_v1/widgets/outputData.dart';

import '../../constants.dart';

class info extends StatelessWidget {
  final String name;
  final String club;
  final String email;
  final String phone;

  const info({Key key, @required this.name, @required this.club, @required this.email, @required this.phone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Information personelle'),
          backgroundColor: mainColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () => Navigator.pop(context),
          )
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Color.fromRGBO(233, 235, 243, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutputData(title: 'Nom,Prénom',data: name,),
            OutputData(title: 'Club',data: club,),
            OutputData(title: 'Poste',data: email,),
            OutputData(title: 'Numéro de telephone',data: phone,),
          ],
        ),
      ),
      bottomNavigationBar: footer(),
    );
  }
}

