import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));
String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    this.id,
    this.companyId,
    this.title,
    this.description,
    this.location,
    this.link,
    this.date,
    this.isActive,
    this.createdAt,
    this.companies,
    this.galleries,
  });
  int? id;
  int? companyId;
  String? title;
  String? description;
  String? location;
  String? link;
  DateTime? date;
  bool? isActive;
  DateTime? createdAt;
  Companies? companies;
  List<Gallery>? galleries;
  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        companyId: json["company_id"],
        title: json["title"],
        description: json["description"],
        location: json["location"],
        link: json["link"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        isActive: json["is_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        companies: json["companies"] == null
            ? null
            : Companies.fromJson(json["companies"]),
        galleries: json["galleries"] == null
            ? []
            : List<Gallery>.from(
                json["galleries"]!.map((x) => Gallery.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "title": title,
        "description": description,
        "location": location,
        "link": link,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "companies": companies?.toJson(),
        "galleries": galleries == null
            ? []
            : List<dynamic>.from(galleries!.map((x) => x.toJson())),
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

class Gallery {
  Gallery({
    this.id,
    this.postId,
    this.image,
  });
  int? id;
  int? postId;
  String? image;
  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"],
        postId: json["post_id"],
        image: json["image"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "post_id": postId,
        "image": image,
      };
}
