import 'package:latlong2/latlong.dart';

class addres_data {
  addres_data(
      {required this.name,
        required this.latLng,
        required this.id,
        required this.desc});

  late int id;
  late String desc;
  late String name;
  late LatLng latLng;
}
