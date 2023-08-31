import 'package:new_user_side/data/models/ongoing_project_model.dart';

class AdditionalWorkModel {
  String? status;
  String? responseMessage;
  List<AdditionalWork>? additionalWork;

  AdditionalWorkModel({this.status, this.responseMessage, this.additionalWork});

  AdditionalWorkModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseMessage = json['message'];
    if (json['additional_work'] != null) {
      additionalWork = <AdditionalWork>[];
      json['additional_work'].forEach((v) {
        additionalWork!.add(new AdditionalWork.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.responseMessage;
    if (this.additionalWork != null) {
      data['additional_work'] =
          this.additionalWork!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdditionalWork {
  int? id;
  String? title;
  String? description;
  List<ProjectImages>? images;
  String? amount;
  int? status;

  AdditionalWork(
      {this.id,
      this.title,
      this.description,
      this.images,
      this.amount,
      this.status});

  AdditionalWork.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    if (json['images'] != null) {
      images = <ProjectImages>[];
      json['images'].forEach((v) {
        images!.add(new ProjectImages.fromJson(v));
      });
    }
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    data['status'] = this.status;
    return data;
  }
}
