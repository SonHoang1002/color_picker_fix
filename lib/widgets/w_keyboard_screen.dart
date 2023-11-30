import 'package:color_picker_fix/commons/colors.dart';
import 'package:color_picker_fix/helpers/navigator_route.dart';
import 'package:color_picker_fix/widgets/w_custom_keyboard.dart';
import 'package:flutter/material.dart';

class CustomKeyboardScreen extends StatefulWidget {
  final TextEditingController controller;
  final Function(String value) onEnter;
  final Function() onBackSpace;

  const CustomKeyboardScreen(
      {super.key,
      required this.controller,
      required this.onEnter,
      required this.onBackSpace});

  @override
  State<CustomKeyboardScreen> createState() => _CustomKeyboardScreenState();
}

class _CustomKeyboardScreenState extends State<CustomKeyboardScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          popNavigator(context);
        },
      child: Container(
        color: transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            CustomKeyboardWidget(
              onEnter: widget.onEnter,
              onBackSpace: widget.onBackSpace,
              onDone: () {
                popNavigator(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
