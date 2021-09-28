import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
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

  List<Map<String, String>> get _notes => NoteInheritedWidget.of(context).notes;

  @override
  void initState() {
    if (widget.noteMode == NoteMode.Modify) {
      titleController.text = widget.note['title'];
      contentController.text = widget.note['content'];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        final title = titleController.text;
        final content = contentController.text;

        if (widget.noteMode == NoteMode.New) {
          if (title != '' && content != '') {
            NoteProvider.insertNote(
              {
                'title': title,
                'content': content,
                'creationdate': widget.note['creationdate'],
                'editingdate': widget.note['editingdate'],
                'favorite': widget.note['favorite'],
                'color': widget.note['color'],
                'alarmdate': widget.note['alarmdate'],
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
              'favorite': widget.note['favorite'],
              'color': widget.note['color'],
              'alarmdate': widget.note['alarmdate'],
            });
          }
        }
        Navigator.of(context).pop();

        return await true;
      },
      child: Scaffold(
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
                          style: kTitle1Style,
                          decoration: InputDecoration(hintText: "Titolo", border: InputBorder.none),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: contentController,
                          cursorColor: theme.iconTheme.color,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: kBodyLabelStyle,
                          decoration: InputDecoration(hintText: "Inserisci la nota...", border: InputBorder.none),
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: widget.noteMode == NoteMode.Modify
                        ? FocusedMenuHolder(
                            blurSize: 0,
                            openWithTap: true,
                            menuWidth: MediaQuery.of(context).size.width * 0.5,
                            animateMenuItems: false,
                            onPressed: () {},
                            menuItems: [
                              FocusedMenuItem(
                                  title: Text(
                                    "Condividi",
                                    style: kCardSubtitleStyle,
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
                                    style: kCardSubtitleStyle,
                                  ),
                                  onPressed: () {
                                    widget.note['favorite'] == 0
                                        ? NoteProvider.updateNote({
                                            'id': widget.note['id'],
                                            'title': widget.note['title'],
                                            'content': widget.note['content'],
                                            'creationdate': widget.note['creationdate'],
                                            'editingdate': widget.note['editingdate'],
                                            'favorite': 1,
                                            'color': widget.note['color'],
                                            'alarmdate': widget.note['alarmdate'],
                                          })
                                        : NoteProvider.updateNote({
                                            'id': widget.note['id'],
                                            'title': widget.note['title'],
                                            'content': widget.note['content'],
                                            'creationdate': widget.note['creationdate'],
                                            'editingdate': widget.note['editingdate'],
                                            'favorite': 0,
                                            'color': widget.note['color'],
                                            'alarmdate': widget.note['alarmdate'],
                                          });
                                    setState(() {});
                                  },
                                  trailingIcon: Icon(
                                    widget.note['favorite'] == 0 ? Icons.favorite_border_rounded : Icons.favorite_rounded,
                                    color: theme.textSelectionColor,
                                  ),
                                  backgroundColor: theme.dialogBackgroundColor),
                              FocusedMenuItem(
                                  title: Text(
                                    "Elimina",
                                    style: kCardSubtitleStyle.copyWith(color: Colors.redAccent, fontWeight: FontWeight.bold),
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
                            ))
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
