import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:ivt_web/ProductsObject.dart';

import 'package:ivt_web/View/product_selected.dart';

class ProductsList extends StatefulWidget {
  static const String routeName = '/ProductsList';

  const ProductsList({Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList>
    with TickerProviderStateMixin {
  double deviceHeight = 0.0;
  double deviceWidth = 0.0;
  late ProductsObject _po;
  late List<String> _productsList;
  late String _pattern;
  List<String>? expansionTilesList;
  Map<String, List<String>> expansionTitleXListTilesMap = {};

  Future<Set<String>> getExpansionsTiles(String pattern) async {
    return _productsList
        .where(
          (element) => element.toLowerCase().contains(pattern.toLowerCase()),
        )
        .map((element) => element.split(':')[2])
        .toSet();
  }

  Future<List<String>> getTiles(String pattern) async {
    return _productsList
        .where(
          (element) => element.toLowerCase().contains(pattern.toLowerCase()),
        )
        .toList();
  }

  Future<int> _buildMap() async {
    expansionTilesList = (await getExpansionsTiles(_pattern)).toList();
    expansionTilesList!.sort();
    for (var i in expansionTilesList!) {
      List<String> listTiles = await getTiles('$_pattern:$i:');
      listTiles.sort();
      expansionTitleXListTilesMap[i] = listTiles;
    }
    return 0;
  }

  Widget _list() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: expansionTilesList!.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          collapsedTextColor: const Color.fromRGBO(34, 34, 34, 1),
          textColor: const Color.fromRGBO(245, 179, 52, 1),
          collapsedIconColor: const Color.fromRGBO(245, 179, 52, 1),
          title: Text(
            expansionTilesList![index],
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          children: [
            for (
              int i = 0;
              i <
                  expansionTitleXListTilesMap[expansionTilesList![index]]!
                      .length;
              i++
            )
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 150, 0),
                child: GestureDetector(
                  onTap: () => Navigator.restorablePushNamed(
                    context,
                    ProductSelected.routeName,
                    arguments:
                        expansionTitleXListTilesMap[expansionTilesList![index]]![i],
                  ),
                  child: ListTile(
                    horizontalTitleGap: 1,
                    title: Text(
                      expansionTitleXListTilesMap[expansionTilesList![index]]![i]
                          .split(':')[3]
                          .trim(),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _po = ModalRoute.of(context)?.settings.arguments as ProductsObject;
    _productsList = _po.getProductsList;
    _pattern = _po.getPattern;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
        leading: GestureDetector(
          onTap: () => setState(() {
            Navigator.of(context).pop();
          }),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Flexible(
              child: Text(
                'Produkt IVT dopasowany do:',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
      body: SafeArea(
        child: AnimatedSwitcher(
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SizeTransition(sizeFactor: animation, child: child);
          },
          duration: const Duration(milliseconds: 700),
          reverseDuration: const Duration(milliseconds: 0),
          child: FutureBuilder(
            future: _buildMap(),
            builder: (context, snapshot) => snapshot.hasData
                ? _list()
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
