import 'package:flutter/material.dart';
import 'package:notedget/constants.dart';

class NoteCard extends StatelessWidget {
  String? text;
  String? content;
  String? editDate;
  int? favorite;

  NoteCard({this.text, this.content, this.editDate, this.favorite});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.10,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: theme.highlightColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: null,
              title: Text(
                text ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kCardTitleStyle,
              ),
              subtitle: Text(
                editDate ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kCardSubtitleStyle,
              ),
              trailing: favorite == 0 ? Icon(Icons.favorite_border_rounded, color: Colors.blueAccent,) : Icon(Icons.favorite_rounded, color: Colors.blueAccent,),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                content ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: kBodyLabelStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
