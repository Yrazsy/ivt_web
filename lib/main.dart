import 'dart:async';
import 'package:flutter/material.dart';
import 'View/product_page.dart';
import 'View/product_selected.dart';
import 'View/productTypeSelect_page.dart';
import 'View/search_page.dart';
import 'custom_icons_icons.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Dodać responsywny design dla każdego rozmiaru MediaQuery Small (smaller than 640px) Medium (641px to 1007px) Large (1008px and larger)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          fontFamily: 'Monte',
        ),
        home: const Main(),
        routes: {
          ProductSelected.routeName: (context) => ProductSelected(),
          ProductsList.routeName: (context) => ProductsList()
        });
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool _isDrawerTabPressed = false;
  var controller = PageController(initialPage: 0);
  int _selectedIndex = 0;
  final bottomWidgetKey = GlobalKey<State<BottomNavigationBar>>();
  final String appBarImagePath = "lib/resources/ivt_logo_appbar.png";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // <-- added

  void bnvSelect(int index) {
    _selectedIndex = index;
    controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            onPageChanged: (page) {
              setState(() {
                _selectedIndex = page;
              });
            },
            children: const [
              ProductsPage(),
              SearchPage(),
            ],
          ),

          // vertically centered arrow tab on the left edge
          LayoutBuilder(
            builder: (context, constraints) {
              final tabWidth = (constraints.maxWidth * 0.09).clamp(30.0, 52.0);
              final tabHeight = (constraints.maxHeight * 0.09).clamp(52.0, 97.0);
              final iconSize = (constraints.maxWidth * 0.0525).clamp(16.0, 27.0);

              return Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _isDrawerTabPressed = true),
                  onTapUp: (_) => setState(() => _isDrawerTabPressed = false),
                  onTapCancel: () => setState(() => _isDrawerTabPressed = false),
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      width: tabWidth,
                      height: tabHeight,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _isDrawerTabPressed
                            ? const Color.fromRGBO(214, 154, 40, 1) // darker on press
                            : const Color.fromRGBO(245, 179, 52, 1),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        boxShadow: _isDrawerTabPressed
                            ? []
                            : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: AnimatedRotation(
                        turns: _isDrawerTabPressed ? 0.06 : 0.0, // tiny nudge/rotation on press
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOut,
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: iconSize,
                        ),
                      ),
                    ),
                  ),
              );
            },
          ),
        ],
      ),

      drawer: Drawer(
        key: bottomWidgetKey,
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                CustomIcons.spinka,
                size: _selectedIndex == 0 ? 24 : 16,
                color: _selectedIndex == 0
                    ? const Color.fromRGBO(245, 179, 52, 1)
                    : const Color.fromRGBO(21, 21, 21, 1),
              ),
              title: Text(
                'Produkty',
                style: TextStyle(
                  color: const Color.fromRGBO(21, 21, 21, 1),
                  fontSize: 14,
                  fontWeight: _selectedIndex == 0
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              selected: _selectedIndex == 0,
              onTap: () {
                bnvSelect(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.search,
                size: _selectedIndex == 1 ? 24 : 16,
                color: _selectedIndex == 1
                    ? const Color.fromRGBO(245, 179, 52, 1)
                    : const Color.fromRGBO(21, 21, 21, 1),
              ),
              title: Text(
                'Szukaj',
                style: TextStyle(
                  color: const Color.fromRGBO(21, 21, 21, 1),
                  fontSize: 14,
                  fontWeight: _selectedIndex == 1
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              selected: _selectedIndex == 1,
              onTap: () {
                bnvSelect(1);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

