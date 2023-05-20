import 'dart:convert';

InspectionTask inspectionTaskFromJson(String str) => InspectionTask.fromJson(json.decode(str));

String inspectionTaskToJson(InspectionTask data) => json.encode(data.toJson());

class InspectionTask {
  InspectionTask({
    required this.taskId,
    required this.taskName,
    required this.equipmentId,
    required this.equipmentName,
    required this.stationId,
    required this.stationName,
    required this.address,
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.attachment,
    required this.publishName,
  });

  int taskId;
  String taskName;
  int equipmentId;
  String equipmentName;
  int stationId;
  String stationName;
  String address;
  int startTime;
  int endTime;
  List<Content> content;
  String attachment;
  String publishName;

  factory InspectionTask.fromJson(Map<String, dynamic> json) => InspectionTask(
    taskId: json["taskId"],
    taskName: json["taskName"],
    equipmentId: json["equipmentId"],
    equipmentName: json["equipmentName"],
    stationId: json["stationId"],
    stationName: json["stationName"],
    address: json["address"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    attachment: json["attachment"],
    publishName: json["publishName"],
  );

  Map<String, dynamic> toJson() => {
    "taskId": taskId,
    "taskName": taskName,
    "equipmentId": equipmentId,
    "equipmentName": equipmentName,
    "stationId": stationId,
    "stationName": stationName,
    "address": address,
    "startTime": startTime,
    "endTime": endTime,
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
    "attachment": attachment,
    "publishName": publishName,
  };
}

class Content {
  Content({
    required this.inspectionInfo,
    required this.information,
    this.isTrue,
  });

  String inspectionInfo;
  String information;
  String? isTrue;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    inspectionInfo: json["inspectionInfo"],
    information: json["information"],
    isTrue: json["isTrue"],
  );

  Map<String, dynamic> toJson() => {
    "inspectionInfo": inspectionInfo,
    "information": information,
    "isTrue": isTrue,
  };
}

class Equipment {
  Equipment({
    required this.equipmentId,
    required this.equipmentName,
    required this.type,
  });

  int equipmentId;
  String equipmentName;
  String type;

  factory Equipment.fromJson(Map<String, dynamic> json) => Equipment(
    equipmentId: json["equipmentId"],
    equipmentName: json["equipmentName"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "equipmentId": equipmentId,
    "equipmentName": equipmentName,
    "type": type,
  };
}
