// To parse this JSON data,
// do//// final user = userFromJson(jsonString);
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.firstName,
    this.email,
    this.address,
    this.dob,
    this.type,
    this.lastName,
    this.phone,
    this.company,
  });
  int? id;
  String? firstName;
  String? email;
  String? address;
  String? dob;
  String? type;
  String? lastName;
  String? phone;
  Company? company;
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        email: json["email"],
        address: json["address"],
        dob: json["dob"],
        type: json["type"],
        lastName: json["last_name"],
        phone: json["phone"],
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "email": email,
        "address": address,
        "dob": dob,
        "type": type,
        "last_name": lastName,
        "phone": phone,
        "company": company?.toJson(),
      };
}

class Company {
  Company({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.website,
    this.logo,
    this.coverPhoto,
    this.address,
    this.location,
    this.isActive,
  });
  int? id;
  int? userId;
  String? name;
  String? email;
  String? phone;
  String? website;
  String? logo;
  String? coverPhoto;
  String? address;
  String? location;
  bool? isActive;
  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        website: json["website"],
        logo: json["logo"],
        coverPhoto: json["cover_photo"],
        address: json["address"],
        location: json["location"],
        isActive: json["is_active"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "website": website,
        "logo": logo,
        "cover_photo": coverPhoto,
        "address": address,
        "location": location,
        "is_active": isActive,
      };
}
