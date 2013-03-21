//yleiskäyttöinen luokka kaikenlaisille napeille
//-graafinen esitys
//  -väri/kuva
//  -koordinaatit
//-painalluksen tunnistus
//Nappien osoittama toiminto toteutetaan luokan ulkopuolella

class Nappi {
  
  Nappi(int xKoord, int yKoord, int leveys, int korkeus, color vari) {
    
    _x = xKoord;
    _y = yKoord;
    _w = leveys;
    _h = korkeus;
    _c = vari;
    
  }
   
  /* onko nappia painettu
   * @clickx, @clicky: painalluken koordinaatti suhteessa nappikoordinaattien nollakohtaan
   */
  boolean pressed(int clickx, int clicky) {
    return (clickx > _x && clickx < _x + _w &&
            clicky > _y && clicky < _y + _h);
  }
  
  void draw() {
    fill(_c);
    rect(_x,_y, _w,_h);
  }
   
  private int   _x;
  private int   _y;
  private int   _w;
  private int   _h;
  private color _c;

}
