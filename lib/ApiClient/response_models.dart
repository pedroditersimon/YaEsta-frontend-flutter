// lib/models/response_models.dart

import 'dart:convert';

// Clase ResponseUser
class ResponseUser {
  String id;
  String username;

  ResponseUser({this.id = "", this.username = ""});

  ResponseUser.fromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? "",
        username = json['username'] ?? "";

  Map<String, dynamic> toJson() => {
        '_id': id,
        'username': username,
      };

  bool isValid() => id.isNotEmpty;
}

// Clase ResponseChannel
class ResponseChannel {
  String id;
  String title;
  String creationDate;
  bool isPublic;
  int membersCount;

  ResponseChannel({
    this.id = "",
    this.title = "",
    this.creationDate = "",
    this.isPublic = false,
    this.membersCount = 0,
  });

  ResponseChannel.fromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? "",
        title = json['title'] ?? "",
        creationDate = json['creation_date'] ?? "",
        isPublic = json['isPublic'] ?? false,
        membersCount = json['membersCount'] ?? 0;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'creation_date': creationDate,
        'isPublic': isPublic,
        'membersCount': membersCount,
      };

  bool isValid() => id.isNotEmpty;
}

// Clase ResponseChannelEvent
class ResponseChannelEvent {
  String id;
  String channelId;
  String creationDate;
  String status;
  String actionDate;
  String reminderStatus;
  String reminderDate;
  String title;
  String description;
  dynamic mapLocation;

  ResponseChannelEvent({
    this.id = "",
    this.channelId = "",
    this.creationDate = "",
    this.status = "",
    this.actionDate = "",
    this.reminderStatus = "",
    this.reminderDate = "",
    this.title = "",
    this.description = "",
    this.mapLocation,
  });

  ResponseChannelEvent.fromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? "",
        channelId = json['channel_id'] ?? "",
        creationDate = json['creation_date'] ?? "",
        status = json['status'] ?? "",
        actionDate = json['action_date'] ?? "",
        reminderStatus = json['reminder_status'] ?? "",
        reminderDate = json['reminder_date'] ?? "",
        title = json['title'] ?? "",
        description = json['description'] ?? "",
        mapLocation = json['map_location'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'channel_id': channelId,
        'creation_date': creationDate,
        'status': status,
        'action_date': actionDate,
        'reminder_status': reminderStatus,
        'reminder_date': reminderDate,
        'title': title,
        'description': description,
        'map_location': mapLocation,
      };

  bool isValid() => id.isNotEmpty;
}

// Clase ResponseAccessDocument
class ResponseAccessDocument {
  String id;
  String creationDate;
  bool enabled;
  bool requiresApproval;
  String actionType;
  String targetChannelId;
  String channelTitleTemplate;

  ResponseAccessDocument({
    this.id = "",
    this.creationDate = "",
    this.enabled = false,
    this.requiresApproval = false,
    this.actionType = "",
    this.targetChannelId = "",
    this.channelTitleTemplate = "New Channel {index}",
  });

  ResponseAccessDocument.fromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? "",
        creationDate = json['creation_date'] ?? "",
        enabled = json['enabled'] ?? false,
        requiresApproval = json['requires_approval'] ?? false,
        actionType = json['action_type'] ?? "",
        targetChannelId = json['target_channel_id'] ?? "",
        channelTitleTemplate = json['channel_title_template'] ?? "New Channel {index}";

  Map<String, dynamic> toJson() => {
        '_id': id,
        'creation_date': creationDate,
        'enabled': enabled,
        'requires_approval': requiresApproval,
        'action_type': actionType,
        'target_channel_id': targetChannelId,
        'channel_title_template': channelTitleTemplate,
      };

  bool isValid() => id.isNotEmpty;
}
