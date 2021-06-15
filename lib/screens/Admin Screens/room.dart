import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leo_v1/widgets/footer.dart';
import 'package:leo_v1/widgets/outputData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../constants.dart';
import '../Client Screens/info.dart';

class Room extends StatefulWidget {
  String result;
  var roomMembers;
  Room({@required this.result, @required this.roomMembers});

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  var roomMembers;
  bool checkRoom = false;
  TextEditingController controller=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String id, idReservation, roomNumber;

  @override
  void initState() {
    roomMembers = widget.roomMembers;
    print(roomMembers.toString());
    super.initState();
  }

  Future checkIn({String id, String roomNum, String idReservation}) async {
    print('before send');
    var jsonResponse;
    String message;
    var url = "https://www.leotunisia.tn/checkin.php";

    var data = {
      "id": id,
      "id_reservation": idReservation,
      "room": roomNum,
    };
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse == false) {
        message = 'field';
        return;
      } else {
        message = 'success';
      }
      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < roomMembers.length; i++) {
      print('room number is ${roomMembers[i]['room']}');
      if (roomMembers[i]['room'] != '0') {
        setState(() {
          checkRoom = true;
        });
        roomNumber = roomMembers[i]['room'];
        print(roomNumber);
        break;
      }
    }

    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
          centerTitle: true,
          title: Text('Chambre'),
          backgroundColor: mainColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          )),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 400,
                color: Colors.white,
                padding: EdgeInsets.all(30),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: roomMembers.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (roomMembers[index]['nom_prenom'] == null ||
                            roomMembers[index]['nomclub'] == null ||
                            roomMembers[index]['email'] == null ||
                            roomMembers[index]['tel'] == null) {
                          Fluttertoast.showToast(
                              msg: "this member didn't have any data",
                              toastLength: Toast.LENGTH_SHORT);
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => info(
                                    name: roomMembers[index]['nom_prenom'],
                                    club: roomMembers[index]['nomclub'],
                                    email: roomMembers[index]['email'],
                                    phone: roomMembers[index]['tel'],
                                  )),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 190,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    '${roomMembers[index]['nom_prenom']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(0, 96, 147, 1.0),
                                    mainColor
                                  ],
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
                                ),
                              ),
                              child: roomMembers[index]['checkin'] == '1'
                                  ? const SizedBox(
                                      height: 45,
                                    )
                                  : FlatButton(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      onPressed: () {
                                        id = roomMembers[index]['id'];
                                        idReservation = roomMembers[index]
                                            ['id_reservation'];
                                        print(id);
                                        print(idReservation);
                                      },
                                      child: Text(
                                        'confirmer',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      )),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(30),
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      checkRoom
                          ? OutputData(
                              title: 'Numéro de la chambre',
                              data: roomNumber,
                            )
                          : Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Numéro de la chambre',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'this field requred!';
                                    }
                                  },
                                  controller: controller,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: mainColor, width: 2),
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: mainColor,
                                        width: 1.0,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {

                          if (_formKey.currentState.validate()) {
                            print(id);
                            print(idReservation);


                            if(checkRoom){
                              print(roomNumber);
                              checkIn(
                                  id: id,
                                  idReservation: idReservation,
                                  roomNum: roomNumber);
                            }else{
                              print(controller.text);
                              checkIn(
                                  id: id,
                                  idReservation: idReservation,
                                  roomNum: controller.text);
                            }


                            //send QRCode to server to receive members in the same room
                            var url =
                                "https://www.leotunisia.tn/vefierqrcode.php";
                            var data = {
                              "qrcode": widget.result,
                            };
                            var response = await http.post(url, body: data);
                            setState(() {
                              roomMembers = convert.jsonDecode(response.body);
                              print(roomMembers.toString());
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(0, 96, 147, 1.0),
                                mainColor
                              ],
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                            ),
                          ),
                          child: Text(
                            'enregistrer',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
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
