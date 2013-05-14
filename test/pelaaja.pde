class Pelaaja {
  private String _nimi;
  private int _rahat;
  private int _elamat;
  
  Pelaaja() {
    _nimi = "Pelaaja";
    _rahat = 1000;
    _elamat = 1;
  }

  void set_nimi(String nimi) {
    _nimi = nimi;
  }
  
  String get_nimi() {
    return _nimi;
  }
  
  int get_rahat() {
    return _rahat;
  }
  int get_elamat() {
    return _elamat;
  }
  void vahenna_elamia(){
     _elamat--;
  }
  
  // Lisää (+) tai vähentää (-) pelaajan varallisuutta. Paluuarvo kertoo onnistuiko tapahtuma.
  // Lisäys: Paluuarvo on aina true.
  // Vähennys: Jos käyttäjän varallisuus menee negatiiviseksi, palautetaan false ja käyttäjän rahoihin ei kosketa.
  Boolean muuta_rahoja(int summa) {
    int tilanne = _rahat + summa;
    if(tilanne < 0) {
      return false;
    } else {
      _rahat = tilanne;
      return true;
    }
  }
  
}
