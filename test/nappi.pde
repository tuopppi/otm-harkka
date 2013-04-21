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
    _txt = null;

  }

  Nappi(int xKoord, int yKoord, int leveys, int korkeus, color vari, String teksti) {
    this(xKoord, yKoord, leveys, korkeus, vari);
    _txt = teksti;
  }
   
  /* onko nappia painettu
   * @clickx, @clicky: painalluken koordinaatti suhteessa nappikoordinaattien nollakohtaan
   */
  boolean mouseOver(int clickx, int clicky) {
    return (clickx > _x && clickx < _x + _w &&
            clicky > _y && clicky < _y + _h);
  }
  
  void setPosCol(int posX, int posY, color vari) {
    _x = posX;
    _y = posY;
    _c = vari;
  }

  void piirraRuksi() {
    strokeWeight(10);
    stroke(0);
    line(_x, _y, _x+_w, _y+_h);
    line(_x, _y+_h, _x+_w, _y);
    strokeWeight(1);
  }

  void draw() {
    fill(_c);
    rect(_x,_y, _w,_h);
    if(_txt != null) {
      fill(20);
      textAlign(CENTER, CENTER);
      text(_txt, _x + _w / 2, _y + _h / 2);
    }
  }
   
  private int   _x;
  private int   _y;
  private int   _w;
  private int   _h;
  private color _c;
  private String _txt;

}
