import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ivt_web/View/product_selected.dart';
import 'package:ivt_web/ProductsList.dart';

//TODO: Dodać w opisie aplikacji że jest oparta na stale odświeżanej bazie danych. której dane oparte są na doświadczeniu najlepszych ekspertów w branży! i że ponad 736 dopasowań produktów!

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

final _productsList = ProductsDefault().fetchList;

class _SearchPageState extends State<SearchPage> {




  Future<List<String>> getSuggestions(String pattern) async {
    List<String> keywords = pattern.toLowerCase().split(' '); // Split the pattern by spaces

    List<String> suggestions = [];
    if (_productsList.isNotEmpty && keywords.isNotEmpty) {
      suggestions = _productsList.where((element) {

        // Element contains all keywords check
        return keywords.every((keyword) => element.toLowerCase().contains(keyword));
      }).toList();
    }

    return suggestions.toSet().toList(); // Remove duplicates
  }
  late FocusNode typeAheadFocusNode;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    typeAheadFocusNode = FocusNode(debugLabel: 'typeAhead');
    typeAheadFocusNode.addListener(_handleFocus);
  }

  @override
  void dispose() {
    super.dispose();
    typeAheadFocusNode.dispose();
  }

  void _handleFocus() {
    if (typeAheadFocusNode.hasFocus != _focused) {
      setState(() {
        _focused = typeAheadFocusNode.hasFocus;
      });
    }
  }

  Widget _searchingBar() {
    return TypeAheadField<dynamic>(
      //initState Listener logic
      focusNode: typeAheadFocusNode,

      //FetchData Logic
      suggestionsCallback: (pattern) async {
        return await getSuggestions(pattern);
      },

      //SingleElement Display Appearance
      itemBuilder: (context, suggestion) {
        final name = _displayName(suggestion.toString());
        final type = _displayTypeOfProduct(suggestion.toString());
        final company = _displayCompany(suggestion.toString());

        return ListTile(
          tileColor: const Color.fromRGBO(255, 255, 255, 0.05),
          title: Text(name, maxLines: 2, style: const TextStyle(fontSize: 15)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTag(type),
              const SizedBox(width: 5),
              _buildTag(company),
            ],
          ),
        );
      },

      //OnSelected Product
      onSelected: (suggestion) {
        Navigator.restorablePushNamed(
          context,
          ProductSelected.routeName,
          arguments: suggestion,
        );
      },

      // No result and error Views
      emptyBuilder: (context) => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Nie znaleziono wyników"),
      ),
      errorBuilder: (context, error) => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Wystąpił błąd, sprawdź swoje połączenie sieciowe'),
      ),

      //TODO: NOWOŚĆ W V6: Ręczne budowanie pola tekstowego
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: 'Wyszukiwanie',
            hintText: 'Wpisz nazwę produktu',

            // Active field label color
            floatingLabelStyle: TextStyle(
              color: _focused
                  ? const Color.fromRGBO(245, 179, 52, 1)
                  : const Color.fromRGBO(82, 83, 87, 1),
            ),

            // Non-active field label color
            labelStyle: TextStyle(
              color: _focused
                  ? const Color.fromRGBO(245, 179, 52, 1)
                  : const Color.fromRGBO(82, 83, 87, 1),
            ),

            // Frame appearance logic
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(245, 179, 52, 1)),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTag(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromRGBO(245, 179, 52, 0.5), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        text,
        style: const TextStyle(color: Color.fromRGBO(249, 170, 51, 1)),
      ),
    );
  }

  static String _displayName(String option) => option.split(':')[3];

  static String _displayCompany(String option) => option.split(':')[2];

  static String _displayTypeOfProduct(String option) => option.split(':')[0];

  double deviceHeight = 0.0;
  double deviceWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      var size = MediaQuery.of(context).size;
      deviceHeight = size.height;
      deviceWidth = size.width;
    });
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: _searchingBar())));
  }
}