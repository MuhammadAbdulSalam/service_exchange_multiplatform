import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';

class CommentItem extends StatelessWidget {
  final DataSnapshot snapshot;
  final Animation animation;
  final int index;
  final BuildContext context;

  CommentItem(this.context, this.animation, this.index, this.snapshot);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: Padding(
          padding: new EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 40,
                        height: 40,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: new NetworkImage(snapshot
                                            .value["userDpUrl"] ==
                                        "default"
                                    ? "https://www.woolha.com/media/2019/06/buneary.jpg"
                                    : snapshot.value["userDpUrl"].toString())))),
                  ],
                ),

                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Constants.THEME_COMMENT_BACKGROUND,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.value["name"],
                            style: TextStyle(
                              color: Constants.THEME_LABEL_COLOR,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text(
                              snapshot.value["comment"],
                              textAlign: TextAlign.left,
                              maxLines: 5,
                              style:
                                  TextStyle(color: Constants.THEME_LABEL_COLOR),
                            ),
                          )
                        ],
                      )),
                )

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
          )),
    );
  }
}
