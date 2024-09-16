class ShopLoginModel {
  final bool status;
  final String? message;
  final UserData? data;

  ShopLoginModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory ShopLoginModel.fromJson(Map<String, dynamic> json) {
    return ShopLoginModel(
      status: json['status'],
      message: json['message'] ?? "",
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String token;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.token,
  });
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'token': token,
    };
  }

  Map<String, dynamic> toMapForUpdate() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
    };
  }
}
