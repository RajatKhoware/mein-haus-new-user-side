class ProjectDetailsModel {
  String? responseCode;
  String? responseMessage;
  Services? services;

  ProjectDetailsModel({this.responseCode, this.responseMessage, this.services});

  ProjectDetailsModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    services = json['services'] != null
        ? new Services.fromJson(json['services'])
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

class Services {
  int? projectId;
  String? projectName;
  String? estimateNo;
  String? projectStartDate;
  String? projectCost;
  String? discription;
  String? address;
  List<String>? projectImages;
  List<ProfessionalWorkHistory>? professionalWorkHistory;
  String? proId;
  List<Reviews>? reviews;

  Services(
      {this.projectId,
      this.projectName,
      this.estimateNo,
      this.projectStartDate,
      this.projectCost,
      this.discription,
      this.address,
      this.projectImages,
      this.professionalWorkHistory,
      this.proId,
      this.reviews});

  Services.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    projectName = json['project_name'];
    estimateNo = json['estimate_no'];
    projectStartDate = json['project_start_date'];
    projectCost = json['project_cost'];
    discription = json['discription'];
    address = json['address'];
    projectImages = json['project_images'].cast<String>();
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['project_name'] = this.projectName;
    data['estimate_no'] = this.estimateNo;
    data['project_start_date'] = this.projectStartDate;
    data['project_cost'] = this.projectCost;
    data['discription'] = this.discription;
    data['address'] = this.address;
    data['project_images'] = this.projectImages;
    if (this.professionalWorkHistory != null) {
      data['professional_work_history'] =
          this.professionalWorkHistory!.map((v) => v.toJson()).toList();
    }
    data['pro_id'] = this.proId;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
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
  String? totalTimeInMinutes;

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
  String? punctuality;
  String? responsiveness;
  String? quality;

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
