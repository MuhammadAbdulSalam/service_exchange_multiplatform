import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_exchange_multiplatform/ui/homepage/PostsHomePage.dart';
import 'package:service_exchange_multiplatform/ui/newadd/PostNewAdd.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/CustomPagerPhysics.dart';
import 'package:service_exchange_multiplatform/utils/uicomponents/Dialoge.dart';
import 'package:service_exchange_multiplatform/utils/uicomponents/SideNavigationBar.dart';
import 'package:service_exchange_multiplatform/utils/uicomponents/bottombar/flip_bar_item.dart';
import 'package:service_exchange_multiplatform/utils/uicomponents/bottombar/flip_box_bar.dart';

final icons = [
  Icons.clear,
  Icons.my_location,
  Icons.auto_fix_high,
];

class LandingActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LandingActivity();
  }
}

class _LandingActivity extends State<LandingActivity> {
  int selectedIndex = 0;
  PageController _pageController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _changePage(int pageNum) {
    setState(() {
      selectedIndex = pageNum;
      _pageController.animateToPage(
        pageNum,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        key: _scaffoldKey,
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
        ),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  leading: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      }),
                  expandedHeight: 70.0,
                  floating: true,
                  pinned: false,
                  snap: true,
                  elevation: 50,
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
                        child: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Image.network(
                        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                        fit: BoxFit.cover,
                      ),
                    )),
                  ),
                ),
              ];
            },
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (int page) {
                setState(() {
                  selectedIndex = page;
                });
              },
              controller: _pageController,
              children: [
                PlaceholderWidget(Colors.black87),
                PlaceholderWidget(Constants.BLUE_SHADE_2),
                PostsHomePage(),
                PostNewAdd(),
              ],
            )),
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
      _changePage(index);
    });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
