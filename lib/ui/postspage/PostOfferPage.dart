import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_exchange_multiplatform/ui/postspage/items/PostItem.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseHelper.dart';

class PostOffersPage extends StatefulWidget {
  AsyncSnapshot postSnapShot;
  int index;

  PostOffersPage(this.postSnapShot, this.index);

  @override
  _PostOffersPage createState() => _PostOffersPage(postSnapShot, index);
}

class _PostOffersPage extends State<PostOffersPage> {
  AsyncSnapshot postSnapShot;
  int index;
  int selectedIconIndex = 1;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isOfferMade = false;

  final offeredService = TextEditingController();
  final offeredDescription = TextEditingController();
  bool cashComp = false;
  bool canTravel = false;
  final minVal = TextEditingController();
  final maxVal = TextEditingController();
  Timer _timerDialog;

  _PostOffersPage(this.postSnapShot, this.index);

  final icons = [
    Icons.clear,
    Icons.auto_fix_high,
  ];

  String iconText(int index) {
    switch (index) {
      case 0:
        return "clear";
        break;
      case 1:
        return "template";
        break;
    }
  }

  void showTimedDialog(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          _timerDialog = Timer(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });

          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(title),
            content: SingleChildScrollView(
              child: Text(message),
            ),
          );
        }).then((val) {
      if (_timerDialog.isActive) {
        _timerDialog.cancel();
      }
    });
  }

  getButtonColor() {
    if (isOfferMade) {
      return Colors.grey;
    } else {
      return Colors.blueAccent;
    }
  }

  Color getColor(int selectedIndex, int index) {
    if (selectedIconIndex == index) {
      return Colors.pinkAccent;
    } else {
      return Colors.blueAccent;
    }
  }

  String validateForm(String value) {
    if (value.isEmpty && !isOfferMade) {
      return "*Cannot be left blank";
    }

    return null;
  }

  Future<void> updateOffer() async {
    setState(() {
      isLoading = true;
    });
    String offerKey = FirebaseHelper.OFFER_DB.push().key.toString();

    final Map<String, String> offerHashMap = {
      'offerTitle': offeredService.text,
      'offerDescription': offeredDescription.text,
      'offeredId': FirebaseAuth.instance.currentUser.uid.toString(),
      'postId': postSnapShot.data[index].postId.toString(),
      'opId': postSnapShot.data[index].userId.toString(),
      'canTravel': canTravel ? "yes" : "no",
      'cashComp': cashComp ? "yes" : "no",
      'status': 'pending',
    };

    await FirebaseHelper.OFFER_DB
        .child(offerKey)
        .set(offerHashMap)
        .then((value) {
      FirebaseHelper.POST_DB
          .child(postSnapShot.data[index].postId.toString())
          .child("offers")
          .child(offerKey)
          .set(offerKey)
          .then((value) {
        FirebaseHelper.USER_DB
            .child(FirebaseAuth.instance.currentUser.uid.toString())
            .child("sentOffers")
            .child(offerKey)
            .set(offerKey)
            .then((value) {
          setState(() {
            isLoading = false;
            isOfferMade = true;
            offeredService.clear();
            offeredDescription.clear();
            cashComp = false;
            canTravel = false;
            minVal.clear();
            maxVal.clear();

            showTimedDialog("Success", "Offer Made Successfully.");
          });
        });
      });
    });
  }

  Container defaultDisplay(bool isLoading) {
    if (isLoading) {
      return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          child: CircularProgressIndicator(),
        ),
      );
    } else
      return Container(
        color: Constants.THEME_DEFAULT_BACKGROUND,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              PostItem(postSnapShot, index, false, true),
              Container(
                decoration: BoxDecoration(
                  color: Constants.THEME_OFFER_TOOLBAR_COLOR,
                  border: Border(
                    bottom: BorderSide(
                        width: 1.0, color: Constants.THEME_DEFAULT_BORDER),
                    top: BorderSide(
                        width: 1.0, color: Constants.THEME_DEFAULT_BORDER),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: Row(
                  children: List.generate(
                    icons.length,
                    (index) => Expanded(
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIconIndex = index;
                            });
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Icon(
                                  icons[index],
                                  color: getColor(selectedIconIndex, index),
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
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  "Please enter following details about service you would return:",
                  style: TextStyle(
                      color: Constants.THEME_LABEL_COLOR,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: offeredService,
                  validator: (value) {
                    return validateForm(value);
                  },
                  style: TextStyle(color: Constants.THEME_DEFAULT_TEXT),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Constants.THEME_TEXT_BOX_COLOR,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Constants.THEME_DEFAULT_BORDER, width: 1.0),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Offer Service',
                    labelStyle:
                        TextStyle(color: Constants.THEME_TEXT_HINT_COLOR),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                height: 5 * 24.0,
                child: TextFormField(
                  maxLength: null,
                  maxLines: 5,
                  controller: offeredDescription,
                  validator: (value) {
                    return validateForm(value);
                  },
                  style: TextStyle(color: Constants.THEME_DEFAULT_TEXT),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Constants.THEME_TEXT_BOX_COLOR,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Constants.THEME_DEFAULT_BORDER, width: 1.0),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                    labelStyle:
                        TextStyle(color: Constants.THEME_TEXT_HINT_COLOR),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Cash Compensation",
                        style: TextStyle(
                          color: Constants.THEME_LABEL_COLOR,
                        ),
                      ),
                      Switch(
                        value: cashComp,
                        onChanged: (value) {
                          setState(() {
                            cashComp = value;
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ]),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        "Can Travel",
                        style: TextStyle(
                          color: Constants.THEME_LABEL_COLOR,
                        ),
                      ),
                      Switch(
                        value: canTravel,
                        onChanged: (value) {
                          setState(() {
                            canTravel = value;
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ]),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                      child: Text(
                        "Estimated Value of Service",
                        style: TextStyle(
                            color: Constants.THEME_LABEL_COLOR,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 130,
                                padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: minVal,
                                  validator: (value) {
                                    return validateForm(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: TextStyle(
                                      color: Constants.THEME_DEFAULT_TEXT),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Constants.THEME_TEXT_BOX_COLOR,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.THEME_DEFAULT_BORDER,
                                          width: 1.0),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'min',
                                    labelStyle: TextStyle(
                                        color: Constants.THEME_TEXT_HINT_COLOR),
                                  ),
                                ),
                              ),
                              Text(
                                "to",
                                style: TextStyle(
                                    color: Constants.THEME_LABEL_COLOR,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 130,
                                padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: maxVal,
                                  validator: (value) {
                                    return validateForm(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: TextStyle(
                                      color: Constants.THEME_DEFAULT_TEXT),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Constants.THEME_TEXT_BOX_COLOR,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.THEME_DEFAULT_BORDER,
                                          width: 1.0),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'max',
                                    labelStyle: TextStyle(
                                        color: Constants.THEME_TEXT_HINT_COLOR),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width - 10,
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: getButtonColor(),
                          child: Text('Make Offer'),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());

                            if (_formKey.currentState.validate()) {
                              if (isOfferMade) {
                                showTimedDialog("Cannot Make Offer",
                                    "An offer is already made");
                              } else
                                updateOffer();
                            }
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Offer"),
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
        body: defaultDisplay(isLoading));
  }
}
