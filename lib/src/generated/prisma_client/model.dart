class User {
  const User({
    this.id,
    this.name,
    this.lastName,
  });

  factory User.fromJson(Map json) => User(
        id: json['id'],
        name: json['name'],
        lastName: json['lastName'],
      );

  final int? id;

  final String? name;

  final String? lastName;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastName': lastName,
      };
}
