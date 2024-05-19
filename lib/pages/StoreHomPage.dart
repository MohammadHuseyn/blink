import 'package:blink/pages/OrderHistory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blink/global.dart' as global;
import '../classes/store.dart';

class StoreHomePage extends StatefulWidget {
  // Store store;

  @override
  State<StoreHomePage> createState() => _StoreHomePageState();
}

var _currentIndex = 1;
var name = TextEditingController();
var price = TextEditingController();
var count = TextEditingController();
var desc = TextEditingController();
var store_id = TextEditingController();
class _StoreHomePageState extends State<StoreHomePage> {
  // _StoreHomePageState({required this.store});
  //
  late Store store;

  @override
  void initState() {
    // TODO: implement initState
    _load_store();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _load_store();
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF256F46),
          unselectedIconTheme: IconThemeData(color: Colors.white, size: 40),
          selectedIconTheme: IconThemeData(color: Color(0xFF256F46), size: 50),
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
                  ImageIcon(
                    AssetImage('images/user2.png'),
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 0.5,
                    color:
                        _currentIndex == 0 ? Colors.white : Color(0xFF256F46),
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
                  ImageIcon(
                    AssetImage('images/home.png'),
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 0.5,
                    color:
                        _currentIndex == 1 ? Colors.white : Color(0xFF256F46),
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
                  ImageIcon(
                    AssetImage('images/graph.png'),
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 0.5,
                    color:
                        _currentIndex == 2 ? Colors.white : Color(0xFF256F46),
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF256F46),
          onPressed: () {
            bottomShett(context);
          },
          child: Icon(
            Icons.add,
            size: 50,
          ),
        ),
        body: _currentIndex == 0
            ? Container()
            : _currentIndex == 1
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 50),
                          child: Container(
                            height: 120,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            iconSize: 40,
                                            icon: ImageIcon(
                                              AssetImage(
                                                  "images/notification.png"),
                                              color: Color(0xFF2E8B57),
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: IconButton(
                                                onPressed: () {},
                                                iconSize: 25,
                                                icon: ImageIcon(
                                                  AssetImage("images/star.png"),
                                                  color: Color(0xFF256F46),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "4.1/5",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Text(
                                      store.name,
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      decoration: BoxDecoration(
                                          // color: Color(0xffEAF3EE),
                                          boxShadow: [
                                            const BoxShadow(
                                              color: Colors.grey,
                                            ),
                                            const BoxShadow(
                                              color: Color(0xffEAF3EE),
                                              spreadRadius: -0.2,
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                          // color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 15),
                                        child: ImageIcon(
                                          AssetImage("images/shop.png"),
                                          size: 90,
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
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: TextField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  size: 35,
                                  color: Color(0xFF2E8B57),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Color(0xFF2E8B57), width: 2.0)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Color(0xFF2E8B57), width: 2.0))),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5532,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: store.items.length,
                              itemBuilder: (cntx, i) {
                                if (i != 0)
                                  i++;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    i < store.items.length? prodcut(15, 0, store.items[i++]) : Container(),
                                    i < store.items.length? prodcut(15, 0, store.items[i++]) : Container(),
                                  ],
                                );
                              }),
                        )
                      ],
                    ),
                  )
                : Container());
  }

  prodcut(double left, double right, Item item) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right, top: 20),
      child: GestureDetector(
        onTap: () {
          // bottomShett(item);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.39,
          // width: 140,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 11), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: ImageIcon(
                  AssetImage("images/product.png"),
                  color: Color(0xFF517360),
                  size: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  item.name,
                  style: TextStyle(fontSize: 23),
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
                        "۱۲۰۰۰",
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

  Future<void> _load_store() async {
    var res = global.getRequestmap('/get_sellers_store/');
    Map<String, dynamic> data = await res;
    List<Item> items = [];
    (data["store"]["products"] as Map<String, dynamic>)
        .forEach((String itemId, itemData) {
      var itemName = itemData['name'];
      var itemPrice = double.parse(itemData['price']);
      var item = Item(
          id: itemId, name: itemName, price: itemPrice, sotreid: data["store"]["id"].toString());
      items.add(item);
    });

    Store s = Store(
        id: data["store"]["id"].toString(),
        name: data["store"]["name"],
        longitude: data["store"]["location"]["longitude"],
        latitude: data["store"]["location"]["latitude"],
      items: items
    );
    setState(() {
      store = s;
    });
    // return store;
  }
}

void bottomShett(context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              bottomNavigationBar: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: Colors.grey,
                      spreadRadius: 7,
                      blurRadius: 7)
                ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.085,
                    child: ElevatedButton(
                      onPressed: () async {
                        global.postRequest({
                          "product_name"
                        }, '/add_product/');
                      },
                      child: Text(
                        "   افزودن محصول   ",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color(0xFF256F46))),
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0xFFEAF3EE)
                              // color: Colors.red
                              ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 35),
                            child: ImageIcon(
                              AssetImage("images/product.png"),
                              color: Color(0xFF5E846E),
                              size: 95,
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
                              controller: name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
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
                              controller: count,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
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
                              controller: desc,
                              maxLines: 3,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                labelText: '  توضیحات  ',
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
                              controller: price,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
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
                  ],
                ),
              ),
            ),
          );
        });
      });
}
