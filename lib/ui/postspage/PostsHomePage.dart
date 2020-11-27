import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/models/PostsModel.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseHelper.dart';

final icons = [
  Icons.near_me,
  Icons.person,
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

  String iconText(int index) {
    switch (index) {
      case 0:
        return "Near Me";
        break;
      case 1:
        return "My Posts";
        break;
      case 2:
        return "Refresh";
        break;
      case 3:
        return "Filter";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // var futureBuilder =

    return Container(
        color: Constants.THEME_DEFAULT_BLACK,
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
                        child: Column(
                          children: [
                            Icon(
                              icons[index],
                              color: Colors.blue,
                            ),
                            Text(
                              iconText(index),
                              style: TextStyle(
                                  color: Constants.THEME_DEFAULT_WHITE,
                                  fontSize: 10),
                            ),
                          ],
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
                  color: Constants.THEME_RECYCLER_BACKGROUND,
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

  final buttonIcons = [
    Icons.comment_outlined,
    Icons.post_add,
  ];

  String buttonText(int index) {
    switch (index) {
      case 0:
        return " Comment";
        break;
      case 1:
        return " Offer";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: mk.getPostsList(isREss), // async work
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
                    padding: new EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Card(
                      color: Constants.THEME_CARD_COLOR,
                      shadowColor: Constants.THEME_SHADOW_COLOR,
                      child: Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot
                                                  .data[index].userName,
                                              style: TextStyle(
                                                color: Constants
                                                    .THEME_LABEL_COLOR,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              snapshot.data[index]
                                                  .returnService,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Constants
                                                      .THEME_LABEL_COLOR),
                                            ),
                                            Text(
                                              "x Miles",
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
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Card(
                                    elevation: 10,
                                    color: Colors.green,
                                    child: Container(
                                        child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 10, 0, 0),
                                                child: Text(
                                                  "Required: ",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Constants
                                                          .THEME_DEFAULT_BLACK,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 10, 0, 0),
                                                child: Text(
                                                  snapshot.data[index]
                                                      .requiredService,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Constants
                                                          .THEME_DARK_TEXT,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 5, 10, 10),
                                            child: Text(
                                              snapshot.data[index]
                                                  .requiredDescription,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Constants
                                                      .THEME_DARK_TEXT),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                                  child: Card(
                                    elevation: 10,
                                    color: Colors.orange,
                                    child: Container(
                                        child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 10, 0, 0),
                                                child: Text(
                                                  "Return: ",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Constants
                                                          .THEME_DEFAULT_BLACK,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 10, 10, 0),
                                                child: Text(
                                                  snapshot.data[index]
                                                      .returnService,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Constants
                                                          .THEME_DARK_TEXT,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 5, 10, 10),
                                            child: Text(
                                              snapshot
                                                  .data[index].returnDescription,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Constants
                                                      .THEME_DARK_TEXT),
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
                                          width: 2.0,
                                          color: Constants.THEME_DEFAULT_BORDER),
                                    ),
                                  ),
                                  child: Row(
                                    children: List.generate(
                                      buttonIcons.length,
                                      (index) => Expanded(
                                        child: GestureDetector(
                                            onTap: () => {},
                                            child: Container(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    buttonIcons[index],
                                                    color: Colors.blue,
                                                  ),
                                                  Text(
                                                    buttonText(index),
                                                    style: TextStyle(
                                                        color: Constants
                                                            .THEME_LABEL_COLOR,
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
                    ),
                  );
                },
              );
        }
      },
    );
  }
}
