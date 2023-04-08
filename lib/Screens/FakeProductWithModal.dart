import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ProductsModel.dart';

class FakeProductWithModal extends StatefulWidget {
  const FakeProductWithModal({Key? key}) : super(key: key);

  @override
  State<FakeProductWithModal> createState() => _FakeProductWithModalState();
}

class _FakeProductWithModalState extends State<FakeProductWithModal> {
  List<products>? allproducts;
  bool isloded = false;
  getproduct() async {
    setState(() {
      isloded = true;
    });
    Uri Url = Uri.parse("https://api.escuelajs.co/api/v1/products");
    var response = await http.get(Url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body.toString());
      setState(() {
        allproducts = json.map<products>((obj) => products.fromJson(obj)).toList();
        isloded = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getproduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FakeProductWithModal"),
        ),
        body: (isloded)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: allproducts!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(allproducts![index].images![0].toString()),
                    title: Text(allproducts![index].title.toString()),
                    subtitle: Text(allproducts![index].price.toString()),
                  );
                },
              ));
  }
}
