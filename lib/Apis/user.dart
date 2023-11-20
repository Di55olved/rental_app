class Users {
  late String image;
  late final int balance;
  late final int strikes;
  late String name;
  late final String id;
  late final String email;
  late final String status;

  Users(
      {required this.image,
      required this.balance,
      required this.strikes,
      required this.name,
      required this.id,
      required this.email,
      required this.status});

  Users.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    balance = json['balance'];
    strikes = json['strikes'];
    name = json['name'];
    id = json['id'];
    email = json['email'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['balance'] = balance;
    data['strikes'] = strikes;
    data['name'] = name;
    data['id'] = id;
    data['email'] = email;
    data['status'] = status;
    return data;
  }
}
