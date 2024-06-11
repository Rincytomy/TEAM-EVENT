// To parse this JSON data, do////
//final job = jobFromJson(jsonString);
import 'dart:convert';

import 'events.dart';

List<Job> jobFromJson(String str) =>
    List<Job>.from(json.decode(str).map((x) => Job.fromJson(x)));
String jobToJson(List<Job> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Job {
  Job({
    this.id,
    this.companyId,
    this.title,
    this.description,
    this.location,
    this.vacancy,
    this.salary,
    this.isActive,
    this.isFilled,
    this.createdAt,
    this.companies,
  });
  int? id;
  int? companyId;
  String? title;
  String? description;
  String? location;
  int? vacancy;
  String? salary;
  bool? isActive;
  bool? isFilled;
  DateTime? createdAt;
  Companies? companies;
  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        companyId: json["company_id"],
        title: json["title"],
        description: json["description"],
        location: json["location"],
        vacancy: json["vacancy"],
        salary: json["salary"],
        isActive: json["is_active"],
        isFilled: json["is_filled"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        companies: json["companies"] == null
            ? null
            : Companies.fromJson(json["companies"]),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "title": title,
        "description": description,
        "location": location,
        "vacancy": vacancy,
        "salary": salary,
        "is_active": isActive,
        "is_filled": isFilled,
        "created_at": createdAt?.toIso8601String(),
        "companies": companies?.toJson(),
      };
}
