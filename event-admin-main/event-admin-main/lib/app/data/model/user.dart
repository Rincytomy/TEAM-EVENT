// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    User({
        this.id,
        this.firstName,
        this.email,
        this.createdAt,
        this.address,
        this.dob,
        this.type,
        this.isVerified,
        this.isActive,
        this.lastName,
        this.phone,
        this.company,
    });

    int? id;
    String? firstName;
    String? email;
    DateTime? createdAt;
    String? address;
    String? dob;
    String? type;
    bool? isVerified;
    bool? isActive;
    String? lastName;
    String? phone;
    Companies?  company;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        email: json["email"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        address: json["address"],
        dob: json["dob"],
        type: json["type"],
        isVerified: json["is_verified"],
        isActive: json["is_active"],
        lastName: json["last_name"],
        phone: json["phone"],
        company: json["companies"] == null ? null : Companies.fromJson(json["companies"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "email": email,
        "created_at": createdAt?.toIso8601String(),
        "address": address,
        "dob": dob,
        "type": type,
        "is_verified": isVerified,
        "is_active": isActive,
        "last_name": lastName,
        "phone": phone,
        "companies": company?.toJson(),
    };
}

class Companies {
    Companies({
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

    factory Companies.fromJson(Map<String, dynamic> json) => Companies(
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
