
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

  PostsModel({
      this.userDpUrl,
      this.userId,
      this.longitude,
      this.latitude,
      this.requiredService,
      this.requiredDescription,
      this.returnService,
      this.returnDescription});

  factory PostsModel.fromJson(Map<dynamic, dynamic> parsedJson) {

    return PostsModel(
      userDpUrl: parsedJson['postTitle'],
      userId: parsedJson['postTitle'],
      longitude: parsedJson['postTitle'],
      latitude: parsedJson['postTitle'],
      requiredService: parsedJson['postTitle'],
      requiredDescription: parsedJson['postTitle'],
      returnService: parsedJson['postTitle'],
      returnDescription: parsedJson['postTitle']);
  }


}
