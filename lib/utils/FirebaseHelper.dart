
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:service_exchange_multiplatform/models/PostsModel.dart';

class FirebaseHelper {

  // ignore: non_constant_identifier_names
  static final USER_DB = FirebaseDatabase.instance.reference().child('Users');
  static final POST_DB = FirebaseDatabase.instance.reference().child('Posts');

  static DatabaseReference getCommentsDB(String postID){

    var COMMENT_DB = FirebaseDatabase.instance.reference().child('Posts').child(postID).child("Comments");

    return COMMENT_DB;

  }


  static PostsModel getPostModel(Event event)
  {

    PostsModel postsModel = PostsModel();
    postsModel.postId = event.snapshot.key.toString();
    postsModel.userDpUrl = event.snapshot.value['dpUrl'];
    postsModel.userId = event.snapshot.value['userId'];
    postsModel.longitude = event.snapshot.value['longitude'];
    postsModel.latitude = event.snapshot.value['latitude'];
    postsModel.requiredService = event.snapshot.value['postTitle'];
    postsModel.requiredDescription = event.snapshot.value['description'];
    postsModel.returnService = event.snapshot.value['returnService'];
    postsModel.returnDescription =
    event.snapshot.value['returnDescription'];
    postsModel.userName = event.snapshot.value['userName'];
    postsModel.cashComp = event.snapshot.value['cashComp'];
    postsModel.invTravel = event.snapshot.value['invTravel'];
    postsModel.canTravel = event.snapshot.value['canTravel'];


    return postsModel;
  }



}