import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_picker.dart';

class ModalFit extends StatelessWidget {
  const ModalFit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text('Edit'),
          leading: Icon(Icons.edit),
          onTap: () => Navigator.of(context).pop(),
        ),
        ListTile(
          title: Text('Copy'),
          leading: Icon(Icons.content_copy),
          onTap: () => Navigator.of(context).pop(),
        ),
        ListTile(
          title: Text('Cut'),
          leading: Icon(Icons.content_cut),
          onTap: () => Navigator.of(context).pop(),
        ),
        ListTile(
          title: Text('Move'),
          leading: Icon(Icons.folder_open),
          onTap: () => Navigator.of(context).pop(),
        ),
        ListTile(
          title: Text('Delete'),
          leading: Icon(Icons.delete),
          onTap: () => Navigator.of(context).pop(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: MyColorPicker(
              onSelectColor: (value) {},
              availableColors: [
                //theme.scaffoldBackgroundColor,
                new Color(Colors.green[200]!.value),
                new Color(Colors.yellow[200]!.value),
                new Color(Colors.red[200]!.value),
                new Color(Colors.purple[200]!.value),
                new Color(Colors.grey[200]!.value),
                new Color(Colors.teal[200]!.value),
                new Color(Colors.blue[200]!.value),
                new Color(Colors.orange[200]!.value),
                new Color(Colors.amber[200]!.value),
                new Color(Colors.blueGrey[200]!.value),
                new Color(Colors.brown[200]!.value),
                new Color(Colors.cyan[200]!.value),
                new Color(Colors.deepOrange[200]!.value),
                new Color(Colors.deepPurple[200]!.value),
                new Color(Colors.lightBlue[200]!.value),
                new Color(Colors.lightGreen[200]!.value),
                new Color(Colors.lime[200]!.value),
                new Color(Colors.pink[200]!.value),
                new Color(Colors.yellow[200]!.value),
                new Color(Colors.amberAccent[200]!.value),
                new Color(Colors.orangeAccent[200]!.value),
                new Color(Colors.greenAccent[200]!.value),
                new Color(Colors.redAccent[200]!.value),
                new Color(Colors.blueAccent[200]!.value),
                new Color(Colors.cyanAccent[200]!.value),
                new Color(Colors.deepOrangeAccent[200]!.value),
                new Color(Colors.deepPurpleAccent[200]!.value),
                new Color(Colors.indigoAccent[200]!.value),
                new Color(Colors.lightBlueAccent[200]!.value),
                new Color(Colors.lightGreenAccent[200]!.value),
                new Color(Colors.limeAccent[200]!.value),
                new Color(Colors.pinkAccent[200]!.value),
                new Color(Colors.purpleAccent[200]!.value),
                new Color(Colors.tealAccent[200]!.value),
                new Color(Colors.yellowAccent[200]!.value),
              ],
              initialColor: Colors.green[200]!),
        ),
      ],
    );
  }
}
