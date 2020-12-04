import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/uicomponents/ProfileInfoWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileInfoPage extends StatefulWidget {
  @override
  _ProfileInfoPage createState() => new _ProfileInfoPage();
}

class _ProfileInfoPage extends State<ProfileInfoPage> {
  String templateService = "";
  String templateDescription = "";
  double opacity = 1.0;

  _ProfileInfoPage() {
    getDescription().then((value) => setState(() {
          templateDescription = value;
        }));

    getService().then((val) => setState(() {
          templateService = val;
        }));
  }

  Future<String> getService() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getString(Constants.TEMPLATE_SERVICE) ?? "";
  }

  Future<String> getDescription() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.TEMPLATE_DESCRIPTION) ?? "";
  }

  @override
  void initState() {
    super.initState();
    changeOpacity();
  }

  changeOpacity() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        opacity = opacity == 1.0 ? 1.0 : 1.0;
      });
    });
  }

  Row getTopImageBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle, color: Colors.orange),
              child: Center(
                child: Text(
                  "00",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Text(
                "Active Posts",
                style: TextStyle(
                    color: Constants.THEME_LABEL_COLOR,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
            ),
          ],
        ),
        Container(
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new NetworkImage(
                            "https://www.woolha.com/media/2019/06/buneary.jpg"))),
              ),
              Container(
                width: 10,
                height: 10,
                decoration: new BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle, color: Colors.purpleAccent),
              child: Center(
                child: Text(
                  "00",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Text(
                "Active Offers",
                style: TextStyle(
                    color: Constants.THEME_LABEL_COLOR,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container textContainer(String label, String value) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 6, 0, 0),

            child: Text(
              label,
              style: TextStyle(
                  color: Constants.THEME_PROFILE_INFO_LABEL,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
            child: Text(
              value,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  Container getInfoContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Constants.THEME_PROFILE_CONTAINERS_GRADIENT1,
              Constants.THEME_PROFILE_CONTAINERS_GRADIENT2,
            ])),
        // elevation: 10,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(15.0),
        // ),
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textContainer("Name", Constants.userList[0].name),
              textContainer("Job Title", Constants.userList[0].jobTitle),
              textContainer(
                  "Email", FirebaseAuth.instance.currentUser.email.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Container getTemplateContainer() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Constants.THEME_PROFILE_CONTAINERS_GRADIENT1,
              Constants.THEME_PROFILE_CONTAINERS_GRADIENT2,
            ])),
        // elevation: 10,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(15.0),
        // ),
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 15, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textContainer("Service", templateService),
              textContainer("Description", templateDescription),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        new Container(
          color: Constants.THEME_DEFAULT_BACKGROUND,
        ),
        SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Column(
                children: [
                  getTopImageBar(),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Column(
                      children: [
                        getInfoContainer(),
                        getTemplateContainer(),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.grey),
                            ),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new Text(
                                  "Notifications",
                                  style: TextStyle(
                                    color: Constants.THEME_LABEL_COLOR,
                                  ),
                                ),
                                Switch(
                                  value: Constants.IS_THEME_DARK,
                                  onChanged: (value) {
                                    setState(() {});
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
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.grey),
                            ),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new Text(
                                  "Show Status",
                                  style: TextStyle(
                                    color: Constants.THEME_LABEL_COLOR,
                                  ),
                                ),
                                Switch(
                                  value: Constants.IS_THEME_DARK,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Colors.green,
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
