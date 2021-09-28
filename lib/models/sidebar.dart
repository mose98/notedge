import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notedget/buttons/theme_button.dart';
import 'package:notedget/buttons/view_button.dart';

class SidebarItem {
  SidebarItem({required this.title, required this.subtitle, required this.widget});

  String title;
  String subtitle;
  Widget widget;
}

var sidebarItem = [
  SidebarItem(
    title: "Modalità notte",
    subtitle: "cambia l'aspetto principale",
    widget: ChangeThemeButtonWidget()
  ),
];
