import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


var url ='http://10.0.2.2:8000';

Future<http.Response> postRequest (Map data) async {

  // Map data = {
  //   'username' : 'checkuser',
  //   'password' : 'checkpass'
  // };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  print("${response.statusCode}");
  print("${response.body}");
  return response;
}