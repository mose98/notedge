import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notedget/components/notelist.dart';
import 'package:notedget/screens/note_screen.dart';
import 'package:notedget/screens/settings_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Animation<Offset> sidebarAnimation;
  late Animation<double> fadeAnimation;
  late AnimationController sidebarAnimationController;
  var sidebarHidden = true;
  late OverlayEntry _popupDialog;

  @override
  void initState() {
    super.initState();

    sidebarAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    sidebarAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: sidebarAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: sidebarAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    sidebarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(type: PageTransitionType.rightToLeft, child: SettingScreen()),
                      );
                    },
                    child: Icon(
                      Icons.settings,
                      color: theme.accentColor,
                      size: MediaQuery.of(context).size.aspectRatio * 80,
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 30, 5, 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Le mie note",
                          style: kLargeTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      NoteList(),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Material(
                    color: theme.buttonColor,
                    elevation: 30,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      color: theme.buttonColor,
                      onPressed: () {
                        final now = new DateTime.now();
                        String dataText = DateFormat.yMMMd('it_IT').add_jm().format(now);

                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: NoteScreen(
                              noteMode: NoteMode.New,
                              note: {
                                'title': '',
                                'content': '',
                                'creationdate': dataText,
                                'editingdate': dataText,
                                'favorite': 0,
                                'color': theme.scaffoldBackgroundColor.toString().split('(0x')[1].split(')')[0],
                                'alarmdate': 'none',
                                'archived': 0,
                              },
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.aspectRatio * 50,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Nuova nota', style: kNormalTextStyle.copyWith(color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
