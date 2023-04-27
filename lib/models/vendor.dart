class Vendor {
  int? id;
  String? name;
  String? username;
  String? apiToken;
  String? birth;
  String? type;

  Vendor(vendor) {
    id = vendor['id'];
    name = vendor['name'];
    username = vendor['username'];
    apiToken = vendor['api_token'] ?? '';
    birth = vendor['birth'];
    type = vendor['user_type'];
  }
}