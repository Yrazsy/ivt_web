import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ivt_web/AppScrollBehaviour.dart';
import 'package:ivt_web/ProductsObject.dart';
import 'package:ivt_web/ElementHandler.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../ProductsList.dart';
import 'ResponsiveValues.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();

}

class _ProductsPageState extends State<ProductsPage>
    with TickerProviderStateMixin {
  late ResponsiveValues responsive;
  bool isDeviceConnected = false;
  late final pageController;
  int page = 0;
  ElementHandler elementHandler = ElementHandler();
  final _productsList = ProductsDefault().fetchList;
  late String pattern;

  @override
  void initState() {
    pageController = PageController(
        viewportFraction: 0.9, keepPage: true, initialPage: page);
    super.initState();
  }




  //List<String> listDodania = [];
  //void give() async {
  // var db = FirebaseFirestore.instance;
  // db.collection('products')
  //     .doc('ourMatchingProducts').update({'values': listDodania});
  //}

  Widget _pageViewElement(String imagePath, String title) {
    return elementHandler.getFlag(title)
        ? GestureDetector(
        onTap: () async {
          if (title == 'Spinki' || title == 'Klamry') {
            setState(() {
              pattern = '$title:Dachówka';
            });
            Navigator.of(context).pushNamed('/ProductsList',
                arguments: ProductsObject(pattern, _productsList));
            //give();
          } else {
            setState(() {
              elementHandler.setFlaga = title;
            });
          }
        },
        child: Stack(children: [
          SizedBox(
            height: responsive.cardHeight/1.9,
            width: responsive.cardWidth,
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Material(
                    color: const Color.fromRGBO(249, 170, 51, 0.98),
                    elevation: 15,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, responsive.cardHeight / 4, 0, 14),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(18, 18, 18, 1),
                              fontWeight: FontWeight.bold),
                        )),
                  ))),
          ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: Material(
                  color: Colors.white,
                  child: Image(
                    alignment: Alignment.center,
                    height: responsive.cardHeight/2.25,
                    width: responsive.cardWidth,
                    image: AssetImage(imagePath),
                    fit: BoxFit.scaleDown,
                  ))),
          const SizedBox(
            height: 20,
          ),
        ]))
        : _pageViewElementRedirect(title);
  }

  Widget _pageViewElementRedirect(String title) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: GestureDetector(
            onTap: () => setState(() {
              elementHandler.setFlaga = title;
            }),
            child: Stack(
              children: [
                SizedBox(
                  height: responsive.cardHeight / 1.9,
                  width: responsive.cardWidth,
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Material(
                          color: const Color.fromRGBO(249, 170, 51, 0.98),
                          elevation: 15,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0, 14, 0, responsive.cardHeight / 3.25),
                              child: Text(
                                title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(18, 18, 18, 1),
                                    fontWeight: FontWeight.bold),
                              )),
                        ))),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Material(
                        elevation: 5,
                        color: Colors.white,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                  onTap: () => setState(() {
                                    elementHandler.setFlaga = title;
                                  }),
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 14, 0, 0),
                                      child: const CircleAvatar(
                                        backgroundColor:
                                        Color.fromRGBO(240, 240, 240, 0.5),
                                        child: Icon(
                                          Icons.keyboard_arrow_up,
                                          color: Colors.black,
                                        ),
                                      ))),
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                    pattern = '$title:Dachówka';
                                  });
                                  Navigator.of(context).pushNamed(
                                      '/ProductsList',
                                      arguments: ProductsObject(
                                          pattern, _productsList));
                                },
                                child: const Text(
                                  'Dachówka',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              const Divider(
                                  color: Colors.white, height: 1, thickness: 1),
                              const SizedBox(
                                height: 50,
                              ),
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                    pattern = '$title:Blachodachówka';
                                  });
                                  Navigator.of(context).pushNamed(
                                      '/ProductsList',
                                      arguments: ProductsObject(
                                          pattern, _productsList));
                                },
                                child: const Text(
                                  'Blachodachówka',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                               SizedBox(
                                height: 50,
                              ),
                            ]),
                      )),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      responsive = ResponsiveValues.of(context);
    });
    return Scaffold(
        backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
        body: SafeArea(child: LayoutBuilder(
          builder: (p0, p1) {
            if (p1.maxWidth < 750) {
              return AnimatedSwitcher(
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SizeTransition(sizeFactor: animation, child: child);
                  },
                  duration: const Duration(milliseconds: 0),
                  child: Stack(children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: responsive.cardHeight / 24,
                      child: const Text(
                        'Rodzaje produktów IVT:',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                            alignment: Alignment.center,
                            width: responsive.cardWidth,
                            child: PageView(
                              onPageChanged: (value) => setState(() {
                                page = value;
                              }),
                              dragStartBehavior: DragStartBehavior.start,
                              scrollBehavior: kIsWeb
                                  ? AppScrollBehavior()
                                  : const MaterialScrollBehavior(),
                              allowImplicitScrolling: true,
                              physics: const BouncingScrollPhysics(),
                              controller: pageController,
                              padEnds: false,
                              children: [
                                AnimatedSwitcher(
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return ScaleTransition(
                                          scale: animation, child: child);
                                    },
                                    duration: const Duration(milliseconds: 500),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10,0,10,0),
                                      child: _pageViewElement(
                                          'lib/resources/spinka_pageview.png',
                                          'Spinki'),
                                    )),
                                AnimatedSwitcher(
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return ScaleTransition(
                                          scale: animation, child: child);
                                    },
                                    duration: const Duration(milliseconds: 500),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10,0,10,0),
                                      child: _pageViewElement(
                                          'lib/resources/klamry.png', 'Klamry'),
                                    )),
                                AnimatedSwitcher(
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return ScaleTransition(
                                          scale: animation, child: child);
                                    },
                                    duration: const Duration(milliseconds: 500),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10,0,10,0),
                                      child: _pageViewElement(
                                          'lib/resources/wyborblachodachowka.jpg',
                                          'Wsporniki'),
                                    )),
                                AnimatedSwitcher(
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return ScaleTransition(
                                          scale: animation, child: child);
                                    },
                                    duration: const Duration(milliseconds: 500),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10,0,10,0),
                                      child: _pageViewElement(
                                          'lib/resources/kominek_dachowka.jpg',
                                          'Kominki 125'),
                                    )),
                                AnimatedSwitcher(
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return ScaleTransition(
                                          scale: animation, child: child);
                                    },
                                    duration: const Duration(milliseconds: 500),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10,0,10,0),
                                      child: _pageViewElement(
                                          'lib/resources/kominek 150.jpg',
                                          'Kominki 150'),
                                    ))
                              ],
                            ))),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                5, 10, 5, responsive.cardHeight / 20),
                            child: SmoothPageIndicator(
                              effect: const ScrollingDotsEffect(
                                  activeStrokeWidth: 2,
                                  dotHeight: 16,
                                  dotWidth: 16,
                                  dotColor: Color.fromRGBO(82, 83, 87, 1),
                                  activeDotColor:
                                  Color.fromRGBO(249, 170, 51, 1)),
                              controller: pageController,
                              count: 5,
                            )))
                  ]));
            } else {
              return AnimatedSwitcher(
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SizeTransition(sizeFactor: animation, child: child);
                  },
                  duration: const Duration(milliseconds: 0),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(height: 50,),
                      const Text(
                        'Rodzaje produktów IVT:',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50,),
                      Container(
                          alignment: Alignment.center,
                          width: responsive.cardWidth,
                          child: GridView.count(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            mainAxisSpacing:  100,
                            crossAxisSpacing: 50,
                            crossAxisCount: p1.maxWidth < 1100 ? 2 : p1.maxWidth <1450?3:4,
                            children: [
                              AnimatedSwitcher(
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
                                    return ScaleTransition(
                                        scale: animation, child: child);
                                  },
                                  duration: const Duration(milliseconds: 500),
                                  child: _pageViewElement(
                                      'lib/resources/spinka_pageview.png',
                                      'Spinki')),
                              AnimatedSwitcher(
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
                                    return ScaleTransition(
                                        scale: animation, child: child);
                                  },
                                  duration: const Duration(milliseconds: 500),
                                  child: _pageViewElement(
                                      'lib/resources/klamry.png', 'Klamry')),
                              AnimatedSwitcher(
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
                                    return ScaleTransition(
                                        scale: animation, child: child);
                                  },
                                  duration: const Duration(milliseconds: 500),
                                  child: _pageViewElement(
                                      'lib/resources/wyborblachodachowka.jpg',
                                      'Wsporniki')),
                              AnimatedSwitcher(
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
                                    return ScaleTransition(
                                        scale: animation, child: child);
                                  },
                                  duration: const Duration(milliseconds: 500),
                                  child: _pageViewElement(
                                      'lib/resources/kominek_dachowka.jpg',
                                      'Kominki 125')),
                              AnimatedSwitcher(
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
                                    return ScaleTransition(
                                        scale: animation, child: child);
                                  },
                                  duration: const Duration(milliseconds: 500),
                                  child: _pageViewElement(
                                      'lib/resources/kominek 150.jpg',
                                      'Kominki 150'))
                            ],
                          )),
                    ]),
                  ));
            }
          },
        )));
  }
}
