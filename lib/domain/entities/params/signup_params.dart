class SignupParams {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  int? gender;
  String? age;

  SignupParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.age,
    required this.gender,
  });
}
