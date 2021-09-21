import 'package:flutter/material.dart';
import 'package:notedget/components/note_inherited_widget.dart';
import 'package:notedget/l10n/l10n.dart';

import 'package:notedget/provider/theme_provider.dart';
import 'package:notedget/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return NoteInheritedWidget(
            child: MaterialApp(
              title: 'MakhaneRush',
              supportedLocales: L10n.all,
              debugShowCheckedModeBanner: false,
              themeMode: themeProvider.themeMode,
              theme: MyTheme.lightTheme,
              darkTheme: MyTheme.darkTheme,
              home: HomeScreen(),
            ),
          );
        }
    );
  }
}

