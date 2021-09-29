import 'package:flutter/material.dart';

class MyColorPicker extends StatefulWidget {
  final Function onSelectColor; // This function sends the selected color to outside
  final List<Color> availableColors; // List of pickable colors
  final Color initialColor; // The default picked color
  final bool circleItem; // Determnie shapes of color cells

  MyColorPicker(
      {required this.onSelectColor,
      required this.availableColors,
      required this.initialColor,
      this.circleItem = true});

  @override
  _MyColorPickerState createState() => _MyColorPickerState();
}

class _MyColorPickerState extends State<MyColorPicker> {
  // This variable used to determine where the checkmark will be
  late Color _pickedColor;

  @override
  void initState() {
    _pickedColor = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: widget.availableColors.length * 40,
      child: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 30,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: widget.availableColors.length,
          itemBuilder: (context, index) {
            final itemColor = widget.availableColors[index];
            return InkWell(
              onTap: () {
                widget.onSelectColor(itemColor);
                setState(() {
                  _pickedColor = itemColor;
                });
              },
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: itemColor,
                    shape: widget.circleItem == true
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                    border: Border.all(width: 2, color: Colors.grey[300]!)),
                child: itemColor == _pickedColor
                    ? Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      )
                    : Container(),
              ),
            );
          },
        ),
      ),
    );
  }
}