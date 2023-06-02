class User {
  int? id;
  String? username;
  String? number;
  String? email;
  String? profilePic;

  User(user) {
    id = user['id'];
    username = user['username'];
    number = user['phone'];
    email = user['email'];
    profilePic = user['profilepic'] ?? '';
  }
}
