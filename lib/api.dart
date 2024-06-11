import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dios;

class Api {
  Client apiClient = Client();
  final String apiUrl = 'http://api-pmobile.test/api/v1'; //dev

  Future<Map<String, dynamic>> registrasi(
      {required String nim,
      required String nama,
      required String email,
      required String password}) async {
    final response = await apiClient.post(
      Uri.parse("$apiUrl/registrasi"),
      body: {'nim': nim, 'nama': nama, 'email': email, 'password': password},
    );
    if (response.statusCode == 201) {
      //return ketika sukses
      return json.decode(response.body);
    } else {
      //return error ketika gagal/server error
      throw Exception(json.decode(response.body));
    }
  }

  Future<Map<String, dynamic>> login(
      {required String nim, required String password}) async {
    final response = await apiClient.post(
      Uri.parse("$apiUrl/login"),
      body: {'nim': nim, 'password': password},
    );
    if (response.statusCode == 200) {
      //return ketika sukses
      return json.decode(response.body);
    } else {
      //return error ketika gagal/server error
      throw Exception(json.decode(response.body));
    }
  }

  Future<Map<String, dynamic>> getUserByNim() async {
    SharedPreferences sessionLogin = await SharedPreferences.getInstance();

    final body = jsonEncode({
      "nim": sessionLogin.getString('nim'),
    });

    final response = await apiClient
        .post(Uri.parse('$apiUrl/get-user-by-nim'), body: body, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${sessionLogin.getString('token')}',
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(json.decode(response.body));
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    required String id,
    required String nim,
    required String nama,
    required String email,
    required String jurusan,
    required String alamat,
    required String tglLahir,
  }) async {
    SharedPreferences sessionLogin = await SharedPreferences.getInstance();
    final body = jsonEncode({
      "nim": nim,
      "nama": nama,
      "email": email,
      "jurusan": jurusan,
      "alamat": alamat,
      "tgl_lahir": tglLahir
    });
    final response = await apiClient
        .put(Uri.parse('$apiUrl/update-profile/$id'), body: body, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${sessionLogin.getString('token')}',
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(json.decode(response.body));
    }
  }

  Future<void> updateProfileDio({
    required String id,
    required String foto,
    required String nim,
    required String nama,
    required String email,
    required String jurusan,
    required String alamat,
    required String tglLahir,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    dios.FormData dataUpload = dios.FormData.fromMap({
      "foto": await dios.MultipartFile.fromFile(
        foto,
      ),
      "nim": nim,
      "nama": nama,
      "email": email,
      "jurusan": jurusan,
      "alamat": alamat,
      "tgl_lahir": tglLahir
    });
    dios.Dio dio = dios.Dio();
    var response = await dio.post(
      '$apiUrl/update-profile/$id',
      data: dataUpload,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    print(response);
  }
}
