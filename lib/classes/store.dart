import 'comment.dart';
import 'item.dart';

class Store {
  late String id;
  late String name;
  late double longitude;
  late double latitude;
  double rate;
  late List<Item> items;
  List<Comment> comments = [];
  String image = "";
  Store(
      {required this.id,
      required this.name,
        required this.longitude,
        required this.rate,
      required this.latitude,
        required this.image,
      List<Item>? items})
      : items = items ?? [];
}


