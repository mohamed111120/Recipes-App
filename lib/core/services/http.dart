import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

Future<void> getAccessToken() async {
  try {
    final serviceAccountJson = await rootBundle.loadString(
        'assets/food-recipes-dc442-firebase-adminsdk-ekure-d8eaf226fa.json');

    final accountCredentials = ServiceAccountCredentials.fromJson(
      json.decode(serviceAccountJson),
    );

    const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client = http.Client();
    try {
      final accessCredentials = await obtainAccessCredentialsViaServiceAccount(
        accountCredentials,
        scopes,
        client,
      );

      final accessToken = accessCredentials.accessToken.data;

      print('Access Token: $accessToken');
    } catch (e) {
      print('Error obtaining access token: $e');
    } finally {
      client.close();
    }
  } catch (e) {
    print('Error loading service account JSON: $e');
  }
}
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------

Future<void> sendNotificationToDevice(
  String targetToken, {
  String? title,
  String? body,
}) async {
  const String serverKey =
      'ya29.c.c0ASRK0GYlu3jUFd6TfMdNI-58R_Z7kL-nXmX-G882N24xXdsTcu0gtzscbTw7CzkSMAwZJxrAotbMeh6SQjaqrBuT81ntSFAQqMh2ADSmgFKDKSDgezHLRoL7IzIXWWtN_JDaKE1n_3eRj709ifmRL_60rEBUBBfO7x3fVpnuD3F19eB4biNn3hRYjo9Q4r-v8IhOsJ6uqc9v1HWowzYBuhF9Yw72XWp7gA4kVdzlsIlII9D_alKoyJYjhghTyhct2-FHuM5HsjwcC39BLpju9Tql5dNF5-UoVYYUmd9x-F6GlqEho5pgfCB4DHKeWsP7HwBS2mywqRu3EI77shwB1M5xK8kZJHeAxOGTkZdHOQTQEMldnspq6sSzYwG387AcbBY25UgXY0XpfnixR4YlZqYy4nyxprhRe2e3O9_swexI2lil-Y6k0jhr5dJJhaX6ppaUb5Vpwu9MXWM3r5c9YlBB7xb8ptF3l73pRJ8pj4bOwYicb64YVXb7JFVVuMQ2VtOohf6-f67nv7jsboYiQ-Suw3Q89m2XF0u5vfIdx23QazcSymIaQft1OaaSZtY0p6ofnQtSS8Myd1Rxld2tkXp3F459MaMsB-20rtwaxdksc3XoO8lIgQ8zq-90ZthgfcSeZyV_rm1eM2F31IfpUgj3_g-RB51-l3Fo2o0UR95M41U77F3R8tUsha2YYwugic6ebe7-Jl_ZWIs9MuyBIMcoWBSi41ZY3arqk4Wh6lJUUx6pll1R3i33lnc9u6dlu3Fl754FF8-ZozanvU05k1IXiF_mdBmU-O9qeskdrXzlI9bfJR0h3F-1jiIdRQ4YqdVV-Uyw8V0rovqO2-2Ik6FIZoaSlyah3bwmfI8xVmbsVwMZIpg3sBItYVzOcI_64RYbJjc84mSpI7yd03903a_tQvZ3v1ikbmVOUla9ZixMSOdSweQbSexx6F6Ulefr-vorRJJa1qn92Mpi8l_rvyBgISuy97oMSYMbhzRd'; // Replace with your Firebase Server Key
  String fcmUrl =
      'https://fcm.googleapis.com/v1/projects/food-recipes-dc442/messages:send';

  // Notification payload
  final notificationPayload = {
    "message": {
      "token": targetToken,
      "notification": {
        "title": title ?? 'Message Title',
        "body": body ?? 'Message Body',
      },
    }
  };

  try {
    final response = await http.post(
      Uri.parse(fcmUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey', // Firebase server key
      },
      body: jsonEncode(notificationPayload), // Encoding the payload to JSON
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification: ${response.body}');
    }
  } catch (e) {
    print('Error sending notification: $e');
  }
}
