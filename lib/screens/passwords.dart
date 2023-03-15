import 'package:flutter/material.dart';
import '../data/shared_prefs.dart';
import './password_detail.dart';
import '../data/sembast_db.dart';
import '../models/password.dart';

class PasswordsScreen extends StatefulWidget {
  @override
  _PasswordsScreenState createState() => _PasswordsScreenState();
}

class _PasswordsScreenState extends State<PasswordsScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings = SPSettings();
  late SembastDb db;
  @override
  void initState() {
    db = SembastDb();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passwords List'),
        backgroundColor: Color(settingColor),
      ),
      body: FutureBuilder(
        future: getPassword(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Password> pass = snapshot.data ?? [];
          return ListView.builder(
            itemCount: pass != null ? pass.length : 0,
            itemBuilder: (_, index) {
              return Dismissible(
                  key: Key(pass[index].id.toString()),
                  onDismissed: (_) {
                    db.deletePassword(pass[index]);
                  },
                  child: ListTile(
                    trailing: const Icon(Icons.edit),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PasswordDetailDialog(
                                Password(
                                    name: pass[index].name,
                                    password: pass[index].password),
                                false);
                          });
                    },
                    title: Text(
                      pass[index].name,
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(settingColor),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return PasswordDetailDialog(
                      Password(name: '', password: ''), true);
                });
          },
          child: const Icon(Icons.add)),
    );
  }

  Future<List<Password>> getPassword() async {
    List<Password> password = await db.readPassword();
    return password;
  }
}
