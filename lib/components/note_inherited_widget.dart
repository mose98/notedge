import 'package:flutter/material.dart';

class NoteInheritedWidget extends InheritedWidget {
  NoteInheritedWidget({
    required Widget child,
  }) : super(child: child);

  final notes = [
    {
      'title': 'nota1',
      'content': 'ciAO A TUTTI'
    },
    {
      'title': 'NOTA2',
      'content': 'ciAOWERWERWER'
    },
    {
      'title': 'NOTA3',
      'content': 'ciAO A WEROIJWEGOIB IOJFD OIJOIEFJOIHQEOF'
    },
  ];


  static NoteInheritedWidget of(BuildContext context) {
    final NoteInheritedWidget? result = context.dependOnInheritedWidgetOfExactType<NoteInheritedWidget>();
    assert(result != null, 'No NoteInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(NoteInheritedWidget old) {
    return old.notes!= notes;
  }
}
