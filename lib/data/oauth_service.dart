import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class OauthService {
  // static const String uid = "API_42_UID_APP";
  // static const secret = "API_42_SECRET";

  var  uid = dotenv.env['API_42_UID_APP']!;
  var  secret = dotenv.env['API_42_SECRET']!;

  static const baseUrl42 = "https://api.intra.42.fr";
  String token = "";

  Future<String> getToken() async {
    if (await checkToken(token) == false) {
      try {
        print("secret = $secret");
        final response =
            await http.post(Uri.parse("$baseUrl42/oauth/token"), body: {
          "grant_type": "client_credentials",
          "client_id":
          uid,
          "client_secret":
          secret
        });
        print("response : $response");
        print(response.statusCode);
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          token = jsonResponse["access_token"] as String;
        } else {
          getToken();
        }
      } catch (e) {
        getToken();
      }
    }
    return token;
  }

  Future<bool> checkToken(String token) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl42/oauth/token/info"),
          headers: {"Authorization": "Bearer $token"});
      print(json.decode(response.body));
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      print("errorcheck : $e");
    }
    return false;
  }

  Future<dynamic> fetchUser(String username) async {
    await getToken();
    try {
      final response = await http.get(
          Uri.parse("$baseUrl42/v2/users/$username"),
          headers: {"Authorization": "Bearer ${token}"});
      print(response.statusCode);
      print("response body : ${response.body}");
      if (response.statusCode == 200) return json.decode(response.body);
    } catch (e) {
      print("error fetchUser : $e");
    }
    return null;
  }
}
