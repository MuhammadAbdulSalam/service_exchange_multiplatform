

import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';

import '../../../utils/FirebaseCallHelper.dart';
import 'PostItem.dart';



class PostsItemsList extends StatelessWidget {

  listType listTypeNeeded;
  PostsItemsList(this.listTypeNeeded);
  FirebaseCallHelper firebasePostCall = FirebaseCallHelper();


  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: firebasePostCall.getPostsList(listTypeNeeded), // async work
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
            else
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: PostItem(snapshot, index, false, false)
                  );
                },
              );
        }
      },
    );
  }
}
