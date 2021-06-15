import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leo_v1/classes/MemberInfo.dart';
import 'package:leo_v1/screens/Client%20Screens/home_client.dart';
import 'package:leo_v1/screens/Admin%20Screens/home_admin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../constants.dart';

class logIn extends StatefulWidget {
  @override
  _logInState createState() => _logInState();
}

class _logInState extends State<logIn> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  bool processing = false;
  Member user;
  var jsonResponse;
  var userType;

  void userSignIn(String email, String pass) async {
    setState(() {processing = true;});

    var url = "https://www.leotunisia.tn/login.php";
    var data = {
      "email": email,
      "password": pass,
    };
    var response = await http.post(url,body: data);

    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body);
      if(jsonResponse==false){
        setState(() {processing=false;});
        Fluttertoast.showToast(
            msg: "l'email ou le mot de passe n'est pas correct", toastLength: Toast.LENGTH_LONG);
        return;
      }
      print(jsonResponse);
      var username = jsonResponse['nom_prenom'];
      var club = jsonResponse['nomclub'];
      var useremail = jsonResponse['poste'];
      var userphone = jsonResponse['tel'];
      var qrCode = jsonResponse['qrcode'];
      user= Member(
          name: username,
          club: club,
          email: useremail,
          phone: userphone,
          myQRCode: qrCode,
      );
      userType = jsonResponse['type'];
      print(username);
      print(club);
      print(useremail);
      print(userphone);
      print(qrCode);
      if (userType.toString() == '1') {
        print('admin');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeAdmin()),
        );
      }
      if (userType.toString() == '0') {
        print('member');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeClient(user: user,)),
        );
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              'images/flag.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            color: Color.fromRGBO(31, 61, 125, 1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      style: TextStyle(color: Colors.grey[300]),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'this field requred!';
                        }
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[300], width: 2.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey[300],
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.grey[300]),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'this field requred!';
                        }
                      },
                      obscureText: showPassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey[300],
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                          ),
                          onPressed: () =>
                              setState(() => showPassword = !showPassword),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        labelText: 'Mot de pasee',
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[300], width: 2.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[300],
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [Color.fromRGBO(0, 96, 147, 1.0), mainColor],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                        ),
                      ),
                      child: FlatButton(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          height: 40,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              userSignIn(
                                  nameController.text, passwordController.text);
                            }
                          },
                          child: Text(
                            'Connecter',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                    ),
                    processing == false
                        ? Container()
                        : CircularProgressIndicator(
                      strokeWidth: 3.0,
                            backgroundColor: Colors.white,
                          )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
