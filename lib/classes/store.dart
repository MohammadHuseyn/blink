class Store {
  late String id;
  late String name;
  late double longitude;
  late double latitude;
  late List<Item> items;
  Store({required this.id, required this.name, required this.longitude, required this.latitude, List<Item>? items})
      : items = items ?? [];


}

class Item {
  int count = 1;
  late String sotreid;
  late String id;
  late String name;
  late String price;
  Item({required this.sotreid, required this.id, required this.name, required this.price});

}