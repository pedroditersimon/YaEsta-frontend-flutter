// lib/api_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import './response_models.dart';

class ApiClient {
  final String baseURL;
  final http.Client httpClient;

  ApiClient(this.baseURL, {http.Client? httpClient})
      : httpClient = httpClient ?? http.Client();

  // Método de ayuda para hacer solicitudes HTTP
  Future<http.Response> _doFetch(String endpoint, String method, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$baseURL$endpoint');
    final request = http.Request(method, uri);

    if (body != null) {
      request.body = json.encode(body);
      request.headers['Content-Type'] = 'application/json';
    }

    final streamedResponse = await httpClient.send(request);
    return await http.Response.fromStream(streamedResponse);
  }

  // Auth
  Future<bool> register({required String username, required String password, required String repeatPassword}) async {
    final body = {
      'username': username,
      'password': password,
      'repeat_password': repeatPassword,
    };

    try {
      final response = await _doFetch('/register', 'POST', body: body);
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({required String username, required String password}) async {
    final body = {
      'username': username,
      'password': password,
    };

    try {
      final response = await _doFetch('/login', 'POST', body: body);
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      final response = await _doFetch('/logout', 'POST');
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<ResponseUser> getLoggedUser() async {
    try {
      final response = await _doFetch('/logged_user', 'GET');
      final data = json.decode(response.body);
      return ResponseUser.fromJson(data);
    } catch (e) {
      print(e);
      return ResponseUser();
    }
  }

  // Channels
  Future<List<ResponseChannel>> getPublicChannels(String channelName) async {
    try {
      final response = await _doFetch('/channels/search/$channelName', 'GET');
      final data = json.decode(response.body);
      if (data is List) {
        return data.map((item) => ResponseChannel.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<ResponseChannel> getChannelByID(String channelID) async {
    try {
      final response = await _doFetch('/channels/$channelID', 'GET');
      final data = json.decode(response.body);
      return ResponseChannel.fromJson(data);
    } catch (e) {
      print(e);
      return ResponseChannel();
    }
  }

  Future<List<ResponseChannel>> getUserChannels() async {
    try {
      final response = await _doFetch('/channels/user', 'GET');
      final data = json.decode(response.body);
      if (data is List) {
        return data.map((item) => ResponseChannel.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<ResponseChannel>> getUserAdminChannels() async {
    try {
      final response = await _doFetch('/channels/user/admin', 'GET');
      final data = json.decode(response.body);
      if (data is List) {
        return data.map((item) => ResponseChannel.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<ResponseChannel> createNewChannel({required String title, bool isPublic = false}) async {
    final body = {
      'channel': {
        'title': title,
        'isPublic': isPublic,
      }
    };

    try {
      final response = await _doFetch('/channels/create', 'POST', body: body);
      final data = json.decode(response.body);
      return ResponseChannel.fromJson(data);
    } catch (e) {
      print(e);
      return ResponseChannel();
    }
  }

  Future<bool> editChannel({required String channelID, String? title, bool? isPublic}) async {
    final body = {
      'channel': {
        '_id': channelID,
        'title': title,
        'isPublic': isPublic,
      }
    };

    try {
      final response = await _doFetch('/channels/edit', 'PUT', body: body);
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteChannel(String channelID) async {
    try {
      final response = await _doFetch('/channels/delete/$channelID', 'DELETE');
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<ResponseChannelEvent>> getChannelEvents(String channelID) async {
    try {
      final response = await _doFetch('/channels/$channelID/events', 'GET');
      final data = json.decode(response.body);
      if (data is List) {
        return data.map((item) => ResponseChannelEvent.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<ResponseChannelEvent> createNewChannelEvent(String channelID, {required String title, String description = "", dynamic mapLocation, String actionDate = "", String reminderDate = "", String reminderStatus = "Pending"}) async {
    final body = {
      'channel_event': {
        'channel_id': channelID,
        'title': title,
        'description': description,
        'map_location': mapLocation,
        'action_date': actionDate,
        'reminder_date': reminderDate,
        'reminder_status': reminderStatus,
      }
    };

    try {
      final response = await _doFetch('/channels/$channelID/events/create', 'POST', body: body);
      final data = json.decode(response.body);
      return ResponseChannelEvent.fromJson(data);
    } catch (e) {
      print(e);
      return ResponseChannelEvent();
    }
  }

  Future<bool> editChannelEvent(String channelID, String eventID, {String? title, String? description, dynamic? mapLocation, String? actionDate, String? reminderDate, String? reminderStatus}) async {
    final body = {
      'channel_event': {
        '_id': eventID,
        'title': title,
        'description': description,
        'map_location': mapLocation,
        'action_date': actionDate,
        'reminder_date': reminderDate,
        'reminder_status': reminderStatus,
      }
    };

    try {
      final response = await _doFetch('/channels/$channelID/events/$eventID/edit', 'PUT', body: body);
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteChannelEvent(String channelID, String eventID) async {
    try {
      final response = await _doFetch('/channels/$channelID/events/$eventID/delete', 'DELETE');
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<ResponseAccessDocument>> getAccessDocuments() async {
    try {
      final response = await _doFetch('/access_documents', 'GET');
      final data = json.decode(response.body);
      if (data is List) {
        return data.map((item) => ResponseAccessDocument.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<ResponseAccessDocument> getAccessDocumentByID(String accessDocumentID) async {
    try {
      final response = await _doFetch('/access_documents/$accessDocumentID', 'GET');
      final data = json.decode(response.body);
      return ResponseAccessDocument.fromJson(data);
    } catch (e) {
      print(e);
      return ResponseAccessDocument();
    }
  }

  Future<bool> createNewAccessDocument({required String actionType, bool enabled = false, bool requiresApproval = false, String targetChannelId = "", String channelTitleTemplate = "New Channel {index}"}) async {
    final body = {
      'access_document': {
        'action_type': actionType,
        'enabled': enabled,
        'requires_approval': requiresApproval,
        'target_channel_id': targetChannelId,
        'channel_title_template': channelTitleTemplate,
      }
    };

    try {
      final response = await _doFetch('/access_documents/create', 'POST', body: body);
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editAccessDocument({required String accessDocumentID, bool? enabled, bool? requiresApproval, String? actionType, String? targetChannelId, String? channelTitleTemplate}) async {
    final body = {
      'access_document': {
        '_id': accessDocumentID,
        'enabled': enabled,
        'requires_approval': requiresApproval,
        'action_type': actionType,
        'target_channel_id': targetChannelId,
        'channel_title_template': channelTitleTemplate,
      }
    };

    try {
      final response = await _doFetch('/access_documents/$accessDocumentID/edit', 'PUT', body: body);
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteAccessDocument(String accessDocumentID) async {
    try {
      final response = await _doFetch('/access_documents/$accessDocumentID/delete', 'DELETE');
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
