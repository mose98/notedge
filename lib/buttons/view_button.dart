import 'package:flutter/material.dart';
import 'package:notedget/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ChangeViewButtonWidget extends StatefulWidget {

  @override
  State<ChangeViewButtonWidget> createState() => _ChangeViewButtonWidgetState();
}

class _ChangeViewButtonWidgetState extends State<ChangeViewButtonWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Switch.adaptive(
      value: viewMode == ViewMode.LISTVIEW,
      onChanged: (value){
        setState(() {
          viewMode == ViewMode.LISTVIEW ? (viewMode = ViewMode.GRIDVIEW) : (viewMode = ViewMode.LISTVIEW);
        });
      },
      activeColor: theme.iconTheme.color,
    );
  }
}
