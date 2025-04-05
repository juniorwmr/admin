class UserModel {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    email: json['email'],
    name: json['name'],
    photoUrl: json['photoUrl'],
  );

  Map<String, dynamic> toJson(UserModel user) => {
    'id': user.id,
    'email': user.email,
    'name': user.name,
    'photoUrl': user.photoUrl,
  };

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
  }) => UserModel(
    id: id ?? this.id,
    email: email ?? this.email,
    name: name ?? this.name,
    photoUrl: photoUrl ?? this.photoUrl,
  );
}
