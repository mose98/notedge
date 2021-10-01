import 'package:flutter/material.dart';
import 'package:notedget/constants.dart';

class NoteCard extends StatelessWidget {
  String? text;
  String? content;
  String? editDate;
  int? favorite;
  String? color;

  NoteCard({this.text, this.content, this.editDate, this.favorite, this.color});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    int value = int.parse(color!, radix: 16);
    Color c = new Color(value);
    var textColor = c.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.10,
        height: MediaQuery.of(context).size.height * 0.2,
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
                    style: kBigTextStyle.copyWith(color: textColor),
                  ),
                  subtitle: Text(
                    editDate ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kSmallTextStyle.copyWith(color: textColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    content ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: kNormalTextStyle.copyWith(color: textColor),
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
    );
  }
}
