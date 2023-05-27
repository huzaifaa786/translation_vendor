class User {
  int? id;
  String? username;
  String? apiToken;
  String? number;
  String? email;
  String? profilePic;

  User(user) {
    id = user['id'];
    username = user['username'];
    number = user['phone'];
    apiToken = user['api_token'] ?? '';
    email = user['email'];
    profilePic = user['profilepic'] ?? '';
  }
}
