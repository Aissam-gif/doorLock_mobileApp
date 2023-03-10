import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:iot_project/constaints.dart';
import 'package:iot_project/models/user_model.dart';
import 'package:iot_project/pages/loginPage.dart';

class AuthenticationProvider {
  static String? _token;
  static UserModel? _user;

  static String? get token => _token;

  static UserModel? get user => _user;

  bool get isAuthenticated => _token != null;

  static void setUser(UserModel user) {
    _user = user;
  }

  Future<String?> login(String username, String password) async {
    // Make the authentication request and store the token
    try {
      dynamic response = await makeAuthenticationRequest(username, password);
      _token = response['token'];
      print('_token = ' + _token!);
    } on Exception catch (_) {
      return null;
    }
    return _token;
  }

  Future<String?> mockLogin(String username, String password) async {
    // Make the authentication request and store the token
    try {
      dynamic response =
          await makeMockAuthenticationRequest(username, password);
      _token = response['token'];
      print('_token = ' + _token!);
    } on Exception catch (_) {
      return null;
    }
    return _token;
  }

  setToken(String token) {
    _token = token;
  }

  Future<dynamic> makeAuthenticationRequest(
      String username, String password) async {
    final response = await http.post(
      Uri.parse(server + 'login'),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
          <String, String>{"username": username, "password": password}),
    );
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      final responseResult = jsonDecode(response.body);
      print(responseResult);
      await storage.write(key: 'jwt', value: responseResult['token']);
      return await responseResult;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> makeMockAuthenticationRequest(
      String username, String password) async {
    final response = await http.get(
        Uri.parse('https://mocki.io/v1/e8a9e8f6-6fe3-472c-bdee-e931851e9ac8'),
        headers: <String, String>{
          "Content-Type": "application/json",
        });

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      final responseResult = jsonDecode(response.body);
      await storage.write(key: 'jwt', value: responseResult['token']);
      return await responseResult;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load album');
    }
  }

  static Future<dynamic> getApiRequest(String url, Map jsonMap) async {
    final response = await http.get(Uri.parse(server + url), headers: {
      'Authorization': 'Bearer ' + _token!,
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      dynamic data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<dynamic> getMockApiRequest(String url, Map jsonMap) async {
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer ${await storage.read(key: 'jwt').toString()}',
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      dynamic data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<String> putApiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  static Future<UserModel> updateUser(UserModel userModel) async {
    final response = await http.put(
      Uri.parse(server + 'update/' + userModel.id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}',
      },
      body: jsonEncode(<String, dynamic>{
        'id': userModel.id.toString(),
        'username': userModel.username.toString(),
        'role': userModel.role.toString(),
        'allowed': userModel.allowed,
        'password': userModel.password
      }),
    );
    print(jsonDecode(response.body).toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update User.');
    }
  }

  void logout() {
    // Clear the stored token
    _token = null;
  }
}
