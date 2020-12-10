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

  Future<List<PostsModel>> getOffersPosts(OffersListType offersListType) async {
    List<PostsModel> postList = [];

    if (offersListType == OffersListType.RECEIVED) {
      await FirebaseHelper.POST_DB
          .orderByChild('userId')
          .equalTo(FirebaseAuth.instance.currentUser.uid.toString())
          .onChildAdded
          .listen((event) {
        if (event.snapshot.value['offers'] != null) {
          postList.add(FirebaseHelper.getPostModel(event));
        }
      });
    } else if (offersListType == OffersListType.SENT) {
      await FirebaseHelper.USER_DB
          .child(FirebaseAuth.instance.currentUser.uid.toString())
          .child('sentOffers')
          .once()
          .then((result) {
        if (result.value != null) {
          result.value.forEach((key, childSnapshot) {
            FirebaseHelper.POST_DB
                .orderByKey()
                .equalTo(childSnapshot.toString())
                .onChildAdded
                .listen((event) {
                  PostsModel postsModel = FirebaseHelper.getPostModel(event);
                  postsModel.offerKey = key;
                  postsModel.postId = event.snapshot.key;

              postList.add(postsModel);
            });
          });
        }
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
