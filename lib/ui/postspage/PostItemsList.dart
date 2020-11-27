

import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';

import 'FirebasePostCall.dart';

class PostsItemsList extends StatelessWidget {

  listType listTypeNeeded;
  PostsItemsList(this.listTypeNeeded);
  FirebasePostCall firebasePostCall = FirebasePostCall();

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
                    padding: new EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Card(
                      color: Constants.THEME_CARD_COLOR,
                      shadowColor: Constants.THEME_SHADOW_COLOR,
                      child: Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  padding: new EdgeInsets.fromLTRB(10, 15, 0, 0),

                                  child:   Row(
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
                                                snapshot.data[index].userName,
                                                style: TextStyle(
                                                  color:
                                                  Constants.THEME_LABEL_COLOR,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                snapshot
                                                    .data[index].returnService,
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
                                                  snapshot.data[index]
                                                      .returnDescription,
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
                                          color:
                                          Constants.THEME_DEFAULT_BORDER),
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
