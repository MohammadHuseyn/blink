import 'dart:async';
import 'dart:convert';
import 'package:blink/classes/store.dart';
import 'package:blink/pages/Address.dart';
import 'package:http/http.dart' as http;
// import 'classes/store.dart';

// var url ='http://10.0.2.2:8000';
// var url ='http://192.168.1.3:8000';
var url ='http://192.168.23.31:8000';
List<addres_data> addresses = [];
var s = null;
var token = "";
var currentCardPayement = false;
var tokenbool = false;
var username;
var order_id;
var first_name;
var last_name;
var address_name = "آدرس ۱";
var addressIndex = null;
List<Item> card = [];
var headerA = {"Content-Type": "application/json", "Authorization": 'Token $token'};
var header = {"Content-Type": "application/json"};
Future<Map<String, dynamic>> postRequest(dynamic data, String endpoint) async {
  //encode Map to JSON
  var body = json.encode(data);
  var response = await http.post(Uri.parse(url + endpoint),
      headers: tokenbool? headerA:header,
      body: body
  );

  // Check if the response status code is OK (200)
  if (response.statusCode == 200 || response.statusCode == 201) {
    // Parse the response body from JSON to Map
    Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    return responseData;
  } else {
    // If the response status code is not OK, throw an error or handle it accordingly
    throw Exception('Failed to post data: ${response.statusCode}');
  }
}
Future<List<Map<String, dynamic>>> getRequest(String endpoint) async {
  var response = await http.get(Uri.parse(url + endpoint), headers: tokenbool ? headerA : header);

  // Check if the response status code is OK (200)
  if (response.statusCode == 200) {
    // Parse the response body from JSON to List<Map<String, dynamic>>
    List<dynamic> responseDataList = json.decode(response.body);

    // Convert the List<dynamic> to List<Map<String, dynamic>>
    List<Map<String, dynamic>> responseData = [];
    for (var item in responseDataList) {
      if (item is Map<String, dynamic>) {
        responseData.add(item);
      }
    }

    print(responseData);
    return responseData;
  } else {
    // If the response status code is not OK, throw an error or handle it accordingly
    throw Exception('Failed to get data: ${response.statusCode}');
  }
}
