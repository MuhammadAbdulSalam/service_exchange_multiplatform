
import 'package:firebase_database/firebase_database.dart';

class FirebaseHelper {

  // ignore: non_constant_identifier_names
  static final USER_DB = FirebaseDatabase.instance.reference().child('Users');
  static final POST_DB = FirebaseDatabase.instance.reference().child('Posts');

  static DatabaseReference getCommentsDB(String postID){

    var COMMENT_DB = FirebaseDatabase.instance.reference().child('Posts').child(postID).child("Comments");

    return COMMENT_DB;

  }

}