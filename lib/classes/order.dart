import 'package:latlong2/latlong.dart';

import 'item.dart';

class Order {
  int order_id;
  String customer;
  String address;
  String? delivery_person = null;
  double? delivery_price = null;
  String? discount;
  double? discount_value;
  double total_price;
  String status;
  String store_name;
  String store_address;
  bool fast;
  LatLng origin;
  LatLng goal;
  List<Item> items = [];

  Order({
    required this.address,
    required this.order_id,
    required this.customer,
    required this.origin,
    required this.goal,
    required this.total_price,
    required this.discount_value,
    required this.discount,
    required this.items,
    required this.store_address,
    required this.status,
    required this.store_name,
    required this.fast
  });
}
