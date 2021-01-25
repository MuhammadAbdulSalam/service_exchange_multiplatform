import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/main.dart';
import 'package:service_exchange_multiplatform/ui/loginviews/LoginActivity.dart';
import 'package:service_exchange_multiplatform/ui/newadd/PostNewAdd.dart';
import 'package:service_exchange_multiplatform/ui/pageoffers/OffersMain.dart';
import 'package:service_exchange_multiplatform/ui/postspage/PostsHomePage.dart';
import 'package:service_exchange_multiplatform/ui/profilepage/ProfileWidget.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/uicomponents/ProfileInfoWidget.dart';
import 'package:service_exchange_multiplatform/utils/uicomponents/bottombar/flip_bar_item.dart';
import 'package:service_exchange_multiplatform/utils/uicomponents/bottombar/flip_box_bar.dart';

import 'LandingActivity.dart';

class ControllerActivity extends StatefulWidget {
  @override
  _MyTabbedPageState createState() => new _MyTabbedPageState();
}

class _MyTabbedPageState extends State<ControllerActivity>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _mainPageKey = new GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  TabController _tabController;
  var appbarTitle = "Home";


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        key: _mainPageKey,
        drawer: Drawer(
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
                  child: ProfileInfoWidget(true),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                        Constants.DEFAULT_ORANGE,
                        Constants.DEFAULT_BLUE,
                      ])),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
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
                              onTabTapped(selectedIndex);
                            } else {
                              Constants.homeThemeLight();
                              Constants.IS_THEME_DARK = false;
                              onTabTapped(selectedIndex);
                            }
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ]),
                Container(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProfileWidget()));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.blueAccent,
                            size: 24.0,
                          ),
                          Text(
                            "  Profile",
                            style: TextStyle(
                                color: Constants.THEME_LABEL_COLOR,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);

                      FirebaseAuth.instance.signOut();

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SplashScreen()),
                          ModalRoute.withName("/Home"));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.blueAccent,
                            size: 24.0,
                          ),
                          Text(
                            "  Logout",
                            style: TextStyle(
                                color: Constants.THEME_LABEL_COLOR,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
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
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text(appbarTitle),
                leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      _mainPageKey.currentState.openDrawer();
                    }),
                expandedHeight: 0.0,
                pinned: false,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                        Constants.DEFAULT_ORANGE,
                        Constants.DEFAULT_BLUE,
                      ])),
                //   child: Container(
                //      child: Text("SOME TITLE")
                //       ),
                ),
              ),

            ];
          },
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              PlaceholderWidget(Colors.black87),
              PostsHomePage(),
              OffersMain(),
              PostNewAdd(),
            ],
            controller: _tabController,
          ),
        ),
        bottomNavigationBar: FlipBoxBar(
          selectedIndex: selectedIndex,
          items: [
            FlipBarItem(
                icon: Icon(Icons.home),
                text: Text("Home"),
                frontColor: Colors.blue[300],
                backColor: Colors.blue[400]),
            FlipBarItem(
                icon: Icon(Icons.list),
                text: Text("Posts"),
                frontColor: Colors.orange[300],
                backColor: Colors.orange[400]),
            FlipBarItem(
                icon: Icon(Icons.book_outlined),
                text: Text("Offers"),
                frontColor: Colors.purple[300],
                backColor: Colors.purple[400]),
            FlipBarItem(
                icon: Icon(Icons.post_add),
                text: Text("Add"),
                frontColor: Colors.pink[300],
                backColor: Colors.pink[400]),
          ],
          onIndexChanged: (newIndex) {
            onTabTapped(newIndex);
          },
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
      _tabController.animateTo(selectedIndex);
      switch(index)
      {
        case 0: appbarTitle = "Home";
        break;
        case 1: appbarTitle = "Posts";
        break;
        case 2: appbarTitle = "Offers";
        break;
        case 3: appbarTitle = "New Add";
        break;

      }
    });
  }
}
