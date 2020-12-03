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

  _ProfileInfoPage() {
    getDescription().then((value) => setState(() {
          templateDescription = value;
        }));

    getService().then((val) => setState(() {
          templateService = val;
        }));
  }

  Container textContainer(String label, String value) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Text(
              label,
              style: TextStyle(
                  color: Constants.THEME_PROFILE_INFO_LABEL,
                  fontWeight: FontWeight.bold,
                  fontSize: 10),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
            child: Text(
              value,
              style: TextStyle(
                  color: Constants.THEME_LABEL_COLOR,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
      color: Constants.THEME_DEFAULT_BACKGROUND,
      child: Column(
        children: [
          Container(
            width: 130,
            height: 130,
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
                  width: 20,
                  height: 20,
                  decoration: new BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 5,
                  child: Card(
                    color: Colors.orange,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 10, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          textContainer("Name", Constants.userList[0].name),
                          textContainer(
                              "Job Title", Constants.userList[0].jobTitle),
                          textContainer(
                              "Email",
                              FirebaseAuth.instance.currentUser.email
                                  .toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  width: MediaQuery.of(context).size.width - 5,
                  child: Card(
                    color: Constants.THEME_CARD_COLOR,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
