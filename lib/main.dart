import 'dart:convert';

import 'package:fake_store/api.dart';
import 'package:fake_store/login.dart';
import 'package:flutter/material.dart';

import 'product_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(), /*const MyHomePage(title: 'Flutter Demo Home Page'),*/
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductModel> mProductModel = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async {
    var response =
        await ApiProvider().getMethod('https://fakestoreapi.com/products');
    mProductModel = List<ProductModel>.from(
        jsonDecode(response).map((model) => ProductModel.fromJson(model)));
    setState(() {
      print('product---------${mProductModel.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Scaffold(
          appBar: AppBar(),
          body: ListView.builder(
              itemCount: mProductModel.length,
              itemBuilder: (context, index) {
                ProductModel item = mProductModel[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Image.network(
                            item.image!,
                            height: 70,
                            width: 70,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(item.title!),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(item.price.toString()),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(item.description!),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
