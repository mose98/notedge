
import 'package:flutter/material.dart';
import 'package:notedget/components/sidebar_row.dart';
import 'package:notedget/models/sidebar.dart';

import '../constants.dart';

class SidebarScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.accentColor.withOpacity(0.8),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(34.0),
          bottomRight: Radius.circular(34.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.70,
      width: MediaQuery.of(context).size.width * 0.85,
      padding: EdgeInsets.symmetric(
        vertical: 35.0,
        horizontal: 20.0,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Notedget",
                      style: kCalloutLabelStyle.copyWith(fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "11 note",
                      //style: kSearchPlaceholderStyle,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            GestureDetector(
              onTap: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => IntroScreen(user: user)));
              },
              child: SidebarRow(
                item: sidebarItem[0],
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            GestureDetector(
              onTap: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => IntroScreen(user: user)));
              },
              child: SidebarRow(
                item: sidebarItem[1],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
