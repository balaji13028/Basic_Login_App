// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserProfileData {
  String? id;
  String? name;
  String? email;
  String? password;
  String? gender;

  UserProfileData({
    this.id,
    this.name,
    this.email,
    this.password,
    this.gender,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
    };
  }

  factory UserProfileData.fromMap(Map<String, dynamic> map) {
    return UserProfileData(
      id: map['emId'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
    );
  }
}
