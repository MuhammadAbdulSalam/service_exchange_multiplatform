class CommentsList {
  List<CommentModel> commentsList;

  CommentsList({this.commentsList});

  factory CommentsList.fromJSON(Map<dynamic, dynamic> json) {
    return CommentsList(commentsList: parseUsers(json));
  }

  static List<CommentModel> parseUsers(userJson) {
    var rList = userJson['Comments'] as List;
    List<CommentModel> commentsList =
    rList.map((data) => CommentModel.fromJson(data)).toList();
    return commentsList;
  }
}

class CommentModel {
  String comment;
  String name;
  String userDpUrl;
  String userId;


  CommentModel(
      {this.comment,
        this.name,
        this.userDpUrl,
        this.userId});

  factory CommentModel.fromJson(Map<dynamic, dynamic> parsedJson) {

    return CommentModel(
        comment: parsedJson['comment'],
        name: parsedJson['name'],
        userDpUrl: parsedJson['userDpUrl:'],
        userId: parsedJson['userId']);
  }
}
