import 'package:flutter/material.dart';
import 'package:notedget/components/modals/floating_modal.dart';
import 'package:notedget/components/note_card.dart';
import 'package:notedget/constants.dart';
import 'package:notedget/provider/note_provider.dart';
import 'package:notedget/screens/note_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'modal_fit.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    var smallestDimension = MediaQuery.of(context).size.shortestSide;
    final useMobileLayout = smallestDimension < 600;
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
                  return GestureDetector(
                    onLongPress: () {
                      showFloatingModalBottomSheet(
                        //expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ModalFit(),
                      );
                    },
                    child: GestureDetector(
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
                      child: NoteCard(
                        text: notes[index]['title'],
                        content: notes[index]['content'],
                        editDate: notes[index]['editingdate'],
                        favorite: notes[index]['favorite'],
                        color: notes[index]['color'],
                      ),
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
