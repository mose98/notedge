import 'package:flutter/material.dart';
import 'package:notedget/components/note_inherited_widget.dart';
import 'package:notedget/constants.dart';
import 'package:notedget/screens/home.dart';
import 'package:page_transition/page_transition.dart';

class NoteScreen extends StatefulWidget {
  String title;
  String content;
  NoteMode noteMode;
  int index;

  NoteScreen({required this.title, required this.content, required this.noteMode, required this.index});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController contentController = new TextEditingController();

  List<Map<String, String>> get _notes => NoteInheritedWidget.of(context).notes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.title!;
    contentController.text = widget.content!;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: BackButtonIcon(),
        onPressed: (){
          final title = titleController.text;
          final content = contentController.text;

          if(widget.noteMode == NoteMode.New){
            _notes.add({
              'title': title,
              'content': content
            });
          }
          else if(widget.noteMode == NoteMode.Modify){
            _notes[widget.index] = {
              'title': title,
              'content': content
            };
          }
          Navigator.of(context).pop();
        },
      ),
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller: titleController,
                    cursorColor: theme.iconTheme.color,
                    maxLines: 1,
                    style: kCardTitleStyle,
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
          ),
        ),
      ),
    );
  }
}
