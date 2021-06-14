import 'package:flutter/material.dart';
import 'package:leo_v1/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QRCode extends StatelessWidget {
  String qrData ;
  String username;
  QRCode({this.qrData, this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: Text('QR Code'),
          backgroundColor: mainColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () => Navigator.pop(context),
          )
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 60),
            width: MediaQuery.of(context).size.width,
            height: 450,
            color: mainColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Check-in Qr code',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
                QrImage(
                  backgroundColor: Colors.white,
                  size: MediaQuery.of(context).size.width*0.55,
                  data: qrData,
                ),
                Text(username,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
              ],
            ),
          ),
          Container(
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

