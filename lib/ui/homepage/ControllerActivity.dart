import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/ui/newadd/PostNewAdd.dart';
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
                  child: Container(
                      // child: FlexibleSpaceBar(
                      //   centerTitle: true,
                      //   background: Image.network(
                      //     "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      //     fit: BoxFit.cover,
                      //   ),
                      // )
                      ),
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              PlaceholderWidget(Colors.black87),
              PostsHomePage(),
              PlaceholderWidget(Constants.BLUE_SHADE_2),
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
                frontColor: Colors.blueAccent,
                backColor: Colors.blue),
            FlipBarItem(
                icon: Icon(Icons.bookmark),
                text: Text("Posts"),
                frontColor: Colors.orange,
                backColor: Colors.orangeAccent),
            FlipBarItem(
                icon: Icon(Icons.list),
                text: Text("Offers"),
                frontColor: Colors.purple,
                backColor: Colors.purpleAccent),
            FlipBarItem(
                icon: Icon(Icons.post_add),
                text: Text("Add"),
                frontColor: Colors.pink,
                backColor: Colors.pinkAccent),
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
    });
  }
}
