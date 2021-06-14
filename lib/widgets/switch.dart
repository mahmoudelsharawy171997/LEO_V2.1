import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';

class SwitchWidget extends StatefulWidget {
  final DateTime eventDate;
  final TimeOfDay eventTime;

  SwitchWidget({ this.eventDate, this.eventTime});
  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {

  String currTask = '';
  bool remindMe = false;
  DateTime reminderDate;
  TimeOfDay reminderTime;
  int id=0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Switch(
        value: remindMe,
        onChanged: (newValue) async {
          if (newValue) {
            reminderDate=widget.eventDate;
            reminderTime=widget.eventTime;
            // reminderDate = await showDatePicker(
            //   context: context,
            //   initialDate: DateTime.now(),
            //   firstDate: DateTime.now(),
            //   lastDate: DateTime(DateTime.now().year + 2),
            // );

            // if (reminderDate == null) {
            //   return;
            // }

            //reminderTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

            if (reminderDate != null && reminderTime != null) {
              remindMe = newValue;
            }
          } else {
            reminderDate = null;
            reminderTime = null;
            remindMe = newValue;
          }

          setState(() {
          });
          if (remindMe) {
            var scheduledNotificationDateTime = reminderDate
                .add(Duration(hours: reminderTime.hour, minutes: reminderTime.minute-5))
                .subtract(Duration(seconds: 5));
            var androidPlatformChannelSpecifics = AndroidNotificationDetails(
              currTask,
              'To Do Notification',
              'Attend the event',
              priority: Priority.Max,
              importance: Importance.Max,
              playSound: true,
              enableVibration: true,);

            var iOSPlatformChannelSpecifics = IOSNotificationDetails();
            NotificationDetails platformChannelSpecifics = NotificationDetails(
                androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
            await flutterLocalNotificationsPlugin.schedule(
                id,
                'Event reminder',
                'événement en 5 minutes$currTask',
                scheduledNotificationDateTime,
                platformChannelSpecifics);

          }
        },
      ),
    );
  }
}