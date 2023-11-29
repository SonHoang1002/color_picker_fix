import 'package:color_picker_fix/commons/colors.dart';
import 'package:color_picker_fix/commons/constant.dart';
import 'package:flutter/material.dart';

class BodySaved extends StatefulWidget {
  const BodySaved({super.key});

  @override
  State<BodySaved> createState() => _BodySavedState();
}

class _BodySavedState extends State<BodySaved> {
  late Size _size;
  late Color _selectedColor;
  @override
  void initState() {
    super.initState();
    _selectedColor = ALL_COLORS[0];
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return _buildSuggestColor();
  }

  Widget _buildSuggestColor() {
    return SizedBox(
      // width: _size.width * 0.8,
      child: Wrap(
          children: ALL_COLORS
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = e;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.all(5), 
                        decoration: BoxDecoration( 
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 3,
                                color: _selectedColor == e
                                    ? colorGrey
                                    : transparent)),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: e,
                            borderRadius: BorderRadius.circular(15),
                            ),
                      ),
                    ],
                  ),
                ),
              )
              .toList()),
    );
  }
}
