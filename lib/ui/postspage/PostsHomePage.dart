import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/models/PostsModel.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseHelper.dart';

final icons = [
  Icons.person,
  Icons.near_me,
  Icons.refresh,
  Icons.filter_alt_rounded,
];

class PostsHomePage extends StatefulWidget {
  @override
  _PostsHomePage createState() => _PostsHomePage();
}

class _PostsHomePage extends State<PostsHomePage> {
  var makecall = new MakeCall();
  var isRe = false; //-------> to refresh and add conditions

  @override
  Widget build(BuildContext context) {
    // var futureBuilder =

    return Container(
        color: Constants.THEME_DEFAULT_BACKGROUND,
        child: SafeArea(
            child: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 2.0, color: Constants.THEME_DEFAULT_BORDER),
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: List.generate(
                icons.length,
                (index) => Expanded(
                  child: GestureDetector(
                      onTap: () => {
                            setState(() {
                              if (isRe) {
                                isRe = false;
                              } else {
                                isRe = true;
                              }
                            })
                          },
                      child: Container(
                        height: 30,
                        child: Icon(
                          icons[index],
                          color: Colors.blue,
                        ),
                      )),
                ),
              ),
            ),
          ),
          Expanded(
              child: new Column(
            children: [
              new Container(
                  height: MediaQuery.of(context).size.height - 130,
                  child: PostsItemList(isRe))
            ],
          )),
        ])));
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }
}


/// <------------Get list from firebase---------->
class MakeCall {
  Future<List<PostsModel>> getPostsList(bool isRefresh) async {
    List<PostsModel> postList = [];

    if (isRefresh) {
      await FirebaseHelper.POST_DB.once().then((result) async {
        if (result.value != null) {
          result.value.forEach((key, childSnapshot) {
            postList.add(PostsModel.fromJson(Map.from(childSnapshot)));
          });
        } else {
          print('getUserJobs() no jobs found');
        }
      }).catchError((e) {
        print('getUserJobs() error: $e');
      });
    }

//  if (query == null) {
//    return userJobs;
//  }

//  query.onValue.listen((event) {
//    Map<dynamic, dynamic> values = event.snapshot.value;
//    values.forEach((key, value) {
//      userJobs.add(Job.fromJson(key, Map.from(value)));
//    });
//  });
    return postList;
  }
}


/// <------------Convert List to items---------->
class PostsItemList extends StatelessWidget {
  bool isREss = false;

  PostsItemList(this.isREss);

  MakeCall mk = MakeCall();

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: mk.getPostsList(isREss), // async work
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('Press button to start');
          case ConnectionState.waiting:
            return new Text('Loading....');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                              elevation: 0,
                              child: Row(
                                children: <Widget>[
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 5, top: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      // condition('${snapshot
                                                      //     .data[index]
                                                      //     .vegOrNon}') == true
                                                      //     ? new Image.asset(
                                                      //   'images/non_veg.png',
                                                      //   height: 15, width: 15,)
                                                      //     : new Image.asset(
                                                      //     'images/veg.jpg',
                                                      //     height: 15,
                                                      //     width: 15),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        snapshot.data[index]
                                                            .requiredService,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 20,
                                                            fontFamily:
                                                                'Roboto-Black'),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Row(
                                                    children: <Widget>[
                                                      new IconTheme(
                                                        data: new IconThemeData(
                                                            color:
                                                                Colors.black26),
                                                        child: new Icon(
                                                          Icons.timer,
                                                          size: 20.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${snapshot.data[index].requiredService} minutes',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                Colors.black26),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ))),
                    ),
                  );
                },
              );
        }
      },
    );
  }
}
