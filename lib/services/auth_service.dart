import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

//identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]
class AuthService extends ChangeNotifier {
  final String _baseurl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyBzZmbNYqY-MtsplKy7lVzzDLbs9q-jYLA';

  final storage = new FlutterSecureStorage();

  Future<String?> crearUsuario(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url =
        Uri.https(_baseurl, 'v1/accounts:signUp', {'key': _firebaseToken});

    final respuesta = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> respuestaDecodificada =
        jsonDecode(respuesta.body);

    if (respuestaDecodificada.containsKey('idToken')) {
      //hay que guardar el token
      // return respuestaDecodificada['idToken'];
      await storage.write(
          key: 'token', value: respuestaDecodificada['idToken']);
      return null;
    } else {
      return respuestaDecodificada['error']['message'];
    }
  }

  Future<String?> LoginUsuario(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(
        _baseurl, 'v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final respuesta = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> respuestaDecodificada =
        jsonDecode(respuesta.body);

    if (respuestaDecodificada.containsKey('idToken')) {
      //hay que guardar el token
      // return respuestaDecodificada['idToken'];
      await storage.write(
          key: 'idToken', value: respuestaDecodificada['idToken']);
      return null;
    } else {
      return respuestaDecodificada['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'idToken');
    return;
  }

  Future<String> leerToken() async {
    return await storage.read(key: 'idToken') ?? '';
  }
}
