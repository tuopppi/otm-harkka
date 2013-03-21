//yleiskäyttöinen luokka kaikenlaisille napeille
//-graafinen esitys
//  -väri/kuva
//  -koordinaatit
//-painalluksen tunnistus
//Nappien osoittama toiminto toteutetaan luokan ulkopuolella

class Nappi {
  
  Nappi(int xKoord, int yKoord, int leveys, int korkeus, color vari, boolean valikkoNappi) {
    
    _x = xKoord;
    _y = yKoord;
    _w = leveys;
    _h = korkeus;
    _c = vari;
    
    if(valikkoNappi == true) {
      _xTrans = VTRANSX;
      _yTrans = VTRANSY;
    }
    else {
      _xTrans = 0;
      _yTrans = 0;
    }
  }
  
  //onko nappia painettu (translaatiot parametreinä)
  boolean pressed() {
    
    if(rectClicked(_x+_xTrans,_y+_yTrans, _w,_h)) {
      println("Klikkaus");
      return true;
    }
    
    return false;
  }
  
  void draw() {
    
    fill(_c);
    rect(_x+_xTrans,_y+_yTrans, _w,_h);
  }
   
  private int   _x;
  private int   _y;
  private int   _w;
  private int   _h;
  private color _c;
  
  private int _xTrans;
  private int _yTrans;
}
