import 'dart:io';
import 'package:flutter/material.dart';

// Text Styles
var kLargeTitleStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  fontFamily: Platform.isIOS ? 'SFUIDisplay' : 'Montserrat',
  decoration: TextDecoration.none,
);
var kTitleStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  fontFamily: Platform.isIOS ? 'SFUIDisplay' : 'Montserrat',
  decoration: TextDecoration.none,
);
var kBigTextStyle = TextStyle(
  fontFamily: Platform.isIOS ? 'SFUIDisplay' : 'Montserrat',
  //color: Colors.white,
  fontSize: 18.0,
  decoration: TextDecoration.none,
);
var kNormalTextStyle = TextStyle(
  fontSize: 15.0,
  //color: kSecondaryLabelColor,
  fontFamily: Platform.isIOS ? 'SFUIDisplay' : 'Montserrat',
  decoration: TextDecoration.none,
);
var kSmallTextStyle = TextStyle(
  fontSize: 13.0,
  //color: Colors.black,
  fontFamily: Platform.isIOS ? 'SFUIDisplay' : 'Montserrat',
  decoration: TextDecoration.none,
);


ViewMode viewMode = ViewMode.LISTVIEW;

enum ViewMode{
  LISTVIEW,
  GRIDVIEW,
}

enum NoteMode{
  New,
  Modify
}