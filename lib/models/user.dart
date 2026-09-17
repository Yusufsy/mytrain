class User{
  String id;
  String? fullname;
  String? email;
  String? password;

  User({required this.id, this.fullname, this.email, this.password});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'].toString(),
      fullname: map['fullName'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullname,
      'email': email,
      'password': password,
    };
  }

}