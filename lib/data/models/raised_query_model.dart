class RaisedQueryModel {
  String? responseCode;
  String? responseMessage;
  List<Queries>? queries;

  RaisedQueryModel({this.responseCode, this.responseMessage, this.queries});

  RaisedQueryModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    if (json['queries'] != null) {
      queries = <Queries>[];
      json['queries'].forEach((v) {
        queries!.add(new Queries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_message'] = this.responseMessage;
    if (this.queries != null) {
      data['queries'] = this.queries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Queries {
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

  Queries(
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
      this.updatedAt});

  Queries.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
