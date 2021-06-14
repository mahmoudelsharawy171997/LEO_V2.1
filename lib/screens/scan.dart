import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:barcode_scan/barcode_scan.dart';


class scan extends StatefulWidget {
  @override
  _scanState createState() => _scanState();
}

class _scanState extends State<scan> {

  String qrResult='Not yet scanned';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Result',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),textAlign: TextAlign.center,),
            Text(qrResult,style: TextStyle(fontSize: 18),textAlign: TextAlign.center,),
            FlatButton(
              padding: EdgeInsets.all(15),
              child: Text('Scan QR Code'),
              onPressed: ()async{
                String codeScanner = await BarcodeScanner.scan();    //barcode scnner
                setState(() {
                  qrResult = codeScanner;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
