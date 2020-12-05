import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';

class ProfileInfoWidget extends StatelessWidget {
  bool isNavBar;

  double getDimens() {
    if (isNavBar) {
      return 50;
    } else {
      return 100;
    }
  }

  double getFontSize() {
    if (isNavBar) {
      return 12;
    } else {
      return 15;
    }
  }

  FontWeight getFontWeight() {
    if (isNavBar) {
      return FontWeight.normal;
    } else {
      return FontWeight.bold;
    }
  }

  double getPadding() {
    if (isNavBar) {
      return 10;
    } else {
      return 40;
    }
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(0, getPadding(), 0, 0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: getDimens(),
              height: getDimens(),
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new NetworkImage(
                          Constants.getImageUrl())))),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              children: [
                Text(
                  Constants.userList[0].name,
                  style: TextStyle(
                      color: Constants.THEME_LABEL_COLOR,
                      fontWeight: getFontWeight(),
                      fontSize: getFontSize()),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
                Text(
                  Constants.userList[0].jobTitle.toString(),
                  style: TextStyle(
                      color: Constants.THEME_LABEL_COLOR,
                      fontWeight: getFontWeight(),
                      fontSize: getFontSize()),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
                Text(
                  FirebaseAuth.instance.currentUser.email,
                  style: TextStyle(
                      color: Constants.THEME_LABEL_COLOR,
                      fontWeight: getFontWeight(),
                      fontSize: getFontSize()),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ProfileInfoWidget(this.isNavBar);
}
