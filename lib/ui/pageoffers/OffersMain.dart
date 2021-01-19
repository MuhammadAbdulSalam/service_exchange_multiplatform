import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/ui/postspage/items/PostItem.dart';
import 'package:service_exchange_multiplatform/ui/postspage/items/PostItemsList.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseCallHelper.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseHelper.dart';

import 'item/OfferItem.dart';

class OffersMain extends StatefulWidget {
  @override
  _OffersMain createState() => _OffersMain();
}

final topIcons = [
  Icons.book_outlined,
  Icons.send_outlined,
  Icons.refresh,
  Icons.filter_alt_rounded
];

class _OffersMain extends State<OffersMain> {
  OffersListType listType = OffersListType.RECEIVED;
  int selectedIconIndex = 0;
  bool isOfferSent = false;
  bool isOfferReceived = true;
  HashMap sentOffersHash = new HashMap<String, String>();

  String iconText(int index) {
    switch (index) {
      case 0:
        return "Recieved";
        break;
      case 1:
        return "Sent";
        break;
      case 2:
        return "Refresh";
        break;
      case 3:
        return " Filter";
        break;
    }
  }

  Color getColor(int selectedIndex, int index) {
    if (selectedIconIndex == index && index != 2) {
      return Colors.pinkAccent;
    } else {
      return Colors.grey;
    }
  }

  int getReverseNumbers(int listIndex, int snapshotLength) {
    if (listIndex == 0) {
      listIndex = snapshotLength - 1;
    } else {
      listIndex = snapshotLength - listIndex - 1;
    }
    return listIndex;
  }

  FutureBuilder getListView() {
    FirebaseCallHelper firebaseCallHelper = FirebaseCallHelper();
    return FutureBuilder(
      future: firebaseCallHelper.getOffersPosts(listType, sentOffersHash),
      // async work
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('Press button to start');
          case ConnectionState.waiting:
            return new Scaffold(
              backgroundColor: Constants.THEME_DEFAULT_BACKGROUND,
              body: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    child: CircularProgressIndicator(),
                  )),
            );
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else {
              if (snapshot.data.length == 0) {
                return Container(
                  color: Constants.THEME_DEFAULT_BACKGROUND,
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconTheme(
                          data: new IconThemeData(
                              color: Constants.THEME_DEFAULT_TEXT),
                          child: new Icon(
                            Icons.info,
                            size: 20,
                          ),
                        ),
                        Text(
                          "  Currently No offers Available",
                          style: TextStyle(
                            color: Colors.blueAccent,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: OfferItem(
                            snapshot,
                            getReverseNumbers(index, snapshot.data.length),
                            isOfferReceived,
                            isOfferSent));
                  },
                );
              }
            }
        }
      },
    );
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
                topIcons.length,
                (index) => Expanded(
                  child: GestureDetector(
                      onTap: () => {
                            setState(() {
                              switch (index) {
                                case 0:
                                  listType = OffersListType.RECEIVED;
                                  isOfferReceived = true;
                                  isOfferSent = false;
                                  break;
                                case 1:
                                  listType = OffersListType.SENT;
                                  isOfferReceived = false;
                                  isOfferSent = true;

                                  sentOffersHash = HashMap<String, String>();
                                  FirebaseHelper.USER_DB
                                      .child(FirebaseAuth
                                          .instance.currentUser.uid
                                          .toString())
                                      .child("sentOffers")
                                      .onChildAdded
                                      .listen((event) {

                                        setState(() {
                                          sentOffersHash.putIfAbsent(
                                              event.snapshot.key.toString(),
                                                  () => event.snapshot.value.toString());
                                        });

                                  });
                                  break;
                                // case 2:
                                //   listTypeToGet = listTypeToGet;
                                //   index = selectedIconIndex;
                                //   break;
                                // case 3:
                                //   listTypeToGet = listType.FILER;
                                //   break;
                              }
                              selectedIconIndex = index;
                            })
                          },
                      child: Container(
                        child: Column(
                          children: [
                            Icon(
                              topIcons[index],
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
                child: getListView(),
              ),
            ],
          )),
        ])));
  }
}
