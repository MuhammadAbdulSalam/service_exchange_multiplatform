import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/ui/postspage/PostComments.dart';
import 'package:service_exchange_multiplatform/ui/postspage/PostOfferPage.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';

class PostItem extends StatelessWidget {
  AsyncSnapshot snapshot;
  int postIndex;
  bool isCommentItem;
  bool isMakeOfferItem;

  PostItem(
      this.snapshot, this.postIndex, this.isCommentItem, this.isMakeOfferItem);

  List<IconData> getIconList() {
    if (isCommentItem) {
      if(FirebaseAuth.instance.currentUser.uid.toString() == snapshot.data[postIndex].userId.toString())
      {
        return [Icons.close];
      }
      else{
        return [Icons.post_add];
      }

    } else if (isMakeOfferItem) {

        return [Icons.post_add];
    }
    else if(FirebaseAuth.instance.currentUser.uid.toString() == snapshot.data[postIndex].userId.toString())
    {
      return [
        Icons.comment_outlined,
        Icons.close,
      ];
    }


    else {
      return [
        Icons.comment_outlined,
        Icons.post_add,
      ];
    }
  }

  String buttonText(int index) {
    if (isCommentItem) {
      return "Make Offer";
    } else {
      switch (index) {
        case 0:
          return " Comment";
          break;
        case 1:
          if(FirebaseAuth.instance.currentUser.uid.toString() == snapshot.data[postIndex].userId.toString())
            {
              return " Delete";
            }
          else{
            return " Offer";
          }
          break;
      }
    }
  }

  String getUsrDpUrl(String text) {
    if (text == "default") {
      return "https://www.woolha.com/media/2019/06/buneary.jpg";
    } else {
      return text;
    }
  }

  Color getButtonIconColor(int index){
    if(index == 1 && FirebaseAuth.instance.currentUser.uid.toString() == snapshot.data[postIndex].userId.toString())
      {
        if(Constants.IS_THEME_DARK){
          return Colors.white;

        }
        return Colors.black26;
      }
    else{
      return Colors.blue;
    }

  }

  Color tagColor(String value) {
    if (value == "yes") {
      return Colors.lightGreen;
    } else {
      return Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.THEME_CARD_COLOR,
      // shadowColor: Constants.THEME_SHADOW_COLOR,
      child: Flexible(
        fit: FlexFit.tight,
        child: Container(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: new EdgeInsets.fromLTRB(10, 15, 10, 0),
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
                                                  snapshot
                                                      .data[postIndex].userDpUrl))))),
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

                      Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.yellow,

                              ),
                              Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.yellow,

                              ),
                              Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.yellow,

                              )
                            ],
                          )),

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
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Colors.orangeAccent,
                              Constants.DEFAULT_BLUE,
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
                                      color: Constants.THEME_DEFAULT_BLACK,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  snapshot.data[postIndex].requiredService,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Constants.THEME_DARK_TEXT,
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
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Constants.DEFAULT_BLUE,
                              Colors.orangeAccent,

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
                                      color: Constants.THEME_DEFAULT_BLACK,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Text(
                                  snapshot.data[postIndex].returnService,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Constants.THEME_DARK_TEXT,
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
                              color:
                                  tagColor(snapshot.data[postIndex].cashComp),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.car_rental,
                            color: tagColor(snapshot.data[postIndex].invTravel),
                            size: 20,
                          ),
                          Text(
                            "Involves Travel",
                            style: TextStyle(
                              color:
                                  tagColor(snapshot.data[postIndex].invTravel),
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
                              color:
                                  tagColor(snapshot.data[postIndex].canTravel),
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
                              if (index == 0 && !isCommentItem) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            PostComments(snapshot, postIndex)));
                              } else if (index == 1 && !isMakeOfferItem && FirebaseAuth.instance.currentUser.uid.toString() != snapshot.data[postIndex].userId.toString()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            PostOffersPage(
                                                snapshot, postIndex)));
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
      ),
    );
  }
}
