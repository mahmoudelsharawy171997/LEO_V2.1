import 'package:flutter/material.dart';
import 'package:leo_v1/widgets/listElement.dart';
import '../constants.dart';

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Programme de la convention',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: mainColor),
        ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          )),
      body: EventsListView(),
    );
  }
}
