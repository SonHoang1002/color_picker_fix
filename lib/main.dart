import 'package:color_picker_fix/commons/colors.dart';
import 'package:color_picker_fix/commons/constant.dart';
import 'package:color_picker_fix/helpers/navigator_route.dart';
import 'package:color_picker_fix/screens/color_picker_1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Color _currentColor;
  bool _isExpanded = false;
  double? _colorPickerHeight;
  final GlobalKey _keyColorPicker = GlobalKey(debugLabel: "_keyColorPicker");
  @override
  void initState() {
    super.initState();
    _currentColor = const Color(0xFF5E2FEB);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(color: _currentColor),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Obtain shared preferences.
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          List<String>? listColorsString =
              prefs.getStringList("colors_saved")??[];
              // convert List<String> to List<Color>
          List<Color> listSavedColor = listColorsString.map((e) => Color(int.parse(e))).toList();
          showModalBottomSheet(
              context: context,
              builder: (ctx) {
                return StatefulBuilder(builder: (context, setStatefull) {
                  return ColorPicker(
                    key: _keyColorPicker,
                    topicColor: const Color.fromRGBO(0, 0, 0, 0.05),
                    currentColor: _currentColor,
                    onDone: (color) {
                      setState(() {
                        _currentColor = color;
                      });
                      popNavigator(context);
                    },
                    listColorSaved: ALL_COLORS,
                    onColorSave: (Color color) async{
                       final SharedPreferences prefs = await SharedPreferences.getInstance();
                       List<String> listColorString = prefs.getStringList("saved_color")??[];
                       List<Color> listSavedColor = listColorString.map((e) => Color(int.parse(e))).toList();
                       // kiem tra xem co mau do trong list chua
                       if(listSavedColor.contains(color)){
                        // rerender list save color
                       }else{
                        // add vao dau danh sach save color
                       }
                       // update prefs
                    },
                  );
                });
              },
              isScrollControlled: true);
        },
      ),
    );
  }
}
