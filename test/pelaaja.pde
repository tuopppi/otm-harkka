class Pelaaja {
  String _nimi;
  int _rahat;
  
  Pelaaja(String nimi) {
    _nimi = nimi;
    _rahat = 1000;
  }
  
  String get_nimi() {
    return _nimi;
  }
  
  int get_rahat() {
    return _rahat;
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
