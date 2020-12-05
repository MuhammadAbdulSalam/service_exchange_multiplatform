import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseHelper.dart';
import 'package:service_exchange_multiplatform/utils/uicomponents/Dialoge.dart';
import 'package:service_exchange_multiplatform/utils/uicomponents/ProfileInfoWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ProfileInfoPage extends StatefulWidget {
  @override
  _ProfileInfoPage createState() => new _ProfileInfoPage();
}

class _ProfileInfoPage extends State<ProfileInfoPage> {
  String templateService = "";
  String templateDescription = "";
  double opacity = 1.0;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final picker = ImagePicker();
  BuildContext mContext;
  String dpUrl;

  Future<void> pickImage() async {
    //Get the file from the image picker and store it
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    File _userDp = File(pickedFile.path);

    String imageKey = Uuid().v4();

    //Create a reference to the location you want to upload to in firebase
    Reference reference =
        FirebaseStorage.instance.ref().child("profile_image/" + imageKey);

    //Upload the file to firebase
    UploadTask uploadTask = reference.putFile(_userDp);
    var postKey = "";

    // Waits till the file is uploaded then stores the download url
    await uploadTask.snapshotEvents.listen((event) async {
      event.ref.getDownloadURL().then((value) async {
        dpUrl = value.toString();
        await FirebaseHelper.USER_DB
            .child(FirebaseAuth.instance.currentUser.uid)
            .child("dpUrl")
            .set(dpUrl)
            .then((value) async {
          setState(() {
            Constants.userList[0].dpUrl = dpUrl;

          });
          await FirebaseHelper.USER_DB
              .child(FirebaseAuth.instance.currentUser.uid)
              .child("posts")
              .onChildAdded
              .forEach((element) {
                postKey = element.snapshot.key.toString();
            FirebaseHelper.POST_DB
                .child(element.snapshot.key.toString())
                .child("dpUrl")
                .set(dpUrl)
                .then((value) {
              FirebaseHelper.POST_DB.child(postKey).child("Comments").onChildAdded.forEach((element) {

                if(element.snapshot.value["userId"] == FirebaseAuth.instance.currentUser.uid.toString())
                  {
                    FirebaseHelper.POST_DB.child(postKey).child("Comments").child(element.snapshot.key).child("userDpUrl").set(dpUrl);

                  }
              });
            });
          }).then((value) => {

          });
        });
      });
    });
  }

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
        Stack(
          alignment: Alignment.topRight,
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
                    ),
                    child: ClipOval(
                      child: Constants.userList[0].dpUrl != "default"
                          ? Image.network(
                              Constants.userList[0].dpUrl.toString(),
                              width: 130,
                              height: 130,
                              fit: BoxFit.cover)
                          : new Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[
                                    Constants
                                        .THEME_PROFILE_CONTAINERS_GRADIENT1,
                                    Constants
                                        .THEME_PROFILE_CONTAINERS_GRADIENT2,
                                  ])),
                              child: IconTheme(
                                data: new IconThemeData(color: Colors.white),
                                child: new Icon(
                                  Icons.person_add_alt,
                                  size: 40,
                                ),
                              ),
                            ),
                    ),
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
            Container(
              width: 40,
              height: 40,
              child: FlatButton(
                onPressed: () {
                  pickImage();
                },
                child: Container(
                  child: new IconTheme(
                    data: new IconThemeData(color: Colors.blueAccent),
                    child: new Icon(Icons.edit),
                  ),
                ),
              ),
            ),
          ],
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
    mContext = context;
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
