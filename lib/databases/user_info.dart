class NewUserInfo {
  final String name;
  final int age;
  final String sex;
  final String photo;
  final String id;
  NewUserInfo({
    this.name,
    this.age,
    this.sex,
    this.photo, //path to the taken photo.
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'sex': sex,
      'photo': photo,
    };
  }
}
