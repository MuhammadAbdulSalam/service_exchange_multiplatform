import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants.dart';

class SideNavigationBar extends StatefulWidget {
  @override
  _SideNavigationBar createState() => _SideNavigationBar();
}

class _SideNavigationBar extends State<SideNavigationBar> {
  void setDark(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.COLOR_THEME, value);
  }

  @override
  Widget build(BuildContext context) {
    // isDark();
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        color: Constants.THEME_DEFAULT_BACKGROUND,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('X exit'),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                    Constants.DEFAULT_ORANGE,
                    Constants.DEFAULT_BLUE,
                  ])),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              Text(
                "Dark Mode ",
                style: TextStyle(
                    color: Constants.THEME_LABEL_COLOR,
                    fontWeight: FontWeight.bold),
              ),
              Switch(
                value: Constants.IS_THEME_DARK,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      Constants.homeThemeDark();
                      Constants.IS_THEME_DARK = true;
                      setDark(true);
                    } else {
                      Constants.homeThemeLight();
                      Constants.IS_THEME_DARK = false;
                      setDark(false);
                    }
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ]),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
