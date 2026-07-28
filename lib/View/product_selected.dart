import 'dart:core';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductSelected extends StatefulWidget {
  const ProductSelected({Key? key}) : super(key: key);
  static const routeName = '/ProductSelected';

  @override
  State<ProductSelected> createState() => _ProductSelectedState();
}

class _ProductSelectedState extends State<ProductSelected> {
  String? imagePath = '';
  String? spinkiProductOptions;
  String? ourProduct;
  String? theirProduct;

  String? material;
  String? usage;
  String? pros;
  String? warning;

  Widget _perksWidget(String title, Icon icon, String description) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        CircleAvatar(backgroundColor: Colors.white, child: icon),
        const SizedBox(height: 5),
        Text(
          '$title:',
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(description, textAlign: TextAlign.center),
      ],
    );
  }

  void _handleMultipleMatches(String options) {
    options.split(';').forEach((element) {
      String textOrig = element.replaceAll(" ", "").toLowerCase();
      if (textOrig.contains("nordmark")) {
        switch (textOrig) {
          case "15.405nordmark2b":
            imagePath = '${imagePath!} lib/resources/nordmark2.png';

            break;
          case "15.405nordmark3b":
            imagePath = '${imagePath!} lib/resources/nordmark3.png';
            break;
        }
      } else {
        switch (element.split(" ")[0]) {
          case "15.407":
            imagePath = '${imagePath!} lib/resources/spinka407.png';
            break;
          case "15.409":
            imagePath = '${imagePath!} lib/resources/spinka409.png';
            break;
          case "15.416":
            imagePath = '${imagePath!} lib/resources/spinka416.png';
            break;
          case "15.417":
            imagePath = '${imagePath!} lib/resources/spinka417.png';
            break;
          case "15.435":
            imagePath = '${imagePath!} lib/resources/spinka435.png';
            break;
          case "15.456":
            imagePath = '${imagePath!} lib/resources/spinka456.png';
            break;
        }
      }
    });
    setState(() {
      imagePath = imagePath!.trim();
    });
  }

  void _handleSelection(String product) {
    imagePath = '';
    spinkiProductOptions = null;

    theirProduct = '${product.split(':')[2]}/${product.split(':')[3]}';

    switch (product.split(':')[0]) {
      case 'Spinki':
        material = 'Drut stalowy z powłoką antykorozyjną.';
        usage = 'Zabezpieczenie dachówek przed wysuwaniem.';
        if (product.contains(';')) {
          spinkiProductOptions = product.split(':')[4];
          _handleMultipleMatches(spinkiProductOptions!);
        } else {
          ourProduct = product.split(':')[4];

          String textOrig = ourProduct!.replaceAll(" ", "").toLowerCase();
          if (textOrig.contains("nordmark")) {
            switch (textOrig) {
              case "15.405nordmark2b":
                imagePath = 'lib/resources/nordmark2.png';

                break;
              case "15.405nordmark3b":
                imagePath = 'lib/resources/nordmark3.png';
                break;
            }
          } else {
            switch (ourProduct!.split(" ")[0]) {
              case "15.407":
                imagePath = 'lib/resources/spinka407.png';
                break;
              case "15.409":
                imagePath = 'lib/resources/spinka409.png';
                break;
              case "15.416":
                imagePath = 'lib/resources/spinka416.png';
                break;
              case "15.417":
                imagePath = 'lib/resources/spinka417.png';
                break;
              case "15.435":
                imagePath = 'lib/resources/spinka435.png';
                break;
              case "15.456":
                imagePath = 'lib/resources/spinka456.png';
                break;
            }
          }
        }

        break;
      case 'Kominki 125':
        material =
            'ABS pokryty wysokiej jakości lakierem odpornym na promieniowanie UV';
        usage =
            'Wentylacja pomieszczeń oraz odpowietrzenie instalacji sanitarnych.';
        pros =
            '- spojlery aerodynamiczne optymalizujące przepływ powietrza wokół kominka,'
            '\n- wszystkie kominki oferowane są wg kolorystyki producentów dachówek,'
            '\n - boczne otwory zwiększające wydajność wentylacji,'
            '\n - górna część kominka o średnicy 136 mm i przekroju wentylacyjnym 145 cm2,'
            '\n - kształt nakrywy umożliwiający pionowe ustawienie kominka przy nachyleniu połaci od 15° do 45°,'
            '\n - kanały odprowadzające kondensat o łącznej powierzchni 17 cm2,'
            '\n - pionowe przejście przez połać dachu ułatwiające uszczelnienie oraz zmniejszające straty ciepła'
            '\n - średnica przyłącza: Ø125 mm.';
        warning =
            'Wszystkie kominki dostępne są także w zestawach z rurą elastyczną przyłączeniową w korzystnej ofercie cenowej';
        ourProduct = product.split(':')[4];
        switch (product.split(':')[4]) {
          case "Krycie w koronkę KD":
          case "Krycie w łuskę DD":
            imagePath = 'lib/resources/karpiowka_kominek.jpg';
            break;
          case "BRAK":
            imagePath = 'lib/resources/ivt_logo.png';
            material = null;
            usage = null;
            warning = null;
            pros = null;
            break;
          case "Kominek Triventa typu T18-T35":
            imagePath = 'lib/resources/t18t35.png';
            break;
          default:
            if (product.split(':')[1] == 'Blachodachówka') {
              imagePath = 'lib/resources/kominek.png';
            } else {
              imagePath = 'lib/resources/kominydachowka.jpg';
              ourProduct = 'Numer produktu: $ourProduct';
            }
            break;
        }
        break;

      case 'Wsporniki':
        material = 'Płaskownik stal ocynkowana, malowanie proszkowe';
        usage = product.split(':')[1] == 'Blachodachówka'
            ? 'Mocowanie rury przeciwśniegowej do gontów, blach płaskich i trapezowych.'
            : 'Mocowanie rury przeciwśniegowej do dachówek karpiówek';
        pros =
            '-maksymalny odstęp pomiędzy poszczególnymi wspornikami uzależniony jest od kąta nachylenia połaci dachu oraz strefy obciążenia śniegiem,'
            '\n-wspornik należy montować na wysokości murłaty,'
            '\n-konstrukcja wspornika zapewnia łatwy i szybki montaż rur do wsporników.';
        ourProduct = product.split(':')[4];
        if (product.split(':')[1] == 'Blachodachówka') {
          switch (product.split(':')[4]) {
            case "Wspornik do blachodachówki TYP -W":
            case "Wspornik do blachodachówki TYP -N":
              imagePath = 'lib/resources/nw.png';
              break;
            case "Mocownik na rąbek typu klik":
              imagePath = 'lib/resources/klik.jpg';
              break;
            case "DECRA":
              imagePath = 'lib/resources/decra.jpg';
              break;
            case "BRAK":
              imagePath = 'lib/resources/ivt_logo.png';
              material = null;
              usage = null;
              warning = null;
              pros = null;
              break;
            case "Wspornik uniwersalny płaski":
              imagePath = 'lib/resources/plaski.jpg';
              usage =
                  'Mocowanie rury przeciwśniegowej do gontów, blach płaskich i trapezowych.';
              pros =
                  ('${pros!}-zastosowanie wspornika do blachy trapezowej:\n• TYP A – max. wysokość trapezu 25 mm,\n-odległość między otworami montażowymi 115 mm');
              break;
            default:
              imagePath = 'lib/resources/reszta.jpg';
              break;
          }
        } else {
          imagePath = 'lib/resources/dachowka.jpg';
        }
        break;
      case 'Klamry':
        ourProduct = 'Numer produktu: ${product.split(':')[5].substring(0, 6)}';
        material =
            'Aluminium o grubości 1,0 mm powlekane farbami poliestrowymi.';
        usage = 'Mocowanie gąsiora dachowego.';
        String text = product.split(':')[5].substring(0, 6).trim();
        imagePath = "lib/resources/$text.png";
        warning =
            'Przy składaniu zamówień należy uzupełnić kod produktu wg poniższego zestawienia dostępnych produktów:\n';
        if (product
            .split(':')[5]
            .substring(6, product.split(':')[5].length)
            .trim()
            .contains('1')) {
          warning = '$warning•01 – czarny\n';
        }
        if (product
            .split(':')[5]
            .substring(6, product.split(':')[5].length)
            .trim()
            .contains('1')) {
          warning = '$warning•02 – ceglasty\n';
        }
        if (product
            .split(':')[5]
            .substring(6, product.split(':')[5].length)
            .trim()
            .contains('1')) {
          warning = '$warning•03 – brązowy\n';
        }
        if (product
            .split(':')[5]
            .substring(6, product.split(':')[5].length)
            .trim()
            .contains('1')) {
          warning = '$warning•04 – kasztanowy\n';
        }
        if (product
            .split(':')[5]
            .substring(6, product.split(':')[5].length)
            .trim()
            .contains('1')) {
          warning = '$warning•05 – antracytowy\n';
        }
        warning =
            '$warning np. Bogen, Gąsior nr 2, czarny – numer produktu 14106201.';

        break;
      case 'Kominki 150':
        ourProduct = 'Numer produktu: ${product.split(':')[4]}';
        material = 'Akrylo-butadieno-styren (ABS).';
        usage =
            'Wentylacja pomieszczeń oraz odpowietrzenie instalacji sanitarnych.';
        imagePath = "lib/resources/kominek 150.jpg";

        break;
    }
  }

  double deviceHeight = 0.0;
  double deviceWidth = 0.0;

  Widget _exitButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const CircleAvatar(
        backgroundColor: Color.fromRGBO(240, 240, 240, 0.75),
        child: Icon(Icons.clear_outlined, color: Color.fromRGBO(34, 34, 34, 1)),
      ),
    );
  }

  Widget _shopButton() {
    return const CircleAvatar(
      backgroundColor: Color.fromRGBO(240, 240, 240, 0.75),
      child: Icon(
        Icons.shopping_cart_outlined,
        color: Color.fromRGBO(34, 34, 34, 1),
      ),
    );
  }

  final pageController = PageController(
    viewportFraction: 0.97,
    keepPage: true,
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as String;
    _handleSelection(product);
    setState(() {
      var size = MediaQuery.of(context).size;
      deviceHeight = size.height;
      deviceWidth = size.width;
    });
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color.fromRGBO(240, 240, 240, 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: PageView(
                  controller: pageController,
                  children: [
                    CustomScrollView(
                      shrinkWrap: true,
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.white,
                          title: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [_exitButton(), _shopButton()],
                          ),
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(deviceHeight / 4),
                            child: Container(
                              decoration: const BoxDecoration(
                                backgroundBlendMode: BlendMode.srcOver,
                                color: Color.fromRGBO(240, 240, 240, 1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                              alignment: Alignment.center,
                              width: double.maxFinite,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.horizontal_rule),
                                  const SizedBox(height: 2),
                                  Text(
                                    spinkiProductOptions == null
                                        ? ourProduct!
                                        : spinkiProductOptions!.split(';')[0],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(249, 170, 51, 1),
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          expandedHeight: product.contains('Spinki')
                              ? deviceWidth * 0.665 + 45
                              : deviceHeight / 1.5,
                          flexibleSpace: FlexibleSpaceBar(
                            background: spinkiProductOptions == null
                                ? product.contains('Spinki')
                                      ? Image.asset(
                                          imagePath!,
                                          alignment: Alignment.topCenter,
                                          fit: BoxFit.scaleDown,
                                        )
                                      : Image.asset(
                                          imagePath!,
                                          alignment: Alignment.center,
                                          fit: BoxFit.scaleDown,
                                        )
                                : Image.asset(
                                    imagePath!.split(' ')[0],
                                    alignment: Alignment.topCenter,
                                    fit: BoxFit.scaleDown,
                                  ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                            color: const Color.fromRGBO(240, 240, 240, 100),
                            child: Column(
                              children: [
                                if (product.contains('Klamry'))
                                  const SizedBox(height: 15),
                                if (product.contains('Klamry'))
                                  Text(
                                    product.split(':')[4],
                                    style: const TextStyle(
                                      color: Color.fromRGBO(245, 179, 52, 1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                const SizedBox(height: 15),
                                const Text(
                                  'Opis produktu:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(34, 34, 34, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                material != null
                                    ? _perksWidget(
                                        'Materiał',
                                        const Icon(
                                          Icons.biotech,
                                          color: Color.fromRGBO(
                                            245,
                                            179,
                                            52,
                                            1,
                                          ),
                                        ),
                                        material!,
                                      )
                                    : SizedBox(height: deviceHeight / 4),
                                usage != null
                                    ? _perksWidget(
                                        'Zastosowanie',
                                        const Icon(
                                          Icons.settings,
                                          color: Color.fromRGBO(
                                            245,
                                            179,
                                            52,
                                            1,
                                          ),
                                        ),
                                        usage!,
                                      )
                                    : SizedBox(height: deviceHeight / 4),
                                pros != null
                                    ? _perksWidget(
                                        'Zalety',
                                        const Icon(
                                          Icons.add,
                                          color: Color.fromRGBO(
                                            245,
                                            179,
                                            52,
                                            1,
                                          ),
                                        ),
                                        pros!,
                                      )
                                    : const SizedBox(),
                                warning != null
                                    ? _perksWidget(
                                        'Uwagi',
                                        const Icon(
                                          Icons.warning,
                                          color: Color.fromRGBO(
                                            245,
                                            179,
                                            52,
                                            1,
                                          ),
                                        ),
                                        warning!,
                                      )
                                    : SizedBox(height: deviceHeight / 4),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    //DRUGA OPCJA SPINKI-------------------------------------------------------------------------------------------------------------------------
                    if (spinkiProductOptions != null)
                      CustomScrollView(
                        shrinkWrap: true,
                        slivers: [
                          SliverAppBar(
                            pinned: true,
                            automaticallyImplyLeading: false,
                            toolbarHeight: 60,
                            backgroundColor: Colors.white,
                            title: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [_exitButton(), _shopButton()],
                            ),
                            bottom: PreferredSize(
                              preferredSize: Size.fromHeight(deviceHeight / 4),
                              child: Container(
                                decoration: const BoxDecoration(
                                  backgroundBlendMode: BlendMode.srcOver,
                                  color: Color.fromRGBO(240, 240, 240, 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                padding: const EdgeInsets.fromLTRB(
                                  20,
                                  0,
                                  20,
                                  15,
                                ),
                                alignment: Alignment.center,
                                width: double.maxFinite,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.horizontal_rule),
                                    const SizedBox(height: 2),
                                    Text(
                                      spinkiProductOptions == null
                                          ? ourProduct!
                                          : spinkiProductOptions!.split(';')[1],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(249, 170, 51, 1),
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            expandedHeight: deviceWidth * 0.665 + 45,
                            flexibleSpace: FlexibleSpaceBar(
                              background: Image.asset(
                                imagePath!.split(' ')[1],
                                width: double.maxFinite,
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                              color: const Color.fromRGBO(240, 240, 240, 100),
                              child: Column(
                                children: [
                                  const SizedBox(height: 15),
                                  const Text(
                                    'Opis produktu:',
                                    style: TextStyle(
                                      color: Color.fromRGBO(34, 34, 34, 1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  material != null
                                      ? _perksWidget(
                                          'Materiał',
                                          const Icon(
                                            Icons.biotech,
                                            color: Color.fromRGBO(
                                              245,
                                              179,
                                              52,
                                              1,
                                            ),
                                          ),
                                          material!,
                                        )
                                      : SizedBox(height: deviceHeight / 4),
                                  usage != null
                                      ? _perksWidget(
                                          'Zastosowanie',
                                          const Icon(
                                            Icons.settings,
                                            color: Color.fromRGBO(
                                              245,
                                              179,
                                              52,
                                              1,
                                            ),
                                          ),
                                          usage!,
                                        )
                                      : SizedBox(height: deviceHeight / 4),
                                  pros != null
                                      ? _perksWidget(
                                          'Zalety',
                                          const Icon(
                                            Icons.add,
                                            color: Color.fromRGBO(
                                              245,
                                              179,
                                              52,
                                              1,
                                            ),
                                          ),
                                          pros!,
                                        )
                                      : SizedBox(height: deviceHeight / 4),
                                  warning != null
                                      ? _perksWidget(
                                          'Uwagi',
                                          const Icon(
                                            Icons.warning,
                                            color: Color.fromRGBO(
                                              245,
                                              179,
                                              52,
                                              1,
                                            ),
                                          ),
                                          warning!,
                                        )
                                      : SizedBox(height: deviceHeight / 4),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                    //TRZECIA OPCJA SPINKI-------------------------------------------------------------------------------------------------------------------------
                    if (spinkiProductOptions != null)
                      if (spinkiProductOptions!.split(';').length > 2)
                        CustomScrollView(
                          shrinkWrap: true,
                          slivers: [
                            SliverAppBar(
                              pinned: true,
                              automaticallyImplyLeading: false,
                              toolbarHeight: 60,
                              backgroundColor: Colors.white,
                              title: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [_exitButton(), _shopButton()],
                              ),
                              bottom: PreferredSize(
                                preferredSize: Size.fromHeight(
                                  deviceHeight / 4,
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    backgroundBlendMode: BlendMode.srcOver,
                                    color: Color.fromRGBO(240, 240, 240, 1),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  padding: const EdgeInsets.fromLTRB(
                                    20, 0, 20, 15,
                                  ),
                                  alignment: Alignment.center,
                                  width: double.maxFinite,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.horizontal_rule),
                                      const SizedBox(height: 2),
                                      Text(
                                        spinkiProductOptions == null
                                            ? ourProduct!
                                            : spinkiProductOptions!.split(
                                                ';',
                                              )[2],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(
                                            249,
                                            170,
                                            51,
                                            1,
                                          ),
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              expandedHeight: deviceWidth * 0.665 + 45,
                              flexibleSpace: FlexibleSpaceBar(
                                background: Image.asset(
                                  imagePath!.split(' ')[2],
                                  width: double.maxFinite,
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(
                                  35,
                                  0,
                                  35,
                                  0,
                                ),
                                color: const Color.fromRGBO(240, 240, 240, 100),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    const Text(
                                      'Opis produktu:',
                                      style: TextStyle(
                                        color: Color.fromRGBO(34, 34, 34, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    material != null
                                        ? _perksWidget(
                                            'Materiał',
                                            const Icon(
                                              Icons.biotech,
                                              color: Color.fromRGBO(
                                                245,
                                                179,
                                                52,
                                                1,
                                              ),
                                            ),
                                            material!,
                                          )
                                        : SizedBox(height: deviceHeight / 4),
                                    usage != null
                                        ? _perksWidget(
                                            'Zastosowanie',
                                            const Icon(
                                              Icons.settings,
                                              color: Color.fromRGBO(
                                                245,
                                                179,
                                                52,
                                                1,
                                              ),
                                            ),
                                            usage!,
                                          )
                                        : SizedBox(height: deviceHeight / 4),
                                    pros != null
                                        ? _perksWidget(
                                            'Zalety',
                                            const Icon(
                                              Icons.add,
                                              color: Color.fromRGBO(
                                                245,
                                                179,
                                                52,
                                                1,
                                              ),
                                            ),
                                            pros!,
                                          )
                                        : SizedBox(height: deviceHeight / 4),
                                    warning != null
                                        ? _perksWidget(
                                            'Uwagi',
                                            const Icon(
                                              Icons.warning,
                                              color: Color.fromRGBO(
                                                245,
                                                179,
                                                52,
                                                1,
                                              ),
                                            ),
                                            warning!,
                                          )
                                        : SizedBox(height: deviceHeight / 4),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                  ],
                ),
              ),
              if (spinkiProductOptions != null)
                SizedBox(
                  width: deviceWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.arrow_back, color: Color.fromRGBO(255, 187, 57, 1),)),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, deviceHeight / 25),
                        child: SmoothPageIndicator(
                          effect: const ScrollingDotsEffect(
                            activeStrokeWidth: 2,
                            dotHeight: 16,
                            dotWidth: 16,
                            dotColor: Color.fromRGBO(82, 83, 87, 1),
                            activeDotColor: Color.fromRGBO(255, 187, 57, 1),
                          ),
                          controller: pageController,
                          count: spinkiProductOptions!.split(';').length,
                        ),
                      ),
                      const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.arrow_forward, color: Color.fromRGBO(255, 187, 57, 1),),)
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
