// lib/api_client.dart

import 'dart:convert';
import './response_models.dart';
import 'package:dio/dio.dart';



class ApiClient {
  final String baseURL;
  final Dio dio;

  ApiClient(this.baseURL, {Dio? dioClient})
      : dio = dioClient ?? Dio(BaseOptions(baseUrl: baseURL)) {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.extra["withCredentials"] = true; 
      return handler.next(options);
    }));
  }

  // Método de ayuda para hacer solicitudes HTTP
  Future<Response> _doFetch(String endpoint, String method, {Map<String, dynamic>? body}) async {
    final options = Options(
      method: method.toUpperCase(),
      headers: body != null ? {'Content-Type': 'application/json'} : null,
    );

    try {
      switch (method.toUpperCase()) {
        case 'GET':
          return await dio.get(endpoint, options: options);
        case 'POST':
          return await dio.post(
            endpoint,
            data: body,
            options: options,
          );
        case 'PUT':
          return await dio.put(
            endpoint,
            data: body,
            options: options,
          );
        case 'DELETE':
          return await dio.delete(endpoint, options: options);
        default:
          throw Exception('Método HTTP no soportado');
      }
    } on DioError catch (e) {
      throw Exception('Error en la solicitud: ${e.message}');
    }
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
    print('$username,$password');
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
      
      var data = response.data;
      if (response.data is String)
        data = json.decode(response.data);

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

      var data = response.data;
      if (response.data is String)
        data = json.decode(response.data);

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
      var data = response.data;
      if (response.data is String)
        data = json.decode(response.data);

      return ResponseChannel.fromJson(data);
    } catch (e) {
      print(e);
      return ResponseChannel();
    }
  }

  Future<List<ResponseChannel>> getUserChannels() async {
    try {
      final response = await _doFetch('/channels/user', 'GET');
      var data = response.data;
      if (response.data is String)
        data = json.decode(response.data);

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
      var data = response.data;
      if (response.data is String)
        data = json.decode(response.data);

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
      var data = response.data;
      if (response.data is String)
        data = json.decode(response.data);

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

  Future<ResponseChannelEvent> getChannelEventByID(String eventID) async {
    try {
      final response = await _doFetch('/events/$eventID', 'GET');
      var data = response.data;
      if (response.data is String)
        data = json.decode(response.data);

      return ResponseChannelEvent.fromJson(data);
    } catch (e) {
      print(e);
      return ResponseChannelEvent();
    }
  }

  Future<List<ResponseChannelEvent>> getChannelCompletedEvents(String channelID) async {
    try {
      final response = await _doFetch('/events/completed/channel/$channelID', 'GET');
      var data = response.data;
      if (response.data is String)
        data = json.decode(response.data);

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
      var data = response.data;
      if (response.data is String)
        data = json.decode(response.data);

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

}

final ApiClient apiClient = ApiClient("https://yaesta-backend.onrender.com");