import 'package:flutter/material.dart';
import 'package:persisting_data/data/shared_prefs.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int settingColor = 0xFF1976d2;
  SizeApp settingSize = SizeApp(sizeName: 'small', sizeFont: 12);
  List<int> colors = [
    0xFF455A64,
    0xFFFC107,
    0xFF673AB7,
    0xFFF57C00,
    0xFF795748
  ];
  late List<SizeApp> listFont;
  SPSettings settings = SPSettings();

  @override
  void initState() {
    listFont = [
      settingSize,
      SizeApp(sizeName: 'medium', sizeFont: 16),
      SizeApp(sizeName: 'large', sizeFont: 24)
    ];
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        settingSize = SizeApp(
            sizeName: settings.getFontName(), sizeFont: settings.getFontSize());
        listFont = perfectList(settingSize);
      });
    });
    super.initState();
  }

  List<SizeApp> perfectList(SizeApp chaine) {
    List<SizeApp> list = [];
    switch (chaine.sizeName) {
      case "medium":
        list = [
          chaine,
          SizeApp(sizeName: 'small', sizeFont: 12),
          SizeApp(sizeName: 'large', sizeFont: 24)
        ];
        break;
      case "large":
        list = list = [
          chaine,
          SizeApp(sizeName: 'small', sizeFont: 12),
          SizeApp(sizeName: 'medium', sizeFont: 16)
        ];
        break;
      default:
        list = list = [
          chaine,
          SizeApp(sizeName: 'medium', sizeFont: 16),
          SizeApp(sizeName: 'large', sizeFont: 24)
        ];
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Setting',
            style: TextStyle(
              fontSize: settingSize.sizeFont,
            ),
          ),
          backgroundColor: Color(settingColor),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "App Main Color",
              style: TextStyle(
                  fontSize: settingSize.sizeFont, color: Color(settingColor)),
            ),
            Text(
              'Choose your size App',
              style: TextStyle(
                  fontSize: settingSize.sizeFont, color: Color(settingColor)),
            ),
            DropdownButton<SizeApp>(
              value: settingSize,
              items: listFont.map((value) {
                return DropdownMenuItem<SizeApp>(
                  value: value,
                  child: Text(value.sizeName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  setFont(value!);
                });
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

  void setFont(SizeApp size) {
    settingSize = size;
    settings.setFontName(size.sizeName);
    settings.setFontSize(size.sizeFont);
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
  String sizeName;
  double sizeFont;

  SizeApp({required this.sizeName, required this.sizeFont});
}
