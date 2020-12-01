import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/ui/postspage/PostComments.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';

class PostItem extends StatelessWidget {
  AsyncSnapshot snapshot;
  int postIndex;
  bool isCommentItem;

  PostItem(this.snapshot, this.postIndex, this.isCommentItem);

  List<IconData>  getIconList(){
    if(isCommentItem){
      return [Icons.post_add];
  }
    else{
     return [
        Icons.comment_outlined,
        Icons.post_add,
      ];
    }
  }



  String buttonText(int index) {
    if(isCommentItem){
      return "Make Offer";
    }
    else{
      switch (index) {
        case 0:
          return " Comment";
          break;
        case 1:
          return " Offer";
          break;
      }
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
                  padding: new EdgeInsets.fromLTRB(10, 15, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 50,
                              height: 50,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new NetworkImage(
                                          "https://www.woolha.com/media/2019/06/buneary.jpg")))),
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
                          ))

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
                    color: Colors.green,
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
                                  TextStyle(color: Constants.THEME_DARK_TEXT),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: Container(
                    color: Colors.orange,
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
                                  TextStyle(color: Constants.THEME_DARK_TEXT),
                            ),
                          ),
                        ],
                      ),
                    )),
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
                            onTap: () => {
                                  if (index == 0 && !isCommentItem)
                                    {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  PostComments(
                                                      snapshot, postIndex))),
                                    }
                                },
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    getIconList()[index],
                                    color: Colors.blue,
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


