import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:notedget/components/home_navbar.dart';
import 'package:notedget/components/note_card.dart';
import 'package:notedget/components/note_inherited_widget.dart';
import 'package:notedget/constants.dart';
import 'package:notedget/provider/note_provider.dart';
import 'package:notedget/screens/note_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share/share.dart';

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
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: NoteProvider.getNoteList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final notes = snapshot.data as List<Map<String, dynamic>>;
              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                physics: BouncingScrollPhysics(),
                children: List.generate(notes.length, (index) {
                  return FocusedMenuHolder(
                    blurSize: 4,
                    menuWidth: MediaQuery.of(context).size.width * 0.5,
                    animateMenuItems: false,
                    blurBackgroundColor: theme.backgroundColor,
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: NoteScreen(
                                note: notes[index],
                                noteMode: NoteMode.Modify,
                              )));
                    },
                    menuItems: [
                      FocusedMenuItem(
                          title: Text(
                            "Apri",
                            style: kNormalTextStyle,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: NoteScreen(
                                      note: notes[index],
                                      noteMode: NoteMode.Modify,
                                    )));
                          },
                          trailingIcon: Icon(
                            Icons.open_in_new,
                            color: theme.textSelectionColor,
                          ),
                          backgroundColor: theme.dialogBackgroundColor),
                      FocusedMenuItem(
                          title: Text(
                            "Condividi",
                            style: kNormalTextStyle,
                          ),
                          onPressed: () {
                            Share.share(notes[index]['title'] + '\n\n' + notes[index]['content']);
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
                            notes[index]['favorite'] == 0
                                ? NoteProvider.updateNote({
                              'id': notes[index]['id'],
                              'title': notes[index]['title'],
                              'content': notes[index]['content'],
                              'creationdate': notes[index]['creationdate'],
                              'editingdate': notes[index]['editingdate'],
                              'favorite': 1,
                              'color': notes[index]['color'],
                              'alarmdate': notes[index]['alarmdate'],
                            }) : NoteProvider.updateNote({
                              'id': notes[index]['id'],
                              'title': notes[index]['title'],
                              'content': notes[index]['content'],
                              'creationdate': notes[index]['creationdate'],
                              'editingdate': notes[index]['editingdate'],
                              'favorite': 0,
                              'color': notes[index]['color'],
                              'alarmdate': notes[index]['alarmdate'],
                            });
                            setState(() {});
                          },
                          trailingIcon: Icon(
                            notes[index]['favorite'] == 0 ? Icons.favorite_border_rounded : Icons.favorite_rounded,
                            color: theme.textSelectionColor,
                          ),
                          backgroundColor: theme.dialogBackgroundColor),
                      FocusedMenuItem(
                          title: Text(
                            "Elimina",
                            style: kNormalTextStyle.copyWith(color: Colors.redAccent, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            await NoteProvider.deleteNote(notes[index]['id']);
                            setState(() {

                            });
                          },
                          trailingIcon: Icon(Icons.delete, color: Colors.redAccent),
                          backgroundColor: theme.dialogBackgroundColor)
                    ],
                    child: NoteCard(
                      text: notes[index]['title'],
                      content: notes[index]['content'],
                      editDate: notes[index]['editingdate'],
                      favorite: notes[index]['favorite'],
                      color: notes[index]['color'],
                    ),
                  );
                }),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    ));
  }
}
