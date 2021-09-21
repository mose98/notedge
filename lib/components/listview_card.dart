import 'package:flutter/material.dart';
import 'package:notedget/constants.dart';

class NoteCard extends StatelessWidget {
  String? title;
  String? content;

  NoteCard({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.10,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: theme.accentColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ListTile(
              leading: null,
              title: Text(
                title!,
                style: kCardTitleStyle,
              ),
              subtitle: Text(
                content!,
                style: kCardSubtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                content!,
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
