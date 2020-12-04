import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/ui/profilepage/pages/ProfileInfoPage.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/uicomponents/ProfileInfoWidget.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidget createState() => new _ProfileWidget();
}

class _ProfileWidget extends State<ProfileWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int tabIndex = 0;
  int infoIndex= 0;
  int editIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  String getText(int currentIndex){
    if(currentIndex == infoIndex){
      return "Edit";
    }
    else{
      return "Save";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
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
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          ProfileInfoPage(),
          ProfileInfoWidget(false),
        ],
      ),
      // floatingActionButton: FlatButton(
      //     child: Container(
      //       width: 70,
      //       height: 35,
      //       child: Card(
      //         color: Colors.blueAccent,
      //         elevation: 10,
      //         child: Container(
      //           padding: EdgeInsets.fromLTRB(17, 5, 7, 7),
      //           child: Visibility(
      //             child: Text(getText(tabIndex),
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.normal),),
      //             maintainSize: true,
      //             maintainAnimation: true,
      //             maintainState: true,
      //             visible: true,
      //           ),
      //         ),
      //       ),
      //     ),
      //
      //     onPressed: () {
      //       setState(() {
      //         if(tabIndex == infoIndex){
      //           tabIndex = editIndex;
      //         }
      //         else {
      //           tabIndex = infoIndex;
      //         }
      //         _tabController.animateTo(tabIndex);
      //       });
      //     }),
    );
  }
}
