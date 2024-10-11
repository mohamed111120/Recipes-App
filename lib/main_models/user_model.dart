class UserModel {
  String? name;
  String? email;
  String? uid;
  String? photoUrl;
  String? phoneNumber;
  String? address;
  List<String>? favoriteRecipes;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.phoneNumber,
    required this.address,
    required this.favoriteRecipes,
  });


  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uid = json['uid'];
    photoUrl = json['photoUrl'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    favoriteRecipes =List<String>.from(json['favoriteRecipes']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'address': address,
      'favoriteRecipes': favoriteRecipes,
    };
  }
}
