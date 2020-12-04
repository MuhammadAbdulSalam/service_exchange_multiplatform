
class PostList {
  List<PostsModel> recipeList;
  String key;

  PostList({this.recipeList, this.key});

  factory PostList.fromJSON(Map<dynamic, dynamic> json, String key) {
    return PostList(recipeList: parsePosts(json, key));
  }

  static List<PostsModel> parsePosts(recipeJSON, key) {
    var rList = recipeJSON['Posts'] as List;
    List<PostsModel> recipeList =
    rList.map((data) => PostsModel.fromJson(data, key)).toList();
    return recipeList;
  }
}


class PostsModel {
  String postId;
  String userDpUrl;
  String userId;
  String longitude;
  String latitude;
  String requiredService;
  String requiredDescription;
  String returnService;
  String returnDescription;
  String userName;


  String get setPostId => postId;

  set getPostId(String value) {
    postId = value;
  }

  PostsModel({
      this.userDpUrl,
      this.userId,
      this.longitude,
      this.latitude,
      this.requiredService,
      this.requiredDescription,
      this.returnService,
      this.returnDescription,
  this.userName,
  this.postId});

  factory PostsModel.fromJson(Map<dynamic, dynamic> parsedJson, String postID) {

    return PostsModel(
      userDpUrl: parsedJson['dpUrl'],
        userName: parsedJson['userName'],
        userId: parsedJson['postTitle'],
      longitude: parsedJson['longitude'],
      latitude: parsedJson['latitude'],
      requiredService: parsedJson['postTitle'],
      requiredDescription: parsedJson['description'],
      returnService: parsedJson['returnService'],
      returnDescription: parsedJson['returnDescription'],
      postId: postID
    );

  }


}
