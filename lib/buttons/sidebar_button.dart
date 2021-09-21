import 'package:flutter/material.dart';

class SidebarButton extends StatelessWidget {
  SidebarButton({required this.triggerAnimation});

  final Function() triggerAnimation;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return RawMaterialButton(
        onPressed: triggerAnimation,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        constraints: BoxConstraints(maxHeight: 40, maxWidth: 40),
        child: Container(
          decoration: BoxDecoration(color: theme.buttonColor, borderRadius: BorderRadius.circular(14), boxShadow: [
            BoxShadow(
              color: theme.primaryColor,
              offset: Offset(0, 12),
              blurRadius: 16,
            )
          ]),
          child: Image.asset('assets/icons/icon-sidebar.png', color: theme.iconTheme.color),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ));
  }
}