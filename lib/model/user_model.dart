class User {
  final String name;
  final String email;
  final String plan;
  final String? startDate;
  final String? expiredDate;
  final String userType;

  User(
      {required this.name,
      required this.email,
      required this.plan,
      this.startDate,
      required this.userType,
      this.expiredDate});

  User.fromJson(Map json)
      : name = json['full_name'],
        email = json['email'],
        startDate = json['start_date'],
        userType = json['user_type'],
        expiredDate = json['expired_date'],
        plan = json['plan'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'code': email,
        'plan': plan,
        'start_date': startDate,
        'user_type': userType,
        'expired_date': expiredDate,
      };
}
