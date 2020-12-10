import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:service_exchange_multiplatform/models/CommentsModel.dart';
import 'package:service_exchange_multiplatform/models/PostsModel.dart';
import 'package:service_exchange_multiplatform/models/UserDataModel.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseHelper.dart';

class FirebaseCallHelper {
  Future<List<PostsModel>> getPostsList(listType typeOfList) async {
    List<PostsModel> postList = [];

    if (typeOfList == listType.NEAR_ME) {
      await FirebaseHelper.POST_DB.onChildAdded.listen((event) {
        postList.add(FirebaseHelper.getPostModel(event));
      });
    } else if (typeOfList == listType.MY_POSTS) {
      await FirebaseHelper.POST_DB
          .orderByChild("userId")
          .equalTo(FirebaseAuth.instance.currentUser.uid.toString())
          .onChildAdded
          .listen((event) {
        postList.add(FirebaseHelper.getPostModel(event));
      });
    }

    return postList;
  }

  Future<List<PostsModel>> getOffersPosts(
      OffersListType offersListType, HashMap<String, String> sentOffers) async {
    List<PostsModel> postList = [];

    if (offersListType == OffersListType.RECEIVED) {
      await FirebaseHelper.POST_DB
          .orderByChild('userId')
          .equalTo(FirebaseAuth.instance.currentUser.uid.toString())
          .onChildAdded
          .listen((event) {
        if (event.snapshot.value['offers'] != null) {

          PostsModel postsModel = FirebaseHelper.getPostModel(event);
          postsModel.numberOfOffers = event.snapshot.value['offers'].length;
          postList.add(postsModel);
        }
      });
    } else if (offersListType == OffersListType.SENT) {
      sentOffers.forEach((key, value) {
        FirebaseHelper.POST_DB
            .orderByKey()
            .equalTo(value.toString())
            .onChildAdded
            .listen((event) {
          PostsModel postsModel = FirebaseHelper.getPostModel(event);
          postsModel.offerKey = key;
          postList.add(postsModel);
        });
      });
    }

    return postList;
  }

  Future<List<UserDataModel>> getUserList() async {
    List<UserDataModel> userList = [];

    await FirebaseHelper.USER_DB
        .orderByKey()
        .equalTo(FirebaseAuth.instance.currentUser.uid.toString())
        .once()
        .then((result) async {
      if (result.value != null) {
        result.value.forEach((key, childSnapshot) {
          userList.add(UserDataModel.fromJson(Map.from(childSnapshot)));
        });
      } else {
        print('getUserJobs() no jobs found');
      }
    }).catchError((e) {
      print('getUserJobs() error: $e');
    });

    return userList;
  }

  Query getCommentsQuery(String postId) {
    return FirebaseDatabase.instance
        .reference()
        .child("Posts")
        .child(postId)
        .child("Comments");
  }
}
