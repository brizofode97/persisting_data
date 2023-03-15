class Password {
  int? id;
  late String name;
  late String password;

  Password({required this.name, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> mapPassword = <String, dynamic>{};
    mapPassword['id'] = id;
    mapPassword['name'] = name;
    mapPassword['password'] = password;
    return mapPassword;
  }

  Password.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    password = json['password'];
  }
}
