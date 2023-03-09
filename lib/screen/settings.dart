import 'package:flutter/material.dart';
import 'package:persisting_data/data/shared_prefs.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int settingColor = 0xFF1976d2;
  double fontSize = 12;
  String fontName = 'small';
  List<int> colors = [
    0xFF455A64,
    0xFFFC107,
    0xFF673AB7,
    0xFFF57C00,
    0xFF795748
  ];
  late SizeApp firstSize = SizeApp(fontName, fontSize);
  List<SizeApp> fontSizes = [
    SizeApp('small', 12),
    SizeApp('medium', 16),
    SizeApp('large', 20),
  ];
  SPSettings settings = SPSettings();

  @override
  void initState() {
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
        fontName = settings.getFontName();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Setting',
            style: TextStyle(fontSize: fontSize),
          ),
          backgroundColor: Color(settingColor),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "App Main Color",
              style: TextStyle(fontSize: fontSize),
            ),
            DropdownButton<SizeApp>(
              items: fontSizes.map((value) {
                //fontSizes.reversed;
                return DropdownMenuItem<SizeApp>(
                    value: value, child: Text(value.sizeName));
              }).toList(),
              value: firstSize,
              onChanged: (value) {
                setState(() {
                  firstSize = value!;
                });
                setSize(firstSize);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => setColor(colors[0]),
                  child: SquareColor(colors[0]),
                ),
                GestureDetector(
                  onTap: () => setColor(colors[1]),
                  child: SquareColor(colors[1]),
                ),
                GestureDetector(
                  onTap: () => setColor(colors[2]),
                  child: SquareColor(colors[2]),
                ),
                GestureDetector(
                  onTap: () => setColor(colors[3]),
                  child: SquareColor(colors[3]),
                ),
                GestureDetector(
                  onTap: () => setColor(colors[4]),
                  child: SquareColor(colors[4]),
                ),
              ],
            )
          ],
        ));
  }

  void setColor(int color) {
    setState(() {
      settingColor = color;
      settings.setColor(color);
    });
  }

  void setSize(SizeApp size) {
    setState(() {
      fontSize = size.sizeValue;
      settings.setFontSize(size.sizeValue);
      fontName = size.sizeName;
      settings.setFontName(size.sizeName);
    });
  }
}

class SquareColor extends StatelessWidget {
  final int colorCode;

  const SquareColor(this.colorCode, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: Color(colorCode),
      ),
    );
  }
}

class SizeApp {
  final String sizeName;
  final double sizeValue;

  SizeApp(this.sizeName, this.sizeValue);
}
