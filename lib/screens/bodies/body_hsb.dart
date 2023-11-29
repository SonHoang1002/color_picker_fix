import 'package:color_picker_fix/commons/colors.dart';
import 'package:color_picker_fix/commons/constant.dart';
import 'package:color_picker_fix/widgets/w_text_content.dart';
import 'package:flutter/material.dart';

class BodyHSB extends StatefulWidget {
  const BodyHSB({super.key});

  @override
  State<BodyHSB> createState() => _BodyPickerState();
}

class _BodyPickerState extends State<BodyHSB> {
  late Size _size;
  // keys
  final GlobalKey _keyHue = GlobalKey(debugLabel: "_keyHue");
  final GlobalKey _keySaturation = GlobalKey(debugLabel: "_keySaturation");
  final GlobalKey _keyBrightness = GlobalKey(debugLabel: "_keyBrightness");

  // offsets
  Offset _offsetTrackerHue = const Offset(0, 0);
  Offset _offsetTrackerSaturation = const Offset(0, 0);
  Offset _offsetTrackerBrightness = const Offset(0, 0);

  late RenderBox _renderBoxHue;
  late RenderBox _renderBoxSaturation;
  late RenderBox _renderBrightness;
  // store data
  double _hsbHue = 0;
  double _hsbSaturation = 0;
  double _hsbBrightness = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _renderBoxHue = _keyHue.currentContext?.findRenderObject() as RenderBox;
      _renderBoxSaturation =
          _keySaturation.currentContext?.findRenderObject() as RenderBox;
      _renderBrightness =
          _keyBrightness.currentContext?.findRenderObject() as RenderBox;
    });
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onPanStart: (details) {},
      child: Column(
        children: [
          // hue widget
          _buildTitle("Hue",  (_hsbHue * 100).toStringAsFixed(0)),
          _buildSliderWidget(_keyHue, COLOR_SLIDERS),
          // saturation widget
          _buildTitle("Saturation",  (_hsbSaturation * 100).toStringAsFixed(0)),
          _buildSliderWidget(
            _keySaturation,
            [
              transparent,
              // HSVColor.fromAHSV(_hsbBrightness, _hsbHue, _hsbSaturation, 1)
              //     .toColor()

            ],
          ),
          _buildTitle("Brightness",  (_hsbBrightness * 100).toStringAsFixed(0)),
          _buildSliderWidget(
            _keyBrightness,
            [
              colorBlack,
              HSVColor.fromAHSV(_hsbBrightness, _hsbHue, _hsbSaturation, 1)
                  .toColor()
            ],
          ),
          // brightness widget
        ],
      ),
    );
  }

  Widget _buildTitle(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(top: 20,bottom: 10),
      width: _size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WTextContent(value: title),
          WTextContent(value: value),
        ],
      ),
    );
  }

  Widget _buildSliderWidget(Key key, List<Color> listGradientColor) {
    return SizedBox(
      key: key,
      height: 30,
      width: _size.width * 0.8,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: listGradientColor,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                borderRadius: BorderRadius.circular(15)),
          ),
          Positioned(
            left: _offsetTrackerHue.dx,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 3, color: colorWhite)),
            ),
          )
        ],
      ),
    );
  }
}
