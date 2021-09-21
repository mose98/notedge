import 'package:flutter/material.dart';
import 'package:notedget/constants.dart';
import 'package:notedget/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  ViewMode view = ViewMode.GRIDVIEW;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var theme = Theme.of(context);
    return Switch.adaptive(
        value: themeProvider.isDarkMode,
        onChanged: (value){
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(value);
        },
      activeColor: theme.iconTheme.color,
    );
  }
}
