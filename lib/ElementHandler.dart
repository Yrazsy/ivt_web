class ElementHandler {
  bool Spinki = true;
  bool Kominki = true;
  bool Kominki2 = true;
  bool Wsporniki = true;
  bool Klamry = true;


  set setFlaga(String title) {
    switch (title) {
      case 'Spinki':
        Spinki = !Spinki;
        break;
      case 'Kominki 125':
        Kominki = !Kominki;
        break;
      case 'Wsporniki':
        Wsporniki = !Wsporniki;
        break;
      case 'Klamry':
        Klamry = !Klamry;
        break;
      case 'Kominki 150':
        Kominki2 = !Kominki2;
        break;
    }
  }
  bool getFlag(String title){
    switch (title) {
      case 'Spinki':
        return Spinki;
      case 'Kominki 125':
        return Kominki;
      case 'Wsporniki':
        return Wsporniki;
      case 'Klamry':
        return Klamry;
      case 'Kominki 150':
        return Kominki2;
      default:
        return false;
    }


  }


  }




