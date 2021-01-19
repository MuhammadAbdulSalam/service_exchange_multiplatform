import 'dart:async';

import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/ui/postspage/items/PostItemsList.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';

import '../../utils/FirebaseCallHelper.dart';

final icons = [
  Icons.near_me,
  Icons.person,
  Icons.refresh,
  Icons.filter_alt_rounded,
];

class PostsHomePage extends StatefulWidget {
  @override
  _PostsHomePage createState() => _PostsHomePage();
}

class _PostsHomePage extends State<PostsHomePage> {
  listType listTypeToGet = listType.NEAR_ME;
  int selectedIconIndex = 0;

  Color getColor(int selectedIndex, int index) {
    if (selectedIconIndex == index && index != 2) {
      return Colors.pinkAccent;
    } else {
      return Colors.grey;
    }
  }

  String iconText(int index) {
    switch (index) {
      case 0:
        return "Near Me";
        break;
      case 1:
        return "My Posts";
        break;
      case 2:
        return "Refresh";
        break;
      case 3:
        return "Filter";
        break;
    }
  }

  Timer timer;

  @override
  void initState() {
    super.initState();

    setState(() {
      listTypeToGet = listType.NEAR_ME;
    });

    if (Constants.FIRST_START_POSTPAGE) {
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        timer.cancel();
        t.cancel();

        setState(() {
          Constants.FIRST_START_POSTPAGE = false;
        });
      });
    }
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // var futureBuilder =
    return Container(
        color: Constants.THEME_DEFAULT_BLACK,
        child: SafeArea(
            child: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 2.0, color: Constants.THEME_DEFAULT_BORDER),
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: List.generate(
                icons.length,
                (index) => Expanded(
                  child: GestureDetector(
                      onTap: () => {
                            setState(() {
                              switch (index) {
                                case 0:
                                  listTypeToGet = listType.NEAR_ME;
                                  break;
                                case 1:
                                  listTypeToGet = listType.MY_POSTS;
                                  break;
                                case 2:
                                  listTypeToGet = listTypeToGet;
                                  index = selectedIconIndex;
                                  break;
                                case 3:
                                  listTypeToGet = listType.FILER;
                                  break;
                              }
                              selectedIconIndex = index;
                            })
                          },
                      child: Container(
                        child: Column(
                          children: [
                            Icon(
                              icons[index],
                              color: getColor(selectedIconIndex, index),
                            ),
                            Text(
                              iconText(index),
                              style: TextStyle(
                                  color: Constants.THEME_DEFAULT_WHITE,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ),
          Expanded(
              child: new Column(
            children: [
              new Container(
                  color: Constants.THEME_RECYCLER_BACKGROUND,
                  height: MediaQuery.of(context).size.height - 130,
                  child: PostsItemsList(listTypeToGet))
            ],
          )),
        ])));
  }
}
