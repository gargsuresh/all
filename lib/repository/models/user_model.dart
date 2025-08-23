class User {
  final String id;
  final String name;
  final String mobile ;

  User({required this.id, required this.name, required this.mobile});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
    );
  }
}
