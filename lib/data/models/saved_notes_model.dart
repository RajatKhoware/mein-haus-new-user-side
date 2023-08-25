import 'ongoing_project_model.dart';

class SavedNotesModel {
  String? responseCode;
  String? responseMessage;
  String? estimateId;
  List<Notes>? notes;

  SavedNotesModel(
      {this.responseCode, this.responseMessage, this.estimateId, this.notes});

  SavedNotesModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    estimateId = json['estimate_id'];
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes!.add(new Notes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_message'] = this.responseMessage;
    data['estimate_id'] = this.estimateId;
    if (this.notes != null) {
      data['notes'] = this.notes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notes {
  int? id;
  String? note;
  bool? type;
  List<ProjectImages>? images;

  Notes({
    this.id,
    this.note,
    this.type,
    this.images,
  });

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    type = json['type'];
    if (json['images'] != null) {
      images = <ProjectImages>[];
      json['images'].forEach((v) {
        images!.add(new ProjectImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    data['type'] = this.type;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
