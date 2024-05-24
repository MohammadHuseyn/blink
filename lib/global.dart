import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:blink/pages/Address.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'classes/item.dart';

// var url ='http://10.0.2.2:8000';
// var url ='http://192.168.1.3:8000';
var url ='http://62.60.205.58:8001';
// var url ='http://172.20.174.125:8000';
// var url ='http://localhost:8000';
List<addres_data> addresses = [];
var s = null;
var token = "";
var currentCardPayement = false;
var tokenbool = false;
var sum = 0.0;
bool currentley_running_order = false;
var username = "username";
var userkind = "";
var storeName = "باغ گیلاس";
var store_id = "";
// var order_id;
var order_id;
var first_name = "محسین";
String profile_imge = "";
var phone_number = "09156130018";
var last_name = "امینی";
var email = "mahsein@mail.com";
// var address_name = "آدرس ۱";
var addressIndex = null;
List<Item> card = [];


String toPersianNumbers(double number) {
  // Define the Persian numerals
  const List<String> persianNumerals = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  // Convert the number to string, removing the decimal part
  String numberStr = number.toStringAsFixed(0);

  // Convert the string to Persian numerals
  StringBuffer persianNumberStr = StringBuffer();

  for (int i = 0; i < numberStr.length; i++) {
    String char = numberStr[i];
    if (char == '-') {
      persianNumberStr.write('-'); // Keep the negative sign as is
    } else {
      int? digit = int.tryParse(char);
      if (digit != null) {
        persianNumberStr.write(persianNumerals[digit]);
      } else {
        persianNumberStr.write(char); // Keep any other characters as is
      }
    }
  }

  // Convert StringBuffer to String
  String persianNumberString = persianNumberStr.toString();

  // Add Persian commas
  StringBuffer formattedPersianNumberStr = StringBuffer();
  int counter = 0;

  for (int i = persianNumberString.length - 1; i >= 0; i--) {
    formattedPersianNumberStr.write(persianNumberString[i]);
    counter++;
    if (counter == 3 && i != 0 && persianNumberString[i - 1] != '-') {
      formattedPersianNumberStr.write('٬'); // Persian comma
      counter = 0;
    }
  }

  return formattedPersianNumberStr.toString().split('').reversed.join('');
}


void toast(context, String txt) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text("txt"),
  ));
}


var headerA = {"Content-Type": "application/json; charset=UTF-8", "Authorization": 'Token $token'};
var header = {"Content-Type": "application/json; charset=UTF-8"};
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
    List<dynamic> responseDataList = json.decode(utf8.decode(response.bodyBytes));

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
Future<Map<String, dynamic>> getRequestmap(String endpoint) async {
  var response = await http.get(
    Uri.parse(url + endpoint),
    headers: tokenbool ? headerA : header,
  );

  // Check if the response status code is OK (200)
  if (response.statusCode == 200) {
    // Parse the response body from JSON to Map<String, dynamic>
    Map<String, dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));

    // Ensure that the response is indeed a Map
    if (responseData is Map<String, dynamic>) {
      print(responseData);
      return responseData;
    } else {
      // If the response is not a Map, handle the error accordingly
      throw Exception('Unexpected response format: ${response.body}');
    }
  } else {
    // If the response status code is not OK, throw an error or handle it accordingly
    throw Exception('Failed to get data: ${response.statusCode}');
  }
}
Future<Map<String, dynamic>> putRequest(dynamic data, String endpoint) async {
  // Encode Map to JSON
  var body = json.encode(data);

  // Send PUT request
  var response = await http.put(
    Uri.parse(url + endpoint),
    headers: tokenbool ? headerA : header,
    body: body,
  );

  // Check if the response status code is OK (200) or Created (201)
  if (response.statusCode == 200 || response.statusCode == 201) {
    // Parse the response body from JSON to Map
    Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    return responseData;
  } else {
    // If the response status code is not OK, throw an error or handle it accordingly
    throw Exception('Failed to put data: ${response.statusCode}');
  }
}


