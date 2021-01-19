import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseHelper.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseHelper.dart';

class OfferViewItem extends StatefulWidget {

  AsyncSnapshot snapshot;
  int itemIndex;

  OfferViewItem(this.snapshot, this.itemIndex);

  @override
  _OfferViewItem createState() => _OfferViewItem(snapshot, itemIndex);
}

class _OfferViewItem extends State<OfferViewItem> {

  AsyncSnapshot snapshot;
  int itemIndex;
  _OfferViewItem(this.snapshot, this.itemIndex);
  String userName = "";
  String dpUrl = "";
  String profession = "";
  
  void getUserData(){
     FirebaseHelper.USER_DB.child(snapshot.data[itemIndex].offerdID).once().then((value) async {
       userName = value.value["name"].toString();
       dpUrl = value.value["dpUrl"].toString();
       profession = value.value["jobTitle"].toString();
       setState(() {
       });
     });

  }


  @override
  void initState() {
    super.initState();
    getUserData();
  }

    Color tagColor(String value) {
    if (value == "yes") {
      if (Constants.IS_THEME_DARK) {
        return Colors.green[200];
      }
      return Colors.green[200];
    } else {
      return Colors.grey;
    }
  }

  Color getButtonIconColor(int index) {
    switch (index) {
      case 0 :
        return Colors.blue[200];
        break;
      case 1 :
        return Colors.green[200];
        break;
      case 2 :
        return Colors.pink[200];
        break;
    }
  }

  String getUsrDpUrl() {
    if (dpUrl == "default" || dpUrl == "") {
      return "https://www.woolha.com/media/2019/06/buneary.jpg";
    } else {
      return dpUrl;
    }
  }

  String buttonText(int index) {
    switch (index) {
      case 0:
        return " Message";
        break;
      case 1:
        return snapshot.data[index].status == "pending"? " Accept"  : "Waiting";
        break;
      case 2:
        return " Decline";
        break;
    }
  }

  List<IconData> getIconList() {
    return [
      Icons.chat_rounded,
      Icons.thumb_up_alt_outlined,
      Icons.cancel_outlined
    ];
  }


  @override
  Widget build(BuildContext context) {
   // getUserData();
    return Container(
      color: Constants.THEME_CARD_COLOR,
      padding: new EdgeInsets.fromLTRB(10, 0, 10, 0),

      child: Column(
        children: [
          Container(
            padding: new EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                                width: 50,
                                height: 50,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: new NetworkImage(getUsrDpUrl()

                                        )
                                    )
                                )
                            ),

                            Container(
                              width: 10,
                              height: 10,
                              decoration: new BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: TextStyle(
                                color: Constants.THEME_LABEL_COLOR,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                            ),
                            Text(
                            profession,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Constants.THEME_LABEL_COLOR),
                            ),
                            Text(
                              "x Miles",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Constants.THEME_LABEL_COLOR),
                            ),
                          ],
                        )),
                  ],
                ),
                // new Container(
                //   child: Image.network(
                //     snapshot.data[index].postTitle,
                //     height: MediaQuery
                //         .of(context)
                //         .size
                //         .width * 0.3, width: MediaQuery
                //       .of(context)
                //       .size
                //       .width * 0.3,),
                // ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Constants.POST_ITEM_GRADIENT1,
                        Constants.POST_ITEM_GRADIENT2,
                      ])),
              child: Container(
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Text(
                                "Return Service: ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Constants.THEME_DEFAULT_TEXT,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                snapshot.data[itemIndex].offerTitle,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Constants.THEME_DEFAULT_TEXT,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                          child: Text(
                            snapshot.data[itemIndex].offerDescription,
                            textAlign: TextAlign.left,
                            style:
                            TextStyle(color: Constants.THEME_DEFAULT_TEXT),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.money,
                      color: tagColor(snapshot.data[itemIndex].cashComp),
                      size: 20,
                    ),
                    Text(
                      "Cash Compensation",
                      style: TextStyle(
                        color: tagColor(snapshot.data[itemIndex].cashComp),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.card_travel,
                      color: tagColor(snapshot.data[itemIndex].canTravel),
                      size: 20,
                    ),
                    Text(
                      "Can Travel",
                      style: TextStyle(
                        color: tagColor(snapshot.data[itemIndex].canTravel),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                    width: 2.0, color: Constants.THEME_DEFAULT_BORDER),
              ),
            ),
            child: Row(
              children: List.generate(
                getIconList().length,
                    (index) =>
                    Expanded(
                      child: GestureDetector(
                          // onTap: () {
                          //   if (index == 2)
                          //
                          //   // if(isReceived)
                          //   // {
                          //   //   List<String> offersIdList = [];
                          //   //   FirebaseHelper.POST_DB.child(snapshot.data[postIndex].postId).child("offers").once().then((result) {
                          //   //     result.value.forEach((key, childSnapshot) {
                          //   //       print(":::::::::::::::::" + key);
                          //   //       offersIdList.add(key);
                          //   //     });
                          //   //   }).then((value) {
                          //   //     Navigator.push(
                          //   //         context,
                          //   //         MaterialPageRoute(
                          //   //             builder: (BuildContext context) =>
                          //   //                 ViewOfferWidget(snapshot, postIndex, offersIdList)));
                          //   //   });
                          //   // }
                          //
                          //   // if (index == 0 && !isCommentItem) {
                          //   //   Navigator.push(
                          //   //       context,
                          //   //       MaterialPageRoute(
                          //   //           builder: (BuildContext context) =>
                          //   //               PostComments(snapshot, postIndex)));
                          //   // } else if (index == 1 &&
                          //   //     !isMakeOfferItem &&
                          //   //     FirebaseAuth.instance.currentUser.uid
                          //   //             .toString() !=
                          //   //         snapshot.data[postIndex].userId
                          //   //             .toString()) {
                          //   //   Navigator.push(
                          //   //       context,
                          //   //       MaterialPageRoute(
                          //   //           builder: (BuildContext context) =>
                          //   //               PostOffersPage(snapshot, postIndex)));
                          //   // }
                          // },
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  getIconList()[index],
                                  color: getButtonIconColor(index),
                                ),
                                Text(
                                  buttonText(index),
                                  style: TextStyle(
                                      color: Constants.THEME_LABEL_COLOR,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          )),
                    ),
              ),
            ),
          )
        ],
      ),

    );
  }


}