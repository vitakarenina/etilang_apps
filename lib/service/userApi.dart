import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:etilang_apps/models/user.dart';

class UserApi {
  //Get all User Details
  Future<List<User>> getAllUsers() async {
    var client = http.Client();
    //http://127.0.0.1:5000/user
    var uri = Uri.parse("http://192.168.208.106:5000/api/user");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return userFromJson(json);
    }
  }

  //Add New User
  Future<User> addUser(String password, String email) async {
    var client = http.Client();
    var uri = Uri.parse("http://192.168.208.106:5000/api/user");
    final http.Response response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'password': password, 'email': email}),
    );
    if (response.statusCode == 200) {
      var json = response.body;
      return User.fromJson(jsonDecode(json));
    } else {
      throw Exception('Gagal Menyimpan Data User.');
    }
  }

  //Delete User
  Future<User> deleteUSer(int id) async {
    var client = http.Client();
    var uri = Uri.parse("http://192.168.208.106:5000/api/user/$id");
    final http.Response response =
        await client.delete(uri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      var json = response.body;
      return User.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to Delete User.');
    }
  }

  //Update User
  Future<User> updateUser(String password, String email, int id) async {
    var client = http.Client();
    var uri = Uri.parse("http://192.168.208.106:5000/user_table/$id");
    final http.Response response = await client.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'password': password, 'email': email}),
    );
    if (response.statusCode == 200) {
      var json = response.body;
      return User.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to Update User.');
    }
  }
}
