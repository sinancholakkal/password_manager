class PasswordModel {
  String? id;
  String name;
  String? url;
  String? userName;
  String password;
  String? note;

  PasswordModel({
    required this.name,
    required this.password,
    this.url,
    this.note,
    this.userName,
    this.id,
  });
}