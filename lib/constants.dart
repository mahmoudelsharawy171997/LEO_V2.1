import 'package:intl/intl.dart';
import 'package:flutter/material.dart';



const Color mainColor=Color.fromRGBO(31, 61, 125, 1);

DateTime now = DateTime.now();
String formattedTime = DateFormat('h:mm a').format(now);
String formattedDate = DateFormat('dd MMM yyyy').format(now);

