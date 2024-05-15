import 'package:blink/pages/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../global.dart' as global;
import '../classes/store.dart';

class StorePage extends StatefulWidget {
  StorePage({required this.store});
  Store store;
  @override
  State<StorePage> createState() => _StorePageState(store: store);
}

class _StorePageState extends State<StorePage> {
  Store store;
  _StorePageState({required this.store});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: store.items.length,
          itemBuilder: (context, i){
        return ListTile(
          title: Text(store.items[i].name),
          onTap: () {
            if (!global.currentCardPayement) {
              if (global.s == null)
                global.s = store;
              else if (global.s!.id != store.id) {
                global.card.removeRange(0, global.card.length - 1);
                global.s = store;
              }
              global.card.add(store.items[i]);
            }
          },
        );
      }),
    );
  }
}
