import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'switch.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Events {
  final String id;
  final String titre;
  final String description;
  final String date;
  final String temps;
  final String lieu;
  final String image;

  Events({
    this.id,
    this.titre,
    this.description,
    this.date,
    this.temps,
    this.lieu,
    this.image,
  });

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
        id: json['id'],
        titre: json['titre'],
        lieu: json['lieu'],
        date: json['date'],
        temps: json['temps'],
        image: json['image'],
        description: json['description']);
  }
}

class EventsListView extends StatefulWidget {
  @override
  _EventsListViewState createState() => _EventsListViewState();
}

class _EventsListViewState extends State<EventsListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Events>>(
      future: _fetchEvents(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Events> data = snapshot.data;
          return _eventsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<Events>> _fetchEvents() async {
    final eventsListAPIUrl = 'https://www.leotunisia.tn/listeevent.php';
    final response = await http.get(eventsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((event) => new Events.fromJson(event)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _eventsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListElement(
            id: data[index].id,
            title: data[index].titre,
            description: data[index].description,
            date: data[index].date,
            location: data[index].lieu,
            time: data[index].temps,
            image: data[index].image,
          );
        });
  }
}

class ListElement extends StatefulWidget {
  ListElement({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
    this.location,
    this.image,
  });

  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final String image;



  @override
  _ListElementState createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  @override
  Widget build(BuildContext context) {
    String x=stringToTimeOfDay(widget.time).format(context);
    print(x);
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      height: 220,
      decoration: BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.grey[200], width: 2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(
                        height: 95,
                        child: SingleChildScrollView(
                          child: Text(
                            widget.description,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 120,
                height: 130.0,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network('https://www.leotunisia.tn/media/${widget.image}',fit: BoxFit.cover,)
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.location,
                style: TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Text(widget.date),
              Text(widget.time),
              SwitchWidget(eventDate: DateTime.parse(widget.date),eventTime: stringToTimeOfDay(widget.time),),
            ],
          )
        ],
      ),
    );
  }
}



