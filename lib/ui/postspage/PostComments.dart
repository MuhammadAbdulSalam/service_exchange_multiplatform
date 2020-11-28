import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/models/PostsModel.dart';
import 'package:service_exchange_multiplatform/ui/postspage/PostItem.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';

class PostComments extends StatefulWidget {
  AsyncSnapshot snapshot;
  int index;

  PostComments(this.snapshot, this.index);

  @override
  _PostComments createState() => _PostComments(snapshot, index);
}

class _PostComments extends State<PostComments> {
  AsyncSnapshot postSnapShot;
  int index;

  _PostComments(this.postSnapShot, this.index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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

      body: _getBody(),
    );
  }

  Widget _getBody() {
    return Stack(children: <Widget>[
      Scaffold(
      body: Container(
        color: Constants.THEME_TEXT_BOX_COLOR,
        child: ListView(
          children: <Widget>[
            PostItem(postSnapShot, index, true),
            Container(

                child: new ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 50,
                    itemBuilder: (BuildContext context, int indexpos) {
                      return Text("Item" + indexpos.toString());
                    })),
          ],
        ),
      ),
        bottomNavigationBar: Container(
          color: Constants.THEME_TEXT_BOX_COLOR,
          height: 3 * 24.0,
        ),
      ),
      Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 0,
        right: 0,
        child: Container(
          height: 3 * 24.0,
          child: TextFormField(
            maxLength: null,
            maxLines: 5,
            style: TextStyle(color: Constants.THEME_DEFAULT_TEXT),
            decoration: InputDecoration(
              filled: true,
              fillColor: Constants.THEME_TEXT_BOX_COLOR,
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
