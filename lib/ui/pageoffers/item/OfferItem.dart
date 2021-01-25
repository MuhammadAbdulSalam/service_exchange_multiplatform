import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/ui/pageoffers/ViewOfferWidget.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseHelper.dart';

class OfferItem extends StatefulWidget {
  int postIndex;
  bool isSent;
  bool isReceived;
  var statusTextController = TextEditingController();
  AsyncSnapshot snapshot;

  OfferItem(this.snapshot, this.postIndex, this.isReceived,
      this.isSent);

  @override
  _OfferItem createState() =>
      _OfferItem(snapshot, postIndex, isReceived, isSent);
}

class _OfferItem extends State<OfferItem> {
  AsyncSnapshot snapshot;
  int postIndex;
  bool isSent;
  bool isReceived;
  var statusTextController = TextEditingController();

  _OfferItem(this.snapshot, this.postIndex,
      this.isReceived, this.isSent);

  List<IconData> getIconList() {
    if (FirebaseAuth.instance.currentUser.uid.toString() ==
        snapshot.data[postIndex].userId.toString()) {
      return [
        Icons.comment_outlined,
        Icons.close,
        Icons.remove_red_eye_outlined
      ];
    } else {
      return [
        Icons.comment_outlined,
        Icons.close,
        Icons.remove_red_eye_outlined,
      ];
    }
  }

  String buttonText(int index) {


    switch (index) {
      case 0:
        return " Comment";
        break;
      case 1:
        return " Delete";
        break;
      case 2:
        return isSent ? " View Offer" : " ViewOffers";
        break;

    }
  }

  String getUsrDpUrl(String text) {
    if (text == "default") {
      return "https://www.woolha.com/media/2019/06/buneary.jpg";
    } else {
      return text;
    }
  }

  Color getButtonIconColor(int index) {
    if (index == 1 &&
        FirebaseAuth.instance.currentUser.uid.toString() ==
            snapshot.data[postIndex].userId.toString()) {
      if (Constants.IS_THEME_DARK) {
        return Colors.white;
      }
      return Colors.black26;
    } else {
      return Colors.blue[200];
    }
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

  String getNumberOfPosts() {
    if (snapshot.data[postIndex].numberOfOffers < 10) {
      return "0" + snapshot.data[postIndex].numberOfOffers.toString();
    } else {
      return snapshot.data[postIndex].numberOfOffers.toString();
    }
  }

  Future<String> getStatusText() async {
    await FirebaseHelper.OFFER_DB
        .child(snapshot.data[postIndex].offerKey)
        .child("status")
        .once()
        .then((value) {
      setState(() {
        statusTextController.text = value.value.toString();
      });

      return value.value.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    if (isSent) {
      getStatusText();
    }
  }

  Color getStatusColor(String text) {
    switch (text) {
      case "Pending":
        return Colors.orange[300];
        break;
      case "Counter":
        return Colors.purpleAccent;
        break;
      case "Accepted":
        return Colors.green;
        break;
      case "Rejected":
        return Colors.redAccent;
        break;
      default:
        return Colors.orange[400];
    }
  }

  Column getNumberOfRequestsColumn() {
    return Column(
      children: [
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
         color: Colors.orange[400],
         child:  Container(
            width: 50,
            height: 50,
            decoration:
            new BoxDecoration(shape: BoxShape.circle),
            child: Center(
              child: Text(
                getNumberOfPosts(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Text(
            "Active Offers",
            style: TextStyle(
                color: Constants.OFFER_STATUS_TEXT,
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
        ),
      ],
    );
  }

  Column getStatusOfRequest() {
    return Column(
      children: [
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
    color: getStatusColor(statusTextController.text),
         child: Container(
            width: 100,
            height: 34,
            decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                ),
            child: Center(
              child: Text(
                statusTextController.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        // Container(
        //   padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        //   child: Text(
        //     "status",
        //     style: TextStyle(
        //         color: Constants.OFFER_STATUS_TEXT,
        //         fontWeight: FontWeight.bold,
        //         fontSize: 14),
        //   ),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.THEME_CARD_COLOR,
      // shadowColor: Constants.THEME_SHADOW_COLOR,
      child: Container(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: new EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                                            image: new NetworkImage(getUsrDpUrl(
                                                snapshot.data[postIndex]
                                                    .userDpUrl))))),
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
                                  snapshot.data[postIndex].userName,
                                  style: TextStyle(
                                    color: Constants.THEME_LABEL_COLOR,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  snapshot.data[postIndex].returnService,
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

                    isSent ? getStatusOfRequest() : getNumberOfRequestsColumn(),

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
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Text(
                                "Required: ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Constants.THEME_DEFAULT_TEXT,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                snapshot.data[postIndex].requiredService,
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
                            snapshot.data[postIndex].requiredDescription,
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
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                        Constants.POST_ITEM_GRADIENT2,
                        Constants.POST_ITEM_GRADIENT1,
                      ])),
                  child: Container(
                      child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Text(
                                 "Return: ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Constants.THEME_DEFAULT_TEXT,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                              child: Text(
                                snapshot.data[postIndex].returnService,
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
                            snapshot.data[postIndex].returnDescription,
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
                          color: tagColor(snapshot.data[postIndex].cashComp),
                          size: 20,
                        ),
                        Text(
                          "Cash Compensation",
                          style: TextStyle(
                            color: tagColor(snapshot.data[postIndex].cashComp),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.emoji_transportation,
                          color: tagColor(snapshot.data[postIndex].invTravel),
                          size: 20,
                        ),
                        Text(
                          "Involves Travel",
                          style: TextStyle(
                            color: tagColor(snapshot.data[postIndex].invTravel),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.card_travel,
                          color: tagColor(snapshot.data[postIndex].canTravel),
                          size: 20,
                        ),
                        Text(
                          "Can Travel",
                          style: TextStyle(
                            color: tagColor(snapshot.data[postIndex].canTravel),
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
                    (index) => Expanded(
                      child: GestureDetector(
                          onTap: () {
                            if(index == 2)

                            if(isReceived)
                            {
                              List<String> offersIdList = [];
                              FirebaseHelper.POST_DB.child(snapshot.data[postIndex].postId).child("offers").once().then((result) {
                                result.value.forEach((key, childSnapshot) {
                                  offersIdList.add(key);
                                });
                              }).then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ViewOfferWidget(snapshot, postIndex, offersIdList)));
                              });
                            }
                          },
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
        ),
      ),
    );
  }
}
