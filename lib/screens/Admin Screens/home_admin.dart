import 'package:flutter/material.dart';
import 'package:leo_v1/constants.dart';
import 'package:leo_v1/screens/Admin%20Screens/AdminEventsScreen.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:leo_v1/screens/Admin%20Screens/room.dart';
import 'package:leo_v1/widgets/footer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'createEvent.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  String qrResult='Not yet scanned';
  var jsonResponse;
  List roomClients;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-50,
          color: Color.fromRGBO(233, 235, 243, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeFlatButton(content: 'Scan',function: ()async{
                String codeScanner = await BarcodeScanner.scan();    //barcode scanner
                setState(() {
                  qrResult = codeScanner;
                });

                //send QRCode to server to receive members in the same room
                var url = "https://www.leotunisia.tn/vefierqrcode.php";
                var data = {
                  "qrcode": qrResult,
                };
                var response = await http.post(url, body: data);
                jsonResponse = convert.jsonDecode(response.body);

                print('QR code $qrResult');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Room(result: qrResult,roomMembers: jsonResponse,)),
                );
              },),
              SizedBox(height: 20.0,),
              HomeFlatButton(content: 'Programme',function: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AdminEventsScreen()),
                );
              },),
              SizedBox(height: 20.0,),
              HomeFlatButton(content: 'Creer Event',function: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CreateEvent()),
                );
              },),
            ],
          ),
        ),
      ),
      bottomNavigationBar: footer(),
    );
  }
}

class HomeFlatButton extends StatelessWidget {
  const HomeFlatButton({this.content, this.function,});
  final String content;
  final Function function;
  @override
  Widget build(BuildContext context) {

    return FlatButton(
      padding: EdgeInsets.all(15.0),
      color: mainColor,
      onPressed: function,
      child: Text(content, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25),),
    );
  }
}
