import 'package:flutter/material.dart';
import 'package:notedget/buttons/sidebar_button.dart';

class SidebarButtonNavBar extends StatelessWidget {
  SidebarButtonNavBar({@required this.triggerAnimation});

  final triggerAnimation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),

      child: Row(
        children: [
          SidebarButton(
            triggerAnimation: triggerAnimation,
          ),
        ],
      ),
    );
  }
}