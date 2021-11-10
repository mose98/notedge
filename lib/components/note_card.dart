import 'package:flutter/material.dart';
import 'package:notedget/constants.dart';

class NoteCard extends StatelessWidget {
  String? text;
  String? content;
  String? editDate;
  int? favorite;
  String? color;
  int? archived;
  String? id;

  NoteCard({this.text, this.content, this.editDate, this.favorite, this.color, this.archived, this.id});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height / 4,
          decoration: BoxDecoration(
            color: theme.accentColor,
            border: Border.all(width: 1, color: theme.accentColor),
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
                      style: kBigTextStyle,
                    ),
                    subtitle: Text(
                      editDate ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kSmallTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      content ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: kNormalTextStyle,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Icon(
                      archived == 0 ? null : Icons.archive_rounded,
                      color: Colors.blueAccent
                  ),
                ),
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Color(int.parse(color!, radix: 16)),
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: Color(int.parse(color!, radix: 16)))),
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
