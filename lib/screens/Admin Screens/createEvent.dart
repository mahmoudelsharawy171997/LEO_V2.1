import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leo_v1/widgets/footer.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  bool processing = false;
  File _file;
  final _formKey = GlobalKey<FormState>();
  String title, location, description;
  final timeController = TextEditingController();
  final dateController = TextEditingController();
  var jsonResponse;

  _openGallary(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      _file = picture;
    });
    print(_file.path);
  }

  Future addEvent() async {
    setState(() {
      processing = true;
    });
    if(_file == null) {
      Fluttertoast.showToast(
          msg: "You must add picture", toastLength: Toast.LENGTH_SHORT);
      setState(() {
        processing = false;
      });
      return ;
    }
    String base64 = convert.base64Encode(_file.readAsBytesSync());
    String imagename = _file.path.split("/").last;
    print(imagename);
    var url = "https://www.leotunisia.tn/insetevent.php";
    var data = {
      "titre": title,
      "lieu": location,
      "date": dateController.text,
      "temps": timeController.text,
      "imagename": imagename,
      "image64": base64,
      "description": description,
    };
    var response = await http.post(url, body: data);
    jsonResponse = convert.jsonDecode(response.body);
    print('this is $jsonResponse');
    setState(() {
      processing = false;
    });
    if(jsonResponse==true){
      Fluttertoast.showToast(
          msg: "Success", toastLength: Toast.LENGTH_SHORT);
    }
    if(jsonResponse==false){
      Fluttertoast.showToast(
          msg: "Failed", toastLength: Toast.LENGTH_SHORT);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('créer un événement'),
          backgroundColor: mainColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          )),
      body: Container(
        padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Titre',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'this field requred!';
                        }
                        title = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: mainColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Lieu',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'this field requred!';
                        }
                        location = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: mainColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              DateTimeInput(
                controller: dateController,
                title: 'Date',
                onTap: () async {
                  var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2018),
                      lastDate: DateTime(2101));
                  dateController.text = date.toString().substring(0, 10);
                },
              ),
              DateTimeInput(
                controller: timeController,
                title: 'Temps',
                onTap: () async {
                  var time = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  timeController.text = time.format(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      maxLines: 5,
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'this field requred!';
                        }
                        description = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: mainColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                      color: mainColor,
                      height: 40,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          print(title);
                          print(location);
                          print(dateController.text);
                          print(timeController.text);
                          print(description);
                          addEvent();
                          //uploadEvent();
                        }
                      },
                      child: Text(
                        'creer',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                  ),
                  processing == false
                      ? Container()
                      : CircularProgressIndicator(
                    strokeWidth: 3.0,
                    backgroundColor: Colors.white,
                  ),
                  IconButton(
                    iconSize: 35,
                      icon: Icon(
                        Icons.camera_alt,
                        color: mainColor,
                      ),
                      onPressed: () {
                        _openGallary(context);
                      }),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: footer(),
    );
  }
}

class DateTimeInput extends StatelessWidget {
  const DateTimeInput({
    Key key,
    @required this.controller,
    @required this.onTap,
    @required this.title,
  }) : super(key: key);

  final TextEditingController controller;
  final Function onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            readOnly: true,
            onTap: onTap,
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
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: mainColor, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
