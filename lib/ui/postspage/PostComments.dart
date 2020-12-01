import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/models/PostsModel.dart';
import 'package:service_exchange_multiplatform/ui/postspage/PostItem.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseCallHelper.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseHelper.dart';
import 'package:uuid/uuid.dart';

class PostComments extends StatefulWidget {
  AsyncSnapshot snapshot;
  int index;

  PostComments(this.snapshot, this.index);

  @override
  _PostComments createState() => _PostComments(snapshot, index);
}

class _PostComments extends State<PostComments> {
  final AsyncSnapshot postSnapShot;
  final int index;
  final FirebaseCallHelper firebaseCallHelper = FirebaseCallHelper();
  final commentController = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  _PostComments(this.postSnapShot, this.index);

  Future<void> postComment(String postId) async {
    String key = FirebaseHelper.getCommentsDB(postId).push().key;


    final Map<String, dynamic> commentHashMap = {
      'userId': FirebaseAuth.instance.currentUser.uid.toString(),
      'userDpUrl': Constants.userList[0].dpUrl.toString(),
      'name': Constants.userList[0].name.toString(),
      'comment': commentController.text,
      'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch.toString()

  };
    await FirebaseHelper.getCommentsDB(postId)
        .child(key)
        .set(commentHashMap)
        .then((value) {
      commentController.text = "";

      FocusScope.of(context).requestFocus(FocusNode());

      setState(() {
        _scrollController.animateTo(
          // NEW
          _scrollController.position.maxScrollExtent, // NEW
          duration: const Duration(milliseconds: 500), // NEW
          curve: Curves.ease, // NEW
        );
      });
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
              PostItem(postSnapShot, index, true),
              Container(
                child: FutureBuilder(
                  future: firebaseCallHelper
                      .getCommentsList(postSnapShot.data[index].postId),
                  // async work
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return new Text('Press button to start');
                      case ConnectionState.waiting:
                        return new Container(
                          color: Constants.THEME_DEFAULT_BACKGROUND,
                          child: Align(
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
                        else
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: new EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: new DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: new NetworkImage(
                                                            "https://www.woolha.com/media/2019/06/buneary.jpg")))),
                                          ],
                                        ),

                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data[index].name,
                                                  style: TextStyle(
                                                    color: Constants
                                                        .THEME_LABEL_COLOR,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 2,
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                  snapshot.data[index].comment,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Constants
                                                          .THEME_LABEL_COLOR),
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
                                  ));
                            },
                          );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Constants.THEME_TEXT_BOX_COLOR,
          height: 3 * 24.0,
        ),
        floatingActionButton: Container(
          child: Text("asdasd"),
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
                  postComment(postSnapShot.data[index].postId),
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
