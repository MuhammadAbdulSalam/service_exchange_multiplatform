class UserList {
  List<UserDataModel> userList;

  UserList({this.userList});

  factory UserList.fromJSON(Map<dynamic, dynamic> json) {
    return UserList(userList: parseUsers(json));
  }

  static List<UserDataModel> parseUsers(userJson) {
    var rList = userJson['Users'] as List;
    List<UserDataModel> userList =
        rList.map((data) => UserDataModel.fromJson(data)).toList();
    return userList;
  }
}

class UserDataModel {
  String address;
  String dpUrl;
  String jobTitle;
  String name;
  String phoneNumber;


  UserDataModel(
      {this.address,
      this.dpUrl,
      this.jobTitle,
      this.name,
      this.phoneNumber});

  factory UserDataModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    return UserDataModel(
        address: parsedJson['address'],
        dpUrl: parsedJson['dpUrl'],
        jobTitle: parsedJson['jobTitle'],
        name: parsedJson['name'],
        phoneNumber: parsedJson['phoneNumber']);
  }
}
