// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  dynamic responseCode;
  String? responseMessage;
  User? user;

  UserModel({this.responseMessage, this.user, String? responseCode});

  UserModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['status'] = this.responseMessage;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }

  UserModel copyWith(
      {String? responseMessage, User? user, String? responseCode}) {
    return UserModel(
      responseCode: responseCode ?? this.responseCode,
      responseMessage: responseMessage ?? this.responseMessage,
      user: user ?? this.user,
    );
  }

  @override
  String toString() => "User = $user";
}

class User {
  int? userId;
  String? email;
  String? firstname;
  String? lastname;
  String? profilePic;
  String? contact;
  List<SavedAddress>? savedAddress;
  String? token;
  bool? isSocialLogin;
  bool? phoneVerified;
  bool? emailVerified;

  User({
    this.userId,
    this.email,
    this.firstname,
    this.lastname,
    this.profilePic,
    this.contact,
    this.savedAddress,
    this.token,
    this.isSocialLogin,
    this.phoneVerified,
    this.emailVerified,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    profilePic = json['profile_pic'];
    contact = json['contact'];
    if (json['saved_address'] != null) {
      savedAddress = <SavedAddress>[];
      json['saved_address'].forEach((v) {
        savedAddress!.add(new SavedAddress.fromJson(v));
      });
    }
    token = json['token'];
    isSocialLogin = json['is_social_login'];
    phoneVerified = json['phone_verified_at'];
    emailVerified = json['email_verified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['profile_pic'] = this.profilePic;
    data['contact'] = this.contact;
    if (this.savedAddress != null) {
      data['saved_address'] =
          this.savedAddress!.map((v) => v.toJson()).toList();
    }
    data['token'] = this.token;
    data['is_social_login'] = this.isSocialLogin;
    data['phone_verified_at'] = this.phoneVerified;
    data['email_verified_at'] = this.emailVerified;
    return data;
  }

  User copyWith({
    int? userId,
    String? email,
    String? firstname,
    String? lastname,
    String? profilePic,
    String? contact,
    List<SavedAddress>? savedAddress,
    String? token,
    bool? isSocialLogin,
    bool? phoneVerified,
    bool? emailVerified,
  }) {
    return User(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      profilePic: profilePic ?? this.profilePic,
      contact: contact ?? this.contact,
      savedAddress: savedAddress ?? this.savedAddress,
      token: token ?? this.token,
      isSocialLogin: isSocialLogin ?? this.isSocialLogin,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }

  @override
  String toString() {
    return "UserId = $userId, UserName = $firstname $lastname,Token = $token";
  }
}

class SavedAddress {
  int? id;
  dynamic userId;
  String? line1;
  String? line2;
  String? city;
  String? state;
  String? country;
  String? postal_code;
  String? phone;
  String? type;
  int? isDefault;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
// postal_code
  SavedAddress(
      {this.id,
      this.userId,
      this.line1,
      this.line2,
      this.city,
      this.state,
      this.country,
      this.postal_code,
      this.phone,
      this.type,
      this.isDefault,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  SavedAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    line1 = json['line1'];
    line2 = json['line2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postal_code = json['postal_code'];
    phone = json['phone'];
    type = json['type'];
    isDefault = json['is_default'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postal_code'] = this.postal_code;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['is_default'] = this.isDefault;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }

  SavedAddress copyWith({
    int? id,
    dynamic userId,
    String? line1,
    String? line2,
    String? city,
    String? state,
    String? country,
    String? postal_code,
    String? phone,
    String? type,
    int? isDefault,
    String? latitude,
    String? longitude,
    String? createdAt,
    String? updatedAt,
    Null deletedAt,
  }) {
    return SavedAddress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postal_code: postal_code ?? this.postal_code,
      phone: phone ?? this.phone,
      type: type ?? this.type,
      isDefault: isDefault ?? this.isDefault,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
