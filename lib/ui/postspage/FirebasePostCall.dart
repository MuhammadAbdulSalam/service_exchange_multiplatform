
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_exchange_multiplatform/models/PostsModel.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseHelper.dart';



class FirebasePostCall {

  Future<List<PostsModel>> getPostsList(listType typeOfList) async {

    List<PostsModel> postList = [];

    if (typeOfList ==listType.NEAR_ME) {

      await FirebaseHelper.POST_DB.once().then((result) async {
        if (result.value != null) {
          result.value.forEach((key, childSnapshot) {

            postList.add(PostsModel.fromJson(Map.from(childSnapshot)));
          });
        } else {
          print('getUserJobs() no jobs found');
        }
      }).catchError((e) {
        print('getUserJobs() error: $e');
      });
    }

    else if(typeOfList ==listType.MY_POSTS){

      await FirebaseHelper.POST_DB.orderByChild("userId").equalTo(FirebaseAuth.instance.currentUser.uid.toString()).once().then((result) async {
        if (result.value != null) {
          result.value.forEach((key, childSnapshot) {

            postList.add(PostsModel.fromJson(Map.from(childSnapshot)));
          });
        } else {
          print('getUserJobs() no jobs found');
        }
      }).catchError((e) {
        print('getUserJobs() error: $e');
      });
    }

    return postList;
  }
}