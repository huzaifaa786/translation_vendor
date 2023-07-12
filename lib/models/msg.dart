class Msg {
  String? id;
  String? body;
  String? from_id;
  String? to_id;
  String? file_name;
  String? file_title;
  String? file_type;
  DateTime? dateTime;

  Msg(massage) {
    id = massage['id'];
    body = massage['body'];
    from_id = massage['from_id'].toString();
    to_id = massage['to_id'];
    file_name = massage['attachment'] != null ? massage['attachment']['file'] ?? '' : '';
    file_title = massage['attachment'] != null ? massage['attachment']['title'] ?? '' : '';
    file_type = massage['attachment'] != null ? massage['attachment']['type'] ?? '' : '';
    dateTime = DateTime.parse(massage['created_at']).toLocal();
  }
}
