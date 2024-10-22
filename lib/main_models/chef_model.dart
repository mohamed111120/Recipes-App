class ChefModel {
  String? name;
  String? email;
  String? uid;
  String? photoUrl;
  String? phoneNumber;
  String? address;
  int? yearsOfExperience;
  String? fcm ;

  ChefModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.phoneNumber,
    required this.address,
    required this.yearsOfExperience,
    required this.fcm,
  });

  ChefModel.fromJson(Map<String, dynamic> json) {
    name = json['chef name'];
    email = json['chef email'];
    uid = json['uid'];
    photoUrl = json['chef photo'];
    phoneNumber = json['chef phone number'];
    address = json['chef address'];
    yearsOfExperience = json['chef years of experience'];
    fcm = json['fcm'];
  }

  Map<String, dynamic> toJson() {
    return {
      'chef name': name,
      'chef email': email,
      'uid': uid,
      'chef photo': photoUrl,
      'chef phone number': phoneNumber,
      'chef address': address,
      'chef years of experience': yearsOfExperience,
      'fcm': fcm
    };
  }
}
