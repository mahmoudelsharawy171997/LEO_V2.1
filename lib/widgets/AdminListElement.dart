import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leo_v1/screens/Admin%20Screens/ModifyEvent.dart';
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

class AdminEventsListView extends StatefulWidget {
  @override
  _AdminEventsListViewState createState() => _AdminEventsListViewState();
}

class _AdminEventsListViewState extends State<AdminEventsListView> {
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
      throw Exception('Failed to load events from API');
    }
  }

  ListView _eventsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return AdminListElement(
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

class AdminListElement extends StatefulWidget {
  AdminListElement({
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
  _AdminListElementState createState() => _AdminListElementState();
}

class _AdminListElementState extends State<AdminListElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.grey[200], width: 2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    height: 75,
                    child: SingleChildScrollView(
                      child: Text(
                        widget.description,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.location,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(widget.date),
                        SizedBox(
                          width: 5,
                        ),
                        Text(widget.time),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: InkWell(
                      child: Text(
                        'modifier',
                        style: TextStyle(
                            color: Colors.cyan, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        print(widget.id);
                        print(widget.title);
                        print(widget.location);
                        print(widget.description);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ModifyEvent(
                                    id: widget.id,
                                    title: widget.title,
                                    location: widget.location,
                                    description: widget.description,
                                  )),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 120,
            height: 140.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://www.leotunisia.tn/media/${widget.image}',
                  fit: BoxFit.cover,
                )),
          )
        ],
      ),
    );
  }
}
