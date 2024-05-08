import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


// var url ='http://10.0.2.2:8000';
var url ='http://192.168.1.3:8000';
var token = "";
Future<Map<String, dynamic>> postRequest(Map<String, dynamic> data, String endpoint) async {
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url + endpoint),
      headers: {"Content-Type": "application/json"},
      body: body
  );

  // Check if the response status code is OK (200)
  if (response.statusCode == 200) {
    // Parse the response body from JSON to Map
    Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    return responseData;
  } else {
    // If the response status code is not OK, throw an error or handle it accordingly
    throw Exception('Failed to post data: ${response.statusCode}');
  }
}
