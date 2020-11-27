
class PostList {
  List<PostsModel> recipeList;

  PostList({this.recipeList});

  factory PostList.fromJSON(Map<dynamic, dynamic> json) {
    return PostList(recipeList: parserecipes(json));
  }

  static List<PostsModel> parserecipes(recipeJSON) {
    var rList = recipeJSON['Posts'] as List;
    List<PostsModel> recipeList =
    rList.map((data) => PostsModel.fromJson(data)).toList();
    return recipeList;
  }
}


class PostsModel {
  String userDpUrl;
  String userId;
  String longitude;
  String latitude;
  String requiredService;
  String requiredDescription;
  String returnService;
  String returnDescription;
  String userName;

  PostsModel({
      this.userDpUrl,
      this.userId,
      this.longitude,
      this.latitude,
      this.requiredService,
      this.requiredDescription,
      this.returnService,
      this.returnDescription,
  this.userName});

  factory PostsModel.fromJson(Map<dynamic, dynamic> parsedJson) {

    return PostsModel(
      userDpUrl: parsedJson['dpUrl'],
        userName: parsedJson['userName'],
        userId: parsedJson['postTitle'],
      longitude: parsedJson['longitude'],
      latitude: parsedJson['latitude'],
      requiredService: parsedJson['postTitle'],
      requiredDescription: parsedJson['description'],
      returnService: parsedJson['returnService'],
      returnDescription: parsedJson['returnDescription']);

  }


}
