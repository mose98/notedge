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
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.10,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: theme.accentColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            Column(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                              favorite == 0 ? Icons.favorite_border_rounded : Icons.favorite_rounded,
                              color: Colors.redAccent
                            ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
