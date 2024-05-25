import 'dart:convert';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:blink/pages/ProductComment.dart';
import 'package:blink/pages/StoreComment.dart';
import 'package:flutter/material.dart';
import '../classes/item.dart';
import '../global.dart' as global;
import '../classes/store.dart';

class StorePage extends StatefulWidget {
  StorePage({required this.store});

  Store store;

  @override
  State<StorePage> createState() => _StorePageState(store: store);
}

class _StorePageState extends State<StorePage> {
// committing
  Store store;
  bool got_data = false;
  var search = TextEditingController();
  _StorePageState({required this.store});

  @override
  void initState() {
    // uncomment the below line / debug
    _load_items(store: store, filter: "");
    // comment the below line / debug
    // got_data = true;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEAF3EE),
      // backgroundColor:,
        // backgroundColor: Image.memory(
        //   width: 100,
        //   Uint8List.fromList(
        //       base64Decode(global.profile_imge)),
        //   fit: BoxFit.contain, // Adjust the fit as needed
        // ),
        body: Stack(
          children: [
            PreferredSize(
                preferredSize: const Size.fromHeight(150.0),
                child: Container(
                  color: const Color(0xFFEAF3EE),
                  // color: Colors.red,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: store.image == ""
                      ? const ImageIcon(
                    AssetImage("images/shop.png"),
                    size: 250,
                    color: Color(0xFF949494),
                  )
                      : ClipRRect(
                    // borderRadius: BorderRadius.circular(75),
                    // Same radius as the CircleAvatar
                    child: Image.memory(
                      width: 200,
                      Uint8List.fromList(
                          base64Decode(store.image)),
                      fit: BoxFit.fitWidth, // Adjust the fit as needed
                    ),
                  ),
                )),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 170,),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 0),
                                blurRadius: 7,
                                spreadRadius: 1)
                          ]
                          // border: Border.all(color: Colors.black)
                          ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                        child: Column(
                          children: [
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star_rate_rounded,
                                  size: 32,
                                  color: Color(0xFF256f46),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    global.toPersianNumbers(store.rate) + "/۵",
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  store.name,
                                  style: const TextStyle(
                                      fontSize: 25, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) => StoreComment(
                                                    store: store,
                                                  )));
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.arrow_back_ios_rounded),
                                        Text(
                                          "مشاهده نظرات",
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  const Text(
                                    "  آدرس انتخاب شده",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const ImageIcon(
                                    AssetImage("images/location.png"),
                                    color: Color(0xFF97b9a7),
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 15),
                              child: TextField(
                                controller: search,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 25),
                                onChanged: (changed) {
                                  _load_items(store: store, filter: changed);
                                },
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.search_rounded,
                                      size: 35,
                                      color: Color(0xFF2E8B57),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF2E8B57), width: 2.0)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF2E8B57), width: 2.0))),
                              ),
                            ),
                            !got_data? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    backgroundColor: Colors.lightGreen,
                                    color: Color(0xFF256F46),
                                    strokeWidth: 5,
                                    strokeAlign: 2,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "در حال دریافت محصولات",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 30, color: Color(0xFF256F46)),
                                  ),
                                ],
                              ),
                            ): ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: store.items.length,
                                itemBuilder: (cntx, i) {
                                  if (i != 0) i++;
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      i < store.items.length
                                          ? prodcut(store.items[i++])
                                          : Container(),
                                      i < store.items.length
                                          ? prodcut(store.items[i++])
                                          : Container(),
                                    ],
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
    // return Scaffold(
    //   body: ListView.builder(
    //       itemCount: store.items.length,
    //       itemBuilder: (context, i){
    //     return ListTile(
    //       title: Text(store.items[i].name),
    //       onTap: () {
    //         if (!global.currentCardPayement) {
    //           if (global.s == null)
    //             global.s = store;
    //           else if (global.s!.id != store.id) {
    //             global.card.removeRange(0, global.card.length - 1);
    //             global.s = store;
    //           }
    //           global.card.add(store.items[i]);
    //         }
    //       },
    //     );
    //   }),
    // );
  }

  prodcut(Item item) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
      child: GestureDetector(
        onTap: () {
          bottomShett(item);
        },
        child: Container(
          // width: MediaQuery.of(context).size.width * 0.39,
          // width: 140,
          // height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 11), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                item.image == ""
                    ? const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ImageIcon(
                      AssetImage("images/product.png",),
                      color: Color(0xFF517360),
                      size: 80,
                    ),
                ) : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15), // Same radius as the CircleAvatar
                    child: Image.memory(
                      width: 100,
                      Uint8List.fromList(
                          base64Decode(item.image)),
                      fit: BoxFit
                          .cover, // Adjust the fit as needed
                    ),
                  ),
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                //   child:
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: global.card.any((element) => element.id == item.id)?
                      Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      global.card.elementAt(global.card.indexOf(item)).count -= 1;
                                    });
                                    if (global.card.elementAt(global.card.indexOf(item)).count == 0) {
                                      _remove_from_cart(item);
                                    }
                                    global.sum += item.price;

                                  },
                                  icon: const ImageIcon(
                                      AssetImage(
                                        "images/remove.png",
                                      ),
                                      color: Colors.red
                                      // color: Colors.black,
                                      )),
                              // Expanded(child: Container()),
                              Text(
                                  global.card.any((element) => element.id == item.id)? global.card.elementAt(global.card.indexWhere((element) => element.id == item.id)).count.toString() : "0",
                                style: const TextStyle(fontSize: 20),
                              ),
                              // Expanded(child: Container()),
                              IconButton(
                                  onPressed: () {

                                    setState(() {
                                      global.card.elementAt(global.card.indexWhere((element) => element.id == item.id)).count += 1;
                                    });
                                    global.store_id = store.id;
                                    global.sum += item.price;
                                  },
                                  icon: const ImageIcon(
                                    AssetImage("images/plus.png"),
                                    color: Color(0xFF2E8B57),
                                  ))
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: IconButton(
                              onPressed: () {
                                // if (!global.card.contains(item))
                                setState(() {
                                  _add_to_cart(item);
                                  global.card.elementAt(global.card.indexWhere((element) => element.id == item.id)).count += 1;
                                });
                                global.store_id = store.id;
                                global.sum += item.price;
                              },
                              icon: const ImageIcon(AssetImage("images/plus.png"),
                                  color: Color(0xFF2E8B57))),
                        ),
                ),
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 23),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Expanded(child: Container()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          global.toPersianNumbers(item.price),
                          style: const TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        ),
                        Text(
                          global.toPersianNumbers(item.price),
                          style: const TextStyle(fontSize: 23),
                        ),
                      ],
                    ),
                    // Expanded(child: Container()),
                    const Text(
                      "0%",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                      textAlign: TextAlign.right,
                    ),
                    // Expanded(child: Container()),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _add_to_cart(Item item) {
    setState(() {
      global.card.add(item);
    });
  }

  void _remove_from_cart(Item item) {
    setState(() {
      global.card.remove(item);
    });
  }

  void bottomShett(Item item) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return DraggableScrollableSheet(
          // initialChildSize: 0.8,
          // minChildSize: 0.1,
          // maxChildSize: 1,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return StatefulBuilder(
              builder: (context, StateSetter setState) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            width: 100,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(75)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: const Color(0xFFEAF3EE)
                                // color: Colors.red
                              ),
                              child: item.image == ""? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 35),
                                child: ImageIcon(
                                  AssetImage("images/product.png"),
                                  color: Color(0xFF5E846E),
                                  size: 95,
                                ),
                              ): ClipRRect(
                                borderRadius: BorderRadius.circular(15), // Same radius as the CircleAvatar
                                child: Image.memory(
                                  width: 100,
                                  Uint8List.fromList(
                                      base64Decode(item.image)),
                                  fit: BoxFit
                                      .fitWidth, // Adjust the fit as needed
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                size: 32,
                                color: Color(0xFF256f46),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  item.rate.toString() + "/5",
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              Expanded(child: Container()),
                              Text(
                                item.name,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              GestureDetector(
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.arrow_back_ios_rounded)),
                                    const Text(
                                      "مشاهده نظرات",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => ProductComment(item: item,)));
                                },
                              ),
                              Expanded(child: Container()),
                              Text(
                                store.name,
                                style: const TextStyle(fontSize: 20),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: ImageIcon(
                                  AssetImage("images/shop.png"),
                                  size: 50,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                              boxShadow: [
                                const BoxShadow(
                                    color: Color(0xFF518C6B),
                                    spreadRadius: 0,
                                    blurRadius: 0,
                                    offset: Offset(0, -2)),
                                const BoxShadow(
                                    color: Color(0xFF518C6B),
                                    spreadRadius: 0,
                                    blurRadius: 0,
                                    offset: Offset(0, 2))
                              ],
                              color: Colors.white,
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(35)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 25),
                            child: Text(
                              item.desc,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 35, right: 35, top: 20),
                          child: Row(children: [
                            const Text("تومان ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 22,
                                    fontFamily: 'shabnam')),
                            Text(item.price.toString(),
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'shabnam',
                                    color: Colors.black)),
                            Expanded(child: Container()),
                            item.count > 0
                                ? Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          item.count -= 1;
                                        });
                                        if (item.count == 0) {
                                          _remove_from_cart(item);
                                        }
                                        global.sum -= item.price;

                                      },
                                      icon: const ImageIcon(
                                          AssetImage(
                                            "images/remove.png",
                                          ),
                                          color: Colors.red
                                        // color: Colors.black,
                                      )),
                                  // Expanded(child: Container()),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      item.count.toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  // Expanded(child: Container()),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          global.card.elementAt(global.card.indexWhere((element) => element.id == item.id)).count += 1;
                                        });
                                        global.store_id = store.id;
                                      },
                                      icon: const ImageIcon(
                                        AssetImage("images/plus.png"),
                                        color: Color(0xFF2E8B57),
                                      ))
                                ],
                              ),
                            )
                                : SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      item.count += 1;
                                      _add_to_cart(item);
                                    });
                                  },
                                  child: const Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      "  افزودن  ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF256F46)),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateColor.resolveWith(
                                              (states) => Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(18.0),
                                              side: const BorderSide(
                                                  color: Color(0xFF256F46),
                                                  width: 2))))),
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void add_count(Item item) {
    setState(() {
      item.count += 1;
    });
  }

  void minus_count(Item item) {
    setState(() {
      item.count -= 1;
    });
  }
  img.Pixel getBackgroundColor(img.Image image) {
    // Sample a pixel from a corner, assuming it's representative of the background
    return image.getPixel(0, 0); // Top-left corner
  }

  String pixelToHex(img.Pixel pixel) {
    final r = _toHex(pixel.r.toInt());
    final g = _toHex(pixel.g.toInt());
    final b = _toHex(pixel.b.toInt());
    return '#$r$g$b';
  }

  String _toHex(int value) {
    if (value < 16) {
      return '0' + value.toRadixString(16);
    }
    return value.toRadixString(16);
  }

  Future<void> _load_items({required Store store, required String filter}) async {
    setState(() {
      got_data = false;
    });
    var res = global.getRequestMap("/products/?store_id=" + store.id + "&search=" + filter);
    Map<String, dynamic> data = await res;
    List<Item> items = [];
    data.forEach((key, value) {

      Item item = Item(
          sotreid: store.id,
          name: value["name"],
          id: key,
          image: value["image"],
          desc: "",
          price: double.parse(value["price"]),
          rate: value["rate"]
      );
      item.quantity = value["quantity"];
        items.add(item);
    });
    setState(() {
      store.items = items;
      got_data = true;
    });
  }

}
