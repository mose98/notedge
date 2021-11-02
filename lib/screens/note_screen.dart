import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:notedget/components/color_picker.dart';
import 'package:notedget/components/modal_float.dart';
import 'package:notedget/constants.dart';
import 'package:notedget/provider/note_provider.dart';
import 'package:share/share.dart';

import '../main.dart';

class NoteScreen extends StatefulWidget {
  NoteMode noteMode;
  late var note;

  NoteScreen({required this.note, required this.noteMode});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController contentController = new TextEditingController();

  late Color _color;
  var textColor;
  late int favorite;
  late DateTime date;
  late int archived;

  @override
  void initState() {
    favorite = widget.note['favorite'];
    archived = widget.note['archived'];

    int value = int.parse(widget.note['color'], radix: 16);
    _color = new Color(value);
    if (widget.noteMode == NoteMode.Modify) {
      titleController.text = widget.note['title'];
      contentController.text = widget.note['content'];
    }

    try {
      date = widget.note['alarmdate'] as DateTime;
    } catch (Exception) {
      date = DateTime.now();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    textColor = _color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    return WillPopScope(
      onWillPop: () async {
        final title = titleController.text;
        final content = contentController.text;

        if (widget.noteMode == NoteMode.New) {
          if (title != '' || content != '') {
            NoteProvider.insertNote(
              {
                'title': title,
                'content': content,
                'creationdate': widget.note['creationdate'],
                'editingdate': widget.note['editingdate'],
                'favorite': favorite,
                'color': _color.toString().split('(0x')[1].split(')')[0],
                'alarmdate': date.toString(),
                'archived': archived,
              },
            );
          }
        } else if (widget.noteMode == NoteMode.Modify) {
          if (title == '' && content == '') {
            NoteProvider.deleteNote(widget.note['id']);
          } else {
            final now = new DateTime.now();
            String dataText = DateFormat.yMMMd('it_IT').add_jm().format(now);

            NoteProvider.updateNote({
              'id': widget.note['id'],
              'title': title,
              'content': content,
              'creationdate': widget.note['creationdate'],
              'editingdate': dataText,
              'favorite': favorite,
              'color': _color.toString().split('(0x')[1].split(')')[0],
              'alarmdate': date.toString(),
              'archived': archived,
            });
          }
        }
        scheduleAlarm();
        Navigator.of(context).pop();

        return await true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _color,
          elevation: 0,
          foregroundColor: textColor,
          actions: [
            GestureDetector(
                onTap: (){
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        height: MediaQuery.of(context).size.height * 0.40,
                        child: Container(),
                      )
                  );
                },
                child: Icon(
                  Icons.more_vert_rounded,
                  size: MediaQuery.of(context).size.aspectRatio * 70,
                ),
            ),
          ],
        ),
        backgroundColor: _color,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: TextField(
                          controller: titleController,
                          cursorColor: theme.iconTheme.color,
                          maxLines: 1,
                          style: kTitleStyle.copyWith(color: textColor),
                          decoration: InputDecoration(hintText: "Titolo", border: InputBorder.none),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: contentController,
                          cursorColor: theme.iconTheme.color,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: kNormalTextStyle.copyWith(color: textColor),
                          decoration: InputDecoration(hintText: "Inserisci la nota...", border: InputBorder.none),
                        ),
                      )
                    ],
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child:
                      MyColorPicker(
                        onSelectColor: (value) {
                          setState(() {
                            setState(() {
                              textColor = _color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
                              _color = value;
                            });
                          });
                        },
                        availableColors: [
                          new Color(Colors.green[200]!.value),
                          new Color(Colors.yellow[200]!.value),
                          new Color(Colors.red[200]!.value),
                          new Color(Colors.purple[200]!.value),
                          new Color(Colors.grey[200]!.value),
                          new Color(Colors.teal[200]!.value),
                          new Color(Colors.blue[200]!.value),
                          new Color(Colors.orange[200]!.value),
                          new Color(Colors.amber[200]!.value),
                          new Color(Colors.blueGrey[200]!.value),
                          new Color(Colors.brown[200]!.value),
                          new Color(Colors.cyan[200]!.value),
                          new Color(Colors.deepOrange[200]!.value),
                          new Color(Colors.deepPurple[200]!.value),
                          new Color(Colors.lightBlue[200]!.value),
                          new Color(Colors.lightGreen[200]!.value),
                          new Color(Colors.lime[200]!.value),
                          new Color(Colors.pink[200]!.value),
                          new Color(Colors.yellow[200]!.value),
                          new Color(Colors.amberAccent[200]!.value),
                          new Color(Colors.orangeAccent[200]!.value),
                          new Color(Colors.greenAccent[200]!.value),
                          new Color(Colors.redAccent[200]!.value),
                          new Color(Colors.blueAccent[200]!.value),
                          new Color(Colors.cyanAccent[200]!.value),
                          new Color(Colors.deepOrangeAccent[200]!.value),
                          new Color(Colors.deepPurpleAccent[200]!.value),
                          new Color(Colors.indigoAccent[200]!.value),
                          new Color(Colors.lightBlueAccent[200]!.value),
                          new Color(Colors.lightGreenAccent[200]!.value),
                          new Color(Colors.limeAccent[200]!.value),
                          new Color(Colors.pinkAccent[200]!.value),
                          new Color(Colors.purpleAccent[200]!.value),
                          new Color(Colors.tealAccent[200]!.value),
                          new Color(Colors.yellowAccent[200]!.value),
                        ],
                        initialColor: _color!,
                      ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void scheduleAlarm() async {
    var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 10));
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelShowBadge: true,
      channelDescription: 'Channel for Alarm notification',
      ongoing: true,
      showWhen: true,
      priority: Priority.high,
      importance: Importance.high,
      icon: 'app_icon',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.schedule(0, 'Office', "hi", scheduledNotificationDateTime, platformChannelSpecifics);
  }

  void onSaveAlarm() {
    //DateTime scheduleAlarmDateTime;
    //if (date.isAfter(DateTime.now()))
    //  scheduleAlarmDateTime = date;
    //else
    //  scheduleAlarmDateTime = date.add(Duration(days: 1));

    //var alarmInfo = AlarmInfo(
    //  alarmDateTime: scheduleAlarmDateTime,
    //  gradientColorIndex: _currentAlarms.length,
    //  title: 'alarm',
    //);
    //_alarmHelper.insertAlarm(alarmInfo);
    //scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    //Navigator.pop(context);
    //loadAlarms();
  }

  void deleteAlarm(int id) {
    //_alarmHelper.delete(id);
    ////unsubscribe for notification
    //loadAlarms();
  }
}
