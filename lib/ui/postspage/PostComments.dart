import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/models/PostsModel.dart';
import 'package:service_exchange_multiplatform/ui/postspage/items/PostItem.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseCallHelper.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseHelper.dart';
import 'package:service_exchange_multiplatform/utils/uicomponents/Dialoge.dart';
import 'package:uuid/uuid.dart';

import 'items/CommentItem.dart';

// class PostComments extends StatefulWidget {
//   AsyncSnapshot snapshot;
//   int index;
//
//   PostComments(this.snapshot, this.index);
//
//   @override
//   _PostComments createState() => _PostComments(snapshot, index);
// }

class PostComments extends StatelessWidget {
  final AsyncSnapshot postSnapShot;
  final int index;
  final FirebaseCallHelper firebaseCallHelper = FirebaseCallHelper();
  final commentController = TextEditingController();
  final ScrollController _scrollController = new ScrollController();
  final GlobalKey<State> aKey = new GlobalKey<State>();


  PostComments(this.postSnapShot, this.index);

  Future<void> postComment(String postId, BuildContext context) async {
    String key = FirebaseHelper.getCommentsDB(postId).push().key;

    final Map<String, dynamic> commentHashMap = {
      'userId': FirebaseAuth.instance.currentUser.uid.toString(),
      'userDpUrl': Constants.userList[0].dpUrl.toString(),
      'name': Constants.userList[0].name.toString(),
      'comment': commentController.text
    };
    await FirebaseHelper.getCommentsDB(postId)
        .child(key)
        .set(commentHashMap)
        .then((value) {
      commentController.text = "";

      FocusScope.of(context).requestFocus(FocusNode());

      _scrollController.animateTo(
        // NEW
        _scrollController.position.maxScrollExtent, // NEW
        duration: const Duration(milliseconds: 500), // NEW
        curve: Curves.ease, // NEW
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Comments"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Constants.DEFAULT_ORANGE,
                Constants.DEFAULT_BLUE,
              ])),
        ),
      ),
      body: _getBody(context),
    );
  }

  Widget _getBody(BuildContext mContext) {
    return Stack(children: <Widget>[
      Scaffold(
        body: Container(
          color: Constants.THEME_TEXT_BOX_COLOR,
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              PostItem(postSnapShot, index, true, false),
              Container(
                child: new FirebaseAnimatedList(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    query: firebaseCallHelper
                        .getCommentsQuery(postSnapShot.data[index].postId),
                    padding: new EdgeInsets.all(8.0),
                    reverse: false,
                    itemBuilder: (_, DataSnapshot snapshot,
                        Animation<double> animation, int x) {
                      return CommentItem(mContext, animation, index, snapshot);
                    }

                    ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Constants.THEME_TEXT_BOX_COLOR,
          height: 3 * 24.0,
        ),
      ),
      Positioned(
        bottom: MediaQuery.of(mContext).viewInsets.bottom,
        left: 0,
        right: 0,
        child: Container(
          height: 3 * 24.0,
          child: TextFormField(
            controller: commentController,
            maxLength: null,
            maxLines: 5,
            style: TextStyle(color: Constants.THEME_DEFAULT_TEXT),
            decoration: InputDecoration(
              filled: true,
              fillColor: Constants.THEME_TEXT_BOX_COLOR,
              suffixIcon: IconButton(
                onPressed: () => {
                  postComment(postSnapShot.data[index].postId, mContext),
                },
                icon: Icon(Icons.send),
              ),
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(0.0),
                ),
              ),
              labelText: 'Add Comment Here',
              labelStyle: TextStyle(color: Constants.THEME_TEXT_HINT_COLOR),
            ),
          ),
        ),
      ),
    ]);
  }



}
