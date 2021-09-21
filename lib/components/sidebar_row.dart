import 'package:flutter/material.dart';
import 'package:notedget/models/sidebar.dart';
import 'package:notedget/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SidebarRow extends StatelessWidget {
  SidebarRow({required this.item});

  final SidebarItem item;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                item.title,
                style: kCalloutLabelStyle.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                item.subtitle,
                style: kCalloutLabelStyle.copyWith(fontWeight: FontWeight.w300, fontSize: 13),
              ),
            )
          ],
        ),
        Container(
            width: 42.0,
            height: 42.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: theme.accentColor.withOpacity(0.4),),
            child: item.widget),
      ],
    );
  }
}
