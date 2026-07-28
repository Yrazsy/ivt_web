import 'package:flutter/material.dart';


class ResponsiveValues {

  final double width;
  final double height;


  ResponsiveValues({
    required this.width,
    required this.height,
  });


  factory ResponsiveValues.of(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ResponsiveValues(
      width: size.width,
      height: size.height,
    );
  }


  bool get isMobile => width < 750;
  bool get isTablet => width >= 750 && width < 1200;
  bool get isDesktop => width >= 1200;

  double get cardHeight {

    if (isMobile) {
      return height;
    }

    if (isTablet) {
      return height*0.7;
    }

    return height*0.7;

  }
  double get cardWidth {

    if (isMobile) {
      return width;
    }

    if (isTablet) {
      return width;
    }

    return width;

  }

  double get imageHeight {
    return cardWidth * 0.9;
  }

  double get radius {
    if(isMobile){
      return 30;
    }
    return 35;
  }
}