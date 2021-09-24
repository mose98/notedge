
import 'package:flutter/material.dart';
import 'package:notedget/components/sidebar_row.dart';
import 'package:notedget/models/sidebar.dart';

import '../constants.dart';

class SidebarScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: theme.accentColor.withOpacity(0.8),
            borderRadius: BorderRadius.all(Radius.circular(34)),
          ),
          height: MediaQuery.of(context).size.height * 0.85,
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
                          "Impostazioni",
                          style: kCalloutLabelStyle.copyWith(fontWeight: FontWeight.w800),
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
        ),
      ),
    );
  }
}
