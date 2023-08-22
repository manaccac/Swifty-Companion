import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class OauthService {
  static const String uid = "API_42_UID_APP";
  static const secret = "API_42_SECRET";
  static const baseUrl42 = "https://api.intra.42.fr";
  String token = "";

  Future<String> getToken() async {
    if (await checkToken(token) == false) {
      try {
        final response =
            await http.post(Uri.parse("$baseUrl42/oauth/token"), body: {
          "grant_type": "client_credentials",
          "client_id":
              "0100f227c904173b079b2d777cd47b652148d25682596e2edb413cb0811762bf",
          "client_secret":
              "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"
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
