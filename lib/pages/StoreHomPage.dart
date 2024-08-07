import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:blink/classes/ColorGenerator.dart';
import 'package:blink/pages/ProductComment.dart';
import 'package:blink/pages/StoreComment.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:blink/global.dart' as global;
import 'package:image_picker/image_picker.dart';
import '../classes/item.dart';
import '../classes/store.dart';
import 'Chat.dart';
import 'Home.dart';
import 'Login.dart';
import 'Orders.dart';
import 'ProfileEdit.dart';

class StoreHomePage extends StatefulWidget {
  const StoreHomePage({super.key});

  // Store store;

  @override
  State<StoreHomePage> createState() => _StoreHomePageState();
}

var discount = TextEditingController();
var days = TextEditingController();
var darsad = TextEditingController();
List<discountClass> discounts = [];
double total_income = 0, net_profit = 0;
List<Widget> legends = [];
int total_items_sold = 0;
List<PieChartSectionData> pieCharts = [];
var _currentIndex = 1;
bool got_data = false;
Store? store = null;
var name = TextEditingController();
var price = TextEditingController();
var count = TextEditingController();
var desc = TextEditingController();
var search = TextEditingController();

class _StoreHomePageState extends State<StoreHomePage> {
  // _StoreHomePageState({required this.store});
  //

