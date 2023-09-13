import 'package:new_user_side/data/models/generated_estimate_model.dart';

class ProjectDetailsModel {
  String? responseCode;
  String? responseMessage;
  Project? services;

  ProjectDetailsModel({this.responseCode, this.responseMessage, this.services});

  ProjectDetailsModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    services = json['services'] != null
        ? new Project.fromJson(json['services'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_message'] = this.responseMessage;
    if (this.services != null) {
      data['services'] = this.services!.toJson();
    }
    return data;
  }
}

class Project {
  int? projectId;
  String? projectName;
  String? estimateNo;
  String? projectStartDate;
  String? projectCost;
  String? discription;
  String? address;
  List<UploadedImgs>? projectImages;
  List<ProfessionalWorkHistory>? professionalWorkHistory;
  int? proId;
  List<Reviews>? reviews;
  Query? query;
  bool? normal;
  bool? isCompleted;

  Project({
    this.projectId,
    this.projectName,
    this.estimateNo,
    this.projectStartDate,
    this.projectCost,
    this.discription,
    this.address,
    this.projectImages,
    this.professionalWorkHistory,
    this.proId,
    this.reviews,
    this.query,
    this.normal,
    this.isCompleted,
  });

  Project.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    projectName = json['project_name'];
    estimateNo = json['estimate_no'];
    projectStartDate = json['project_start_date'];
    projectCost = json['project_cost'];
    discription = json['description'];
    address = json['address'];
    if (json['project_images'] != null) {
      projectImages = <UploadedImgs>[];
      json['project_images'].forEach((v) {
        projectImages!.add(new UploadedImgs.fromJson(v));
      });
    }
    if (json['professional_work_history'] != null) {
      professionalWorkHistory = <ProfessionalWorkHistory>[];
      json['professional_work_history'].forEach((v) {
        professionalWorkHistory!.add(new ProfessionalWorkHistory.fromJson(v));
      });
    }
    proId = json['pro_id'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
    normal = json['normal'];
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['project_name'] = this.projectName;
    data['estimate_no'] = this.estimateNo;
    data['project_start_date'] = this.projectStartDate;
    data['project_cost'] = this.projectCost;
    data['description'] = this.discription;
    data['address'] = this.address;
    if (this.projectImages != null) {
      data['project_images'] =
          this.projectImages!.map((v) => v.toJson()).toList();
    }
    if (this.professionalWorkHistory != null) {
      data['professional_work_history'] =
          this.professionalWorkHistory!.map((v) => v.toJson()).toList();
    }
    data['pro_id'] = this.proId;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    if (this.query != null) {
      data['query'] = this.query!.toJson();
    }
    data['normal'] = this.normal;
    data['is_completed'] = this.isCompleted;
    return data;
  }
}

class ProfessionalWorkHistory {
  int? totalTime;
  List<WorkDetails>? workDetails;

  ProfessionalWorkHistory({this.totalTime, this.workDetails});

  ProfessionalWorkHistory.fromJson(Map<String, dynamic> json) {
    totalTime = json['total_time'];
    if (json['work_details'] != null) {
      workDetails = <WorkDetails>[];
      json['work_details'].forEach((v) {
        workDetails!.add(new WorkDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_time'] = this.totalTime;
    if (this.workDetails != null) {
      data['work_details'] = this.workDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkDetails {
  String? startTime;
  String? endTime;
  int? totalTimeInMinutes;

  WorkDetails({this.startTime, this.endTime, this.totalTimeInMinutes});

  WorkDetails.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
    totalTimeInMinutes = json['total_time_in_minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['total_time_in_minutes'] = this.totalTimeInMinutes;
    return data;
  }
}

class Reviews {
  String? review;
  int? punctuality;
  int? responsiveness;
  int? quality;

  Reviews({this.review, this.punctuality, this.responsiveness, this.quality});

  Reviews.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    punctuality = json['punctuality'];
    responsiveness = json['responsiveness'];
    quality = json['quality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review'] = this.review;
    data['punctuality'] = this.punctuality;
    data['responsiveness'] = this.responsiveness;
    data['quality'] = this.quality;
    return data;
  }
}

class Query {
  int? id;
  int? estimateServiceId;
  int? userId;
  String? query;
  int? status;
  int? acceptedBy;
  String? ticket;
  int? endStatus;
  int? resolved;
  String? createdAt;
  String? updatedAt;
  int? flagged;

  Query(
      {this.id,
      this.estimateServiceId,
      this.userId,
      this.query,
      this.status,
      this.acceptedBy,
      this.ticket,
      this.endStatus,
      this.resolved,
      this.createdAt,
      this.updatedAt,
      this.flagged});

  Query.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estimateServiceId = json['estimate_service_id'];
    userId = json['user_id'];
    query = json['query'];
    status = json['status'];
    acceptedBy = json['accepted_by'];
    ticket = json['ticket'];
    endStatus = json['end_status'];
    resolved = json['resolved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    flagged = json['flagged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['estimate_service_id'] = this.estimateServiceId;
    data['user_id'] = this.userId;
    data['query'] = this.query;
    data['status'] = this.status;
    data['accepted_by'] = this.acceptedBy;
    data['ticket'] = this.ticket;
    data['end_status'] = this.endStatus;
    data['resolved'] = this.resolved;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['flagged'] = this.flagged;
    return data;
  }
}
