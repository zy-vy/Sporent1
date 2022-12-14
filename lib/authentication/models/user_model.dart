class userModel {
  final String? id;
  final String name;
  final String birthdate;
  final String email;
  final String phonenumber;

  const userModel(
      {this.id,
      required this.name,
      required this.birthdate,
      required this.email,
      required this.phonenumber});

  toJSON() {
    return {
      "name": name,
      "birthdate": birthdate,
      "email": email,
      "phone_number": phonenumber,
    };
  }
}
