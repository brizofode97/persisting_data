import 'package:flutter/material.dart';
import 'package:persisting_data/screens/posts.dart';
import '../data/shared_prefs.dart';
import '../screens/passwords.dart';
import '../screens/settings.dart';
// import 'note.dart';
import 'notes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings = SPSettings();
  @override
  void initState() {
    getSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSettings(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(settingColor),
            title: const Text('GlobApp'),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(settingColor),
                  ),
                  child: const Text('GlobApp Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                      )),
                ),
                ListTile(
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingScreen()));
                  },
                ),
                ListTile(
                  title: Text(
                    'Passwords',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordsScreen()));
                  },
                ),
                ListTile(
                  title: Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotesScreen()));
                  },
                ),
                ListTile(
                  title: Text(
                    'Posts',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostsScreen()));
                  },
                ),
              ],
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/travel.jpg'), fit: BoxFit.cover)),
          ),
        );
      },
    );
  }

  Future getSettings() async {
    settings = SPSettings();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
  }
}
