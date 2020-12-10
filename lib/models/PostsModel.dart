
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
  String cashComp;
  String invTravel;
  String canTravel;
  String offerKey;
  int numberOfOffers;


  int get setNumberOfOffers => numberOfOffers;

  set getNumberOfOffers(int value) {
    numberOfOffers = value;
  }


  String get setOfferKey => offerKey;

  set getOfferKey(String value) {
    offerKey = value;
  }


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
    this.canTravel,
    this.invTravel,
    this.cashComp,
  this.userName,
  this.postId});

  factory PostsModel.fromJson(Map<dynamic, dynamic> parsedJson, String postID) {

    return PostsModel(
      userDpUrl: parsedJson['dpUrl'],
        userName: parsedJson['userName'],
        userId: parsedJson['userId'],
      longitude: parsedJson['longitude'],
      latitude: parsedJson['latitude'],
      requiredService: parsedJson['postTitle'],
      requiredDescription: parsedJson['description'],
      returnService: parsedJson['returnService'],
      returnDescription: parsedJson['returnDescription'],
      canTravel: parsedJson['canTravel'],
        cashComp: parsedJson['cashComp'],
        invTravel: parsedJson['invTravel'],

        postId: postID
    );

  }


}
