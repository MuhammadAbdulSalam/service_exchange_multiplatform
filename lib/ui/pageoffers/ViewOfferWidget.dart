import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:service_exchange_multiplatform/models/OffersModel.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseCallHelper.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseHelper.dart';

import 'item/OfferViewItem.dart';


class ViewOfferWidget extends StatefulWidget{

  final AsyncSnapshot postSnapShot;
  final int index;
  final List<String> listOfOfers;
  ViewOfferWidget(this.postSnapShot, this.index, this.listOfOfers);
  @override
  _ViewOfferWidget createState() => _ViewOfferWidget(postSnapShot, index, listOfOfers);

}
class _ViewOfferWidget extends State {

  final AsyncSnapshot postSnapShot;
  final int index;
  final List<String> listOfOfers;
  _ViewOfferWidget(this.postSnapShot, this.index, this.listOfOfers);

  int lengthOfItems = 0;
  List<String> offersIdList = new List<String>();
  List<OffersModel> offerModelsList = new List<OffersModel>();

  final FirebaseCallHelper firebaseCallHelper = FirebaseCallHelper();


  FutureBuilder getListView() {
    FirebaseCallHelper firebaseCallHelper = FirebaseCallHelper();
    return FutureBuilder(
      future: firebaseCallHelper.getOffersList(listOfOfers),
      // async work
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
            else {
              if (snapshot.data.length == 0) {
                print("-------RETURNED-->");

                return Container(
                  color: Constants.THEME_DEFAULT_BACKGROUND,
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconTheme(
                          data: new IconThemeData(
                              color: Constants.THEME_DEFAULT_TEXT),
                          child: new Icon(
                            Icons.info,
                            size: 20,
                          ),
                        ),
                        Text(
                          "  Currently No offers Available",
                          style: TextStyle(
                            color: Colors.blueAccent,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: OfferViewItem(snapshot, index),
                    );
                  },
                );
              }
            }
        }
      },
    );
  }




  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
      title: Text("Offer"),
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

     body: Container(

       child: Container(
         child: getListView(),
      ),
     ),
    );
  }
}
