import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:notedget/components/home_navbar.dart';
import 'package:notedget/components/modal_float.dart';
import 'package:notedget/components/note_card.dart';
import 'package:notedget/components/note_inherited_widget.dart';
import 'package:notedget/constants.dart';
import 'package:notedget/provider/note_provider.dart';
import 'package:notedget/screens/note_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share/share.dart';

import 'color_picker.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Expanded(
        //height: MediaQuery.of(context).size.height * 80,
        child: FutureBuilder(
            future: NoteProvider.getNoteList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final notes = snapshot.data as List<Map<String, dynamic>>;
                return GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  physics: BouncingScrollPhysics(),
                  children: List.generate(notes.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: NoteScreen(
                                  note: notes[index],
                                  noteMode: NoteMode.Modify,
                                )));
                      },
                      onLongPress: () {
                        late Color? _color;
                        late int? favorite;
                        late int? archived;
                        late DateTime? date;

                        favorite = notes[index]['favorite'];
                        archived = notes[index]['archived'];
                        int value = int.parse(notes[index]['color'], radix: 16);
                        _color = new Color(value);
                        try {
                          date = notes[index]['alarmdate'] as DateTime;
                        } catch (Exception) {
                          date = DateTime.now();
                        }

                        showFloatingModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: NoteScreen(
                                            note: notes[index],
                                            noteMode: NoteMode.Modify,
                                          )));
                                },
                                leading: Icon(
                                  Icons.open_in_new,
                                  color: theme.textSelectionColor,
                                ),
                                title: Text(
                                  "Apri nota",
                                  style: kBigTextStyle,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  DatePicker.showDateTimePicker(
                                    context,
                                    theme: DatePickerTheme(
                                      backgroundColor: theme.scaffoldBackgroundColor,
                                      itemStyle: kNormalTextStyle.copyWith(color: theme.textTheme.bodyText1!.color),
                                    ),
                                    showTitleActions: true,
                                    minTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                                    maxTime: DateTime(2050, 12, 31),
                                    onConfirm: (_date) {
                                      date = _date;
                                    },
                                    currentTime: date,
                                    locale: LocaleType.it,
                                  );
                                },
                                title: Text(
                                  "Imposta allarme",
                                  style: kBigTextStyle,
                                ),
                                leading: Icon(
                                  Icons.alarm_add_rounded,
                                  color: theme.textSelectionColor,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Share.share(notes[index]['title'] + '\n\n' + notes[index]['content']);
                                },
                                title: Text(
                                  "Condividi nota",
                                  style: kBigTextStyle,
                                ),
                                leading: Icon(
                                  Icons.ios_share,
                                  color: theme.textSelectionColor,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  favorite == 0
                                      ? NoteProvider.updateNote({
                                          'id': notes[index]['id'],
                                          'title': notes[index]['title'],
                                          'content': notes[index]['content'],
                                          'creationdate': notes[index]['creationdate'],
                                          'editingdate': notes[index]['editingdate'],
                                          'favorite': 1,
                                          'color': _color.toString().split('(0x')[1].split(')')[0],
                                          'alarmdate': DateFormat.yMMMd('it_IT').add_jm().format(date!),
                                          'archived': archived})
                                      : NoteProvider.updateNote({
                                          'id': notes[index]['id'],
                                          'title': notes[index]['title'],
                                          'content': notes[index]['content'],
                                          'creationdate': notes[index]['creationdate'],
                                          'editingdate': notes[index]['editingdate'],
                                          'favorite': 0,
                                          'color': _color.toString().split('(0x')[1].split(')')[0],
                                          'alarmdate': DateFormat.yMMMd('it_IT').add_jm().format(date!),
                                          'archived': archived,
                                        });

                                  setState(() {
                                    if (favorite == 0)
                                      favorite = 1;
                                    else
                                      favorite = 0;
                                  });
                                },
                                title: Text(
                                  "Aggiungi ai preferiti",
                                  style: kBigTextStyle,
                                ),
                                leading: Icon(
                                  favorite == 0 ? Icons.favorite_border_rounded : Icons.favorite_rounded,
                                  color: theme.textSelectionColor,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  archived == 0
                                      ? NoteProvider.updateNote({
                                          'id': notes[index]['id'],
                                          'title': notes[index]['title'],
                                          'content': notes[index]['content'],
                                          'creationdate': notes[index]['creationdate'],
                                          'editingdate': notes[index]['editingdate'],
                                          'favorite': favorite,
                                          'color': _color.toString().split('(0x')[1].split(')')[0],
                                          'alarmdate': DateFormat.yMMMd('it_IT').add_jm().format(date!),
                                          'archived': 1,
                                        })
                                      : NoteProvider.updateNote({
                                          'id': notes[index]['id'],
                                          'title': notes[index]['title'],
                                          'content': notes[index]['content'],
                                          'creationdate': notes[index]['creationdate'],
                                          'editingdate': notes[index]['editingdate'],
                                          'favorite': favorite,
                                          'color': _color.toString().split('(0x')[1].split(')')[0],
                                          'alarmdate': DateFormat.yMMMd('it_IT').add_jm().format(date!),
                                          'archived': 0,
                                        });
                                  setState(() {
                                    if (archived == 0)
                                      archived = 1;
                                    else
                                      archived = 0;
                                  });
                                },
                                title: Text(
                                  "Archivia nota",
                                  style: kBigTextStyle,
                                ),
                                leading: Icon(
                                  archived == 0 ? Icons.archive_outlined : Icons.unarchive_outlined,
                                  color: theme.textSelectionColor,
                                ),
                              ),
                              ListTile(
                                onTap: () async {
                                  await NoteProvider.deleteNote(notes[index]['id']);
                                },
                                title: Text(
                                  "Elimina nota",
                                  style: kBigTextStyle,
                                ),
                                leading: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: MyColorPicker(
                                  onSelectColor: (value) {
                                    setState(() {
                                      _color = value;
                                      NoteProvider.updateNote({
                                        'id': notes[index]['id'],
                                        'title': notes[index]['title'],
                                        'content': notes[index]['content'],
                                        'creationdate': notes[index]['creationdate'],
                                        'editingdate': notes[index]['editingdate'],
                                        'favorite': favorite,
                                        'color': _color.toString().split('(0x')[1].split(')')[0],
                                        'alarmdate': DateFormat.yMMMd('it_IT').add_jm().format(date!),
                                        'archived': archived,
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
                        );
                      },
                      child: NoteCard(
                        text: notes[index]['title'],
                        content: notes[index]['content'],
                        editDate: notes[index]['editingdate'],
                        favorite: notes[index]['favorite'],
                        color: notes[index]['color'],
                        archived: notes[index]["archived"],
                        id: notes[index]['id'].toString(),
                      ),
                    );
                  }),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