  File? _imageFile;
  String? base64Image = "";
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // /TODO: implement initState
    load_store();
    _load_statistics();
    // wait();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // store = stores[0];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF256F46),
        unselectedIconTheme: const IconThemeData(color: Colors.white, size: 40),
        selectedIconTheme:
            const IconThemeData(color: Color(0xFF256F46), size: 50),
        currentIndex: _currentIndex,
        onTap: (index) {
          // global.card.forEach((element) {
          //   sum += element.price;
          // });
          changeBottomIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Column(
              children: [
                const ImageIcon(
                  AssetImage('images/user2.png'),
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 0.5,
                  color: _currentIndex == 0
                      ? Colors.white
                      : const Color(0xFF256F46),
                  thickness: 2.5,
                  indent: 30,
                  endIndent: 30,
                )
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                const ImageIcon(
                  AssetImage('images/home.png'),
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 0.5,
                  color: _currentIndex == 1
                      ? Colors.white
                      : const Color(0xFF256F46),
                  thickness: 2.5,
                  indent: 30,
                  endIndent: 30,
                )
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ImageIcon(
                  AssetImage('images/graph.png'),
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 0.5,
                  color: _currentIndex == 2
                      ? Colors.white
                      : const Color(0xFF256F46),
                  thickness: 2.5,
                  indent: 37,
                  endIndent: 30,
                )
              ],
            ),
            label: '',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF256F46),
              onPressed: () {
                name.clear();
                desc.clear();
                count.clear();
                price.clear();
                if (store != null) bottomShett(context, null, false);
              },
              child: const Icon(
                Icons.add,
                size: 50,
              ),
            )
          : Container(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF256F46),
        leading: _currentIndex == 2
            ? IconButton(
                onPressed: () {
                  _load_statistics();
                },
                icon: Icon(Icons.refresh))
            : Container(),
      ),
      body: store == null
          ? const Center(
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
                    "در حال بارگذاری",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 30, color: Color(0xFF256F46)),
                  ),
                ],
              ),
            )
          : _currentIndex == 0
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      // Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Color(0xFF1C5334),
                                  size: 35,
                                )),
                            GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileEdit()))
                              },
                              child: const Text(
                                "ویرایش",
                                style: TextStyle(
                                    fontFamily: 'shabnam',
                                    color: Color(0xFF1C5334),
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(child: Container()),
                            Column(
                              children: [
                                Text(
                                  global.first_name,
                                  style: const TextStyle(
                                    fontFamily: 'shabnam',
                                    color: Color(0xFF1C5334),
                                    fontSize: 25,
                                  ),
                                ),
                                const Text(
                                  "فروشنده",
                                  style: TextStyle(
                                      fontFamily: 'shabnam',
                                      color: Colors.grey,
                                      fontSize: 19),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 17),
                              child: global.profile_imge == ""
                                  ? const ImageIcon(
                                      AssetImage('images/account.png'),
                                      color: Color(0xFF618771),
                                      size: 80,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(75),
                                      // Same radius as the CircleAvatar
                                      child: Image.memory(
                                        width: 100,
                                        Uint8List.fromList(
                                            base64Decode(global.profile_imge)),
                                        fit: BoxFit
                                            .cover, // Adjust the fit as needed
                                      ),
                                    ),
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 17),
                            //   child:
                            // ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          bottomsheet(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20, left: 20),
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          decoration: const BoxDecoration(
                              border: Border(
                            top: BorderSide(color: Colors.grey),
                          )),
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height * 0.03,
                          child: const Center(
                            child: Text(
                              "تخفیف‌ها",
                              style: TextStyle(
                                  fontFamily: 'shabnam', fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Orders(
                                        store: store!,
                                      )));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20, left: 20),
                          padding: const EdgeInsets.symmetric(vertical: 40),

                          decoration: const BoxDecoration(
                              border: Border(
                            top: BorderSide(color: Colors.grey),
                          )),
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height * 0.03,
                          child: const Center(
                            child: Text(
                              "سفارش‌ها",
                              style: TextStyle(
                                  fontFamily: 'shabnam', fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          // print("tapped");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChatPage(isAdmin: false)));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20, left: 20),
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          decoration: const BoxDecoration(
                              border: Border(
                            top: BorderSide(color: Colors.grey),
                          )),
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height * 0.03,
                          child: const Center(
                            child: Text(
                              "ارتباط با پشتیبانی",
                              style: TextStyle(
                                  fontFamily: 'shabnam', fontSize: 20),
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 20, left: 20, bottom: 40),
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          decoration: const BoxDecoration(
                              border: Border(
                            top: BorderSide(color: Colors.grey),
                            bottom: BorderSide(color: Colors.grey),
                          )),
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height * 0.03,
                          child: const Center(
                            child: Text(
                              "خروج",
                              style: TextStyle(
                                  fontFamily: 'shabnam', fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      // Expanded(child: Container())
                      const ImageIcon(
                        AssetImage('images/logo.png'),
                        size: 80,
                        color: Color(0xFF399160),
                      ),
                      const Text("with blink",
                          style: TextStyle(
                              fontFamily: 'shabnam',
                              fontSize: 20,
                              color: Color(0xFF1C5334))),
                      const Text(
                        "v 1.0.0",
                        style: TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 20,
                            color: Color(0xFF1C5334)),
                      )
                    ],
                  ),
                )
              : _currentIndex == 1
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: SizedBox(
                                height: 120,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                iconSize: 40,
                                                icon: const ImageIcon(
                                                  AssetImage(
                                                      "images/notification.png"),
                                                  color: Color(0xFF2E8B57),
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    iconSize: 25,
                                                    icon: const ImageIcon(
                                                      AssetImage(
                                                          "images/star.png"),
                                                      color: Color(0xFF256F46),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  global.toPersianNumbers(
                                                          store!.rate) +
                                                      "/۵",
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Expanded(child: Container()),
                                        Column(
                                          children: [
                                            Text(
                                              store!.name,
                                              style:
                                                  const TextStyle(fontSize: 25),
                                            ),
                                            Text(
                                              store!.category,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        Expanded(child: Container()),
                                        Container(
                                          decoration: const BoxDecoration(
                                              // color: Color(0xffEAF3EE),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                ),
                                                BoxShadow(
                                                  color: Color(0xffEAF3EE),
                                                  spreadRadius: -0.2,
                                                  blurRadius: 5.0,
                                                ),
                                              ],
                                              // color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          child: global.profile_imge == ""
                                              ? const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                                  child: ImageIcon(
                                                    AssetImage(
                                                        "images/shop.png"),
                                                    size: 50,
                                                  ))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  // Same radius as the CircleAvatar
                                                  child: Image.memory(
                                                    width: 100,
                                                    Uint8List.fromList(
                                                        base64Decode(global
                                                            .profile_imge)),
                                                    fit: BoxFit
                                                        .cover, // Adjust the fit as needed
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              StoreComment(store: store!)));
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Color(0xFF256F46),
                                    ),
                                    Text(
                                      "مشاهده نظرات",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF256F46)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15),
                              child: TextField(
                                controller: search,
                                textAlign: TextAlign.center,
                                onChanged: (changed) {
                                  _load_items(store, changed);
                                },
                                style: const TextStyle(fontSize: 25),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.search_rounded,
                                      size: 35,
                                      color: Color(0xFF2E8B57),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF2E8B57),
                                            width: 2.0)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF2E8B57),
                                            width: 2.0))),
                              ),
                            ),
                            !got_data
                                ? const Padding(
                                    padding: EdgeInsets.only(top: 30),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            "در حال دریافت کالاها",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Color(0xFF256F46)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: store!.items.length,
                                    itemBuilder: (cntx, i) {
                                      if (i != 0) i++;
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          i < store!.items.length
                                              ? prodcut(
                                                  15, 0, store!.items[i++])
                                              : Container(),
                                          i < store!.items.length
                                              ? prodcut(
                                                  15, 0, store!.items[i++])
                                              : Container(),
                                        ],
                                      );
                                    })
                          ],
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                _buildPieChartCard(),
                              ],
                            ),
                            // izedBox(height: 16),
                            _buildSalesInfoCard(),
                          ],
                        ),
                      ),
                    ),
    );
  }

  prodcut(double left, double right, Item item) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right, top: 10, bottom: 10),
      child: GestureDetector(
        onTap: () {
          name.text = item.name;
          count.text = item.quantity.toString();
          price.text = item.price.toString();
          desc.text = item.desc;
          bottomShett(context, item, true);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.39,
          // width: 140,
          height: 250,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              item.image == ""
                  ? const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: ImageIcon(
                        AssetImage("images/product.png"),
                        size: 50,
                      ))
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        // Same radius as the CircleAvatar
                        child: Image.memory(
                          width: 90,
                          Uint8List.fromList(base64Decode(item.image)),
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  item.name,
                  style: const TextStyle(fontSize: 23),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        global.toPersianNumbers(item.price),
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "تومان",
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeBottomIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> load_store() async {
    setState(() {
      got_data = false;
    });
    global.wait(1000);
// committing
    var res = global.getRequestMap('/sellers_store/');
    Map<String, dynamic> data = await res;

    Store s = Store(
        rate: data["store"]["rate"],
        category: data["category"],
        id: data["store"]["id"].toString(),
        name: data["store"]["name"],
        // rate: data["store"]["rate"],
        longitude: double.parse(data["store"]["location"]["longitude"]),
        latitude: double.parse(data["store"]["location"]["latitude"]),
        items: [],
        image: data["store"]["image"] == null ? "" : data["store"]["image"]);
    setState(() {
      store = s;
      got_data = true;
    });
    _load_items(s, "");
    // return store;
  }

  Future<void> _load_items(Store? store, String filter) async {
    setState(() {
      got_data = false;
    });
    var res = global.getRequestMap("/sellers_product/?search=" + filter);
    Map<String, dynamic> data = await res;
    List<Item> items = [];
    data.forEach((key, value) {
      var itemPrice = double.parse(value['price']);
      var item = Item(
          id: value["id"].toString(),
          rate: value['rate'],
          desc: value['name'],
          name: value['name'],
          price: itemPrice,
          sotreid: "",
          image: value["image"]);
      item.quantity = value["quantity"];
      items.add(item);
    });
    setState(() {
      store!.items = items;
      got_data = true;
    });
  }

  void bottomShett(context, Item? item, bool edit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery);

                            if (image != null) {
                              (await cropImageToSquare(File(image.path)))
                                  as File?;
                              // If you need the base64 string for any purpose
                              List<int> imageBytes =
                                  await _imageFile!.readAsBytes();
                              setState(() {
                                base64Image = base64Encode(imageBytes);
                              });
                            } else {}
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height:
                                      MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color(0xFFEAF3EE)
                                      // color: Colors.red
                                      ),
                                  child: _imageFile != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          // Same radius as the CircleAvatar
                                          child: Image.file(
                                            _imageFile!,
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit
                                                .fitWidth, // Ensure the image fills the IconButton
                                          ),
                                        )
                                      : item == null || item.image == ""
                                          ? const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 35),
                                              child: ImageIcon(
                                                AssetImage(
                                                    "images/product.png"),
                                                color: Color(0xFF5E846E),
                                                size: 95,
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(75),
                                              // Same radius as the CircleAvatar
                                              child: Image.memory(
                                                width: 150,
                                                Uint8List.fromList(
                                                    base64Decode(item.image)),
                                                fit: BoxFit
                                                    .fitHeight, // Adjust the fit as needed
                                              ),
                                            ),
                                ),
                                _imageFile != null ||
                                        (item != null && item.image != "")
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.highlight_remove_rounded,
                                          // Use any icon you prefer for deleting the image
                                          color: Colors
                                              .red, // Change the color if needed
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (item != null &&
                                                item.image != "")
                                              item.image = "";
                                            else
                                              _imageFile =
                                                  null; // Set _imageFile to null
                                          });
                                        },
                                        iconSize:
                                            30, // Adjust the size of the icon as needed
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => ProductComment(
                                            item: item!,
                                          )));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Color(0xFF256F46),
                                ),
                                Text(
                                  "مشاهده نظرات",
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xFF256F46)),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 20, left: 20, bottom: 20),
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Theme(
                                data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: TextField(
                                  controller: name,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.teal),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    labelText: '  نام محصول  ',
                                    floatingLabelStyle: TextStyle(fontSize: 25),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        fontSize: 25, fontFamily: 'shabnam'),
                                  ),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 20, left: 20, bottom: 20),
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Theme(
                                data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: TextField(
                                  controller: desc,
                                  maxLines: 3,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.teal),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    labelText: '  توضیحات محصول  ',
                                    floatingLabelStyle: TextStyle(fontSize: 25),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        fontSize: 25, fontFamily: 'shabnam'),
                                  ),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 20, left: 20, bottom: 20),
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Theme(
                                data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: TextField(
                                  controller: count,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.teal),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    labelText: '  تعداد  ',
                                    floatingLabelStyle: TextStyle(fontSize: 25),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        fontSize: 25, fontFamily: 'shabnam'),
                                  ),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 20, left: 20, bottom: 20),
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Theme(
                                data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: price,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.teal),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    labelText: '  قیمت  ',
                                    floatingLabelStyle: TextStyle(fontSize: 25),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        fontSize: 25, fontFamily: 'shabnam'),
                                  ),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.085,
                            child: ElevatedButton(
                              onPressed: () async {
                                edit
                                    ? global.putRequest({
                                        "product_id": item!.id.toString(),
                                        "product_name": name.text,
                                        "price": price.text,
                                        "quantity": count.text,
                                        "category_id": "1",
                                        "product_description": desc.text,
                                        "store_id": store!.id,
                                        "image": _imageFile != null
                                            ? base64Image
                                            : item.image
                                      }, '/edit_product/')
                                    : global.postRequest({
                                        "product_name": name.text,
                                        "price": price.text,
                                        "quantity": count.text,
                                        "product_description": desc.text,
                                        "category_id": "1",
                                        "store_id": store!.id,
                                        "image": _imageFile != null
                                            ? base64Image
                                            : ""
                                      }, '/add_product/');
                                // load_store();
                                // load_store();
                                wait();
                                load_store();
                                Navigator.pop(context);
                                edit
                                    ? global.toast(context,
                                        "محصول با موفقیت ویرایش شد", null)
                                    : global.toast(context,
                                        "محصول با موفقیت اضافه شد", null);
                              },
                              child: Text(
                                edit
                                    ? "   ویرایش محصول   "
                                    : "   افزودن محصول   ",
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => const Color(0xFF256F46))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<File> cropImageToSquare(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    final img.Image? image = img.decodeImage(imageBytes);

    if (image == null) {
      throw Exception("Could not decode image.");
    }

    int shortestSide = image.width < image.height ? image.width : image.height;
    int xOffset = (image.width - shortestSide) ~/ 2;
    int yOffset = (image.height - shortestSide) ~/ 2;

    final img.Image croppedImage = img.copyCrop(
      image,
      x: xOffset,
      y: yOffset,
      width: shortestSide,
      height: shortestSide,
    );

    final croppedFile =
        await imageFile.writeAsBytes(img.encodePng(croppedImage));
    setState(() {
      _imageFile = croppedFile;
    });
    return croppedFile;
  }

  Future<void> wait() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Widget _buildPieChartCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'فروش روزانه',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.5,
              child: PieChart(
                PieChartData(sections: pieCharts
                    //   sections: [
                    //   PieChartSectionData(
                    //   color: Colors.blue,
                    //   value: 35,
                    //   title: '35',
                    //   radius: 50,
                    //   titleStyle: TextStyle(color: Colors.white, fontSize: 16),
                    // ),
                    // PieChartSectionData(
                    //   color: Colors.red,
                    //   value: 73,
                    //   title: '73',
                    //   radius: 50,
                    //   titleStyle: TextStyle(color: Colors.white, fontSize: 16),
                    // ),
                    // PieChartSectionData(
                    //   color: Colors.pink,
                    //   value: 27,
                    //   title: '27',
                    //   radius: 50,
                    //   titleStyle: TextStyle(color: Colors.white, fontSize: 16),
                    // ),
                    // PieChartSectionData(
                    //   color: Colors.green,
                    //   value: 65,
                    //   title: '65',
                    //   radius: 50,
                    //   titleStyle: TextStyle(color: Colors.white, fontSize: 16),
                    // ),
                    // ],
                    ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'کل فروش: ' + global.toPersianNumbers(total_items_sold),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Column(children: legends),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(String title, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              color: color,
            ),
            SizedBox(width: 8),
            Text(title),
          ],
        ),
      ],
    );
  }

  Widget _buildSalesInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'فروش',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: 'ماهانه',
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (String? newValue) {},
                  items: <String>['ماهانه', 'هفتگی', 'روزانه']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Divider(),
            _buildSalesInfoRow('تعداد فروش',
                global.toPersianNumbers(total_items_sold), Colors.black),
            _buildSalesInfoRow('مجموع درآمد',
                ' تومان${global.toPersianNumbers(total_income)}', Colors.black),
            _buildSalesInfoRow('مالیات کسر شده',
                ' تومان${global.toPersianNumbers(0)}', Colors.red),
            _buildSalesInfoRow('سود خالص',
                ' تومان${global.toPersianNumbers(net_profit)}', Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesInfoRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 16, color: color),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Future<void> _load_statistics() async {
    setState(() {
      got_data = false;
      legends.clear();
      pieCharts.clear();
    });
    Map<String, dynamic>? product_sales;
    var res = global.getRequestMap("/seller-statistics/");
    Map<String, dynamic> data = await res;
    setState(() {
      total_items_sold = data["total_items_sold"];
      total_income = data["total_income"];
      net_profit = data["net_profit"];
    });
    product_sales = data["product_sales"].cast<String, dynamic>();
    setState(() {
      product_sales!.forEach((key, value) {
        Color color = ColorGenerator.generateRandomDarkColor();
        legends.add(_buildLegend(key, color));

        pieCharts.add(PieChartSectionData(
          color: color,
          value: double.parse(value.toString()),
          title: global.toPersianNumbers(value),
          radius: 50,
          titleStyle: TextStyle(color: Colors.white, fontSize: 16),
        ));
      });
    });
  }

  void dialog(BuildContext context, bool edit) {
    showDialog(
        context: context,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Material(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Theme(
                          data: ThemeData(
                            primaryColor: Colors.redAccent,
                            primaryColorDark: Colors.red,
                          ),
                          child: TextField(
                            controller: discount,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              labelText: '  کد تحفیف  ',
                              floatingLabelStyle: TextStyle(fontSize: 25),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                  fontSize: 25, fontFamily: 'shabnam'),
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Theme(
                          data: ThemeData(
                            primaryColor: Colors.redAccent,
                            primaryColorDark: Colors.red,
                          ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (txt) {
                              int a = int.parse(txt);
                              if (a > 100) darsad.text = "100";
                              if (a < 1) darsad.text = "1";
                            },
                            controller: darsad,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              labelText: '  درصد تخفیف  ',
                              floatingLabelStyle: TextStyle(fontSize: 25),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                  fontSize: 25, fontFamily: 'shabnam'),
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Theme(
                          data: ThemeData(
                            primaryColor: Colors.redAccent,
                            primaryColorDark: Colors.red,
                          ),
                          child: TextField(
                            controller: days,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              labelText: '  تعداد روز  ',
                              floatingLabelStyle: TextStyle(fontSize: 25),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                  fontSize: 25, fontFamily: 'shabnam'),
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.085,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (edit) {
                            global.putRequest({
                              "code": discount.text,
                              "expiration_date": DateTime.now().add(Duration(days: int.parse(days.text))).toString(),
                              "discount_value": darsad.text
                            }, "/update-discount-code/");
                          }
                          else {
                            global.postRequest({
                              "code": discount.text,
                              "expiration_date": DateTime.now()
                                  .add(Duration(days: int.parse(days.text)))
                                  .toString(),
                              "discount_value": darsad.text
                            }, "/create-discount-code/");
                          }
                          global.wait(500);
                          Navigator.pop(context);
                          days.clear();
                          discount.clear();
                          darsad.clear();
                          Navigator.pop(context);
                          bottomsheet(context);

                        },
                        child: !got_data
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(edit? "   ویرایش   ":"   ایجاد   ",
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Color(0xFF256F46))),
                      ),
                    ),
                  ),
                  // Expanded(child: Container())
                ],
              ),
            ),
          );
        });
  }

  void bottomsheet(context) {
    bool flag = false;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (builder) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: StatefulBuilder(
                builder: (builder, StateSetter setState) {
                  if (!flag) {
                    _load_discount(setState);
                    flag = true;
                  }
                  return Scaffold(
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          dialog(context, false);
                        },
                        child: Icon(Icons.add),
                        backgroundColor: Color(0xFF256F46),
                      ),
                      backgroundColor: Colors.transparent,
                      body: ListView.builder(
                          itemCount: discounts.length,
                          itemBuilder: (cntx, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  days.text = discounts[i].days.toString();
                                  discount.text = discounts[i].code;
                                  darsad.text = discounts[i].value.toString();
                                  dialog(context, true);
                                },
                                child: ListTile(
                                  title: Text(discounts[i].code),
                                  subtitle: Text(
                                      global.toPersianNumbers(discounts[i].value) +
                                          "%"),
                                  trailing: Text(
                                      global.toPersianNumbers(discounts[i].days) +
                                          " روز باقی مونده",
                                  textDirection: TextDirection.rtl,),
                                ),
                              ),
                            );
                          }));
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _load_discount(setState) async {
    setState(() {
      discounts.clear();
    });
    var res = global.getRequest("/seller-discount-codes/");
    List<Map<String, dynamic>> data = await res;
    data.forEach((element) {
      setState(() {
        discounts.add(discountClass(
            code: element["code"],
            value: element["discount_value"],
            days: DateTime.parse(element["expiration_date"])
                .difference(DateTime.now())
                .inDays));
      });
    });
  }
}

class discountClass {
  String code;
  int value;
  int days;

  discountClass({required this.code, required this.value, required this.days});
}
