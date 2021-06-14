import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leo_v1/classes/MemberInfo.dart';
import 'package:leo_v1/screens/qrCode.dart';
import 'package:leo_v1/widgets/circleButton.dart';
import 'package:leo_v1/widgets/footer.dart';

import '../constants.dart';
import 'Documents.dart';
import 'EventsScreen.dart';
import 'info.dart';

class HomeClient extends StatelessWidget {

  final Member user;

  const HomeClient({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width,
                color: mainColor,
                child: Image.asset(
                  'images/logo.png',
                  width: 200,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(30, 30, 30, 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleButton(
                        icon: Icons.person_rounded,
                        title: 'Information personelle',
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => info(
                                      name: user.name,
                                      club: user.club,
                                      email: user.email,
                                      phone: user.phone.toString(),
                                    )),
                          );
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CircleButton(
                        icon: Icons.article_sharp,
                        title: 'Planing',
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => EventsScreen()),
                          );
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CircleButton(
                        icon: Icons.qr_code_scanner_sharp,
                        title: 'QR code',
                        function: () {
                          if(user.myQRCode==null){
                            Fluttertoast.showToast(
                                msg: "Vous n'avez pas de réservation", toastLength: Toast.LENGTH_SHORT);
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => QRCode(
                                username: user.name,
                                qrData: user.myQRCode,
                              )),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CircleButton(
                        icon: Icons.assignment_rounded,
                        title: 'Documents',
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Documents()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: footer(),
    );
  }
}
