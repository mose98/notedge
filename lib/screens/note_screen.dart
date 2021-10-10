import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:notedget/components/color_picker.dart';
import 'package:notedget/components/note_card.dart';
import 'package:notedget/components/note_inherited_widget.dart';
import 'package:notedget/constants.dart';
import 'package:notedget/provider/note_provider.dart';
import 'package:notedget/screens/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share/share.dart';

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


  @override
  void initState() {
    favorite = widget.note['favorite'];

    int value = int.parse(widget.note['color'], radix: 16);
    _color = new Color(value);
    if (widget.noteMode == NoteMode.Modify) {
      titleController.text = widget.note['title'];
      contentController.text = widget.note['content'];
    }

    try{
      date = widget.note['alarmdate'];
    }
    catch(Exception) {
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
                'alarmdate': date,
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
              'alarmdate': date,
            });
          }
        }
        Navigator.of(context).pop();

        return await true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _color,
          elevation: 0,
          foregroundColor: textColor,
          actions: [
            FocusedMenuHolder(
                blurSize: 0,
                openWithTap: true,
                menuWidth: MediaQuery.of(context).size.width * 0.5,
                animateMenuItems: false,
                onPressed: () {},
                menuItems: [
                  FocusedMenuItem(
                    title: Text(
                      "Allarme",
                          style: kNormalTextStyle,
                    ),
                    onPressed: (){
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                          maxTime: DateTime(2050, 12, 31),
                          onConfirm: (_date) {
                            date = _date;
                          },
                          currentTime: widget.note[date],
                          locale: LocaleType.it,
                      );
                    },
                    trailingIcon: Icon(
                      Icons.alarm_add_rounded,
                      color: theme.textSelectionColor,
                    ),
                      backgroundColor: theme.dialogBackgroundColor
                  ),
                  FocusedMenuItem(
                      title: Text(
                          "Condividi",
                          style: kNormalTextStyle
                      ),
                      onPressed: () {
                        Share.share(widget.note['title'] + '\n\n' + widget.note['content']);
                      },
                      trailingIcon: Icon(
                        Icons.ios_share,
                        color: theme.textSelectionColor,
                      ),
                      backgroundColor: theme.dialogBackgroundColor),
                  FocusedMenuItem(
                      title: Text(
                        "Preferiti",
                        style: kNormalTextStyle,
                      ),
                      onPressed: () {
                        favorite == 0
                            ? favorite = 1
                            : favorite = 0;
                        setState(() {});
                      },
                      trailingIcon: Icon(
                        favorite == 0 ? Icons.favorite_border_rounded : Icons.favorite_rounded,
                        color: theme.textSelectionColor,
                      ),
                      backgroundColor: theme.dialogBackgroundColor),
                  FocusedMenuItem(
                      title: Text(
                          "ELimina",
                          //style: kNormalTextStyle.copyWith(color: Colors.redAccent, fontWeight: FontWeight.bold),
                          style: kNormalTextStyle.copyWith(color: Colors.redAccent, fontWeight: FontWeight.bold,)
                      ),
                      onPressed: () async {
                        await NoteProvider.deleteNote(widget.note['id']);
                        Navigator.of(context).pop();
                      },
                      trailingIcon: Icon(Icons.delete, color: Colors.redAccent),
                      backgroundColor: theme.dialogBackgroundColor)
                ],
                child: Icon(
                  Icons.more_vert_rounded,
                  size: MediaQuery.of(context).size.aspectRatio * 70,
                )),
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
                      child: MyColorPicker(
                          onSelectColor: (value) {
                            setState(() {
                              textColor = _color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
                              _color = value;
                            });
                          },
                          availableColors: [
                            theme.scaffoldBackgroundColor,
                            new Color(Colors.green.value),
                            new Color(Colors.yellow.value),
                            new Color(Colors.greenAccent.value),
                            new Color(Colors.purple.value),
                            new Color(Colors.grey.value),
                            new Color(Colors.teal.value),
                          ],
                          initialColor: _color))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
