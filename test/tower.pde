static final int PUNAHINTA = 100;
static final int SINIHINTA = 150;
static final int VIHRHINTA = 200;

/* Geneerinen torni, tästä voi erikoistaa erilaisia torneja */
public class Tower {
  int _x, _y;
  int _width = 50;
  int _level = 1;
  boolean _locked = false;
  boolean _selected = false; //onko tornia klikattu elikkäs onko kauppanäkymä auki
  boolean _wanhaTorni = false; //onko torni rakennettu alle tick sitten? Jos on, sitä ei voi valita select
  color _color;
  String nimi;
  int hinta;
  float range;
  float dps; // damage per second
  int prev_shot;
  
  static final int puna_idx = 1;
  static final int sini_idx = 2;
  static final int vihr_idx = 3;
       
  Tower(int type) throws Exception {
    _x = 0;
    _y = 0;
    range = 100.0;
    
    prev_shot = 0;

    switch(type) {
    case sini_idx:
        _color = color(0,0,255);
      nimi = "SININEN";
      hinta = SINIHINTA;
      break;
    case puna_idx:
        _color = color(255,0,0);
      nimi = "PUNAINEN";
      hinta = PUNAHINTA;
      break;
    case vihr_idx:
        _color = color(0,255,0);
      nimi = "VIHREA";
      hinta = VIHRHINTA;
      break;
    default:
      throw new Exception("Tuntematon tornityyppi"); 
    }

    dps = 70 + hinta/2;
  }
  

  boolean mouseOverlap() {
      int maxx = _x + _width/2;
      int minx = _x - _width/2;
      int maxy = _y + _width/2;
      int miny = _y - _width/2;
      
      if( maxx > mouseX && 
          minx < mouseX &&
          maxy > mouseY && 
          miny < mouseY) {
        return true;
      } else { 
        return false;
      }
  }
  
  void upgrade() {
    _level = _level + 1;
    dps = dps + _level * 20;
    range = range + 20;
  }
  
  void lock() {
    _locked = true;
  }
  
  boolean is_locked() {
    return _locked;
  }
  
  void set_location(PVector k) {
    if(!_locked) {
      _x = (int)k.x*50+25;
      _y = (int)k.y*50+25;
    }
  }

  /* Lasketaan paljonko päivitys seuraavalle tasolle maksaa */
  int upgradeHinta() {
    return (int)(hinta*1.0*_level);
  }

   /* Lasketaan paljonko päivitys seuraavalle tasolle maksaa */
  int myyntiHinta() {

    return (int)(hinta+0.5*_level);
  }

  /* Piirretään viiva tornista kohteeseen */
  void ammu(List kohteet) {
    PVector my_loc = new PVector(_x, _y);

    // Torni etsii kohteen joka on lähinpänä maaliruutua 
    // ja tornin rangen sisällä
    Iterator kohde_it = kohteet.iterator();
    while(kohde_it.hasNext()) {
      Ormy kohde = (Ormy)kohde_it.next();
      PVector sijainti = kohde.getXYPosition();
      float kohteen_etaisyys = PVector.sub(sijainti, my_loc).mag();

      if(kohteen_etaisyys <= range) {
        // tehdään dps verran vahinkoa kohteeseen
        // vahinko lasketaan suhteessa edelliseen päivityskertaan
        // muuten vahinkoa syntyisi nopealla tietokoneella enemmän kuin hitaalla

        if(prev_shot > 0) {
          float dmg = dps * _level * (millis() - prev_shot) / 1000.0;
          kohde.vahingoita(dmg);
        }
        prev_shot = millis(); // tallennetaan edellinen ampumisaika

        if(!kohde.elossa()) {
          pelaaja.muuta_rahoja(1);
          kohde_it.remove();
          return; // kohde tuhottu
        }

        // piirretään lasersäde
        pushMatrix();
        strokeWeight(3*_level);
        stroke(_color);
        line(_x, _y, sijainti.x, sijainti.y);
        strokeWeight(1*_level);
        stroke(255);
        line(_x, _y, sijainti.x, sijainti.y);
        strokeWeight(1);
        popMatrix();

        return; // kohdetta ei tuhottu
      }
    }

    prev_shot = 0; // ei torneja rangen sisällä, ei ammuttuja laukauksia
  }
  
  void draw() {
    /* Perustornin piirtäminen */
    strokeWeight(1);

    if(mouseOverlap() || this == kentta.valittu_torni) {
      stroke(128);
      fill(128,128,128,30.0);
      ellipse(_x, _y, range*2, range*2);
    }

    stroke(0);
    fill(255);
    ellipse(_x, _y, _width, _width);
    
    /* TODO: jos haluaa että tornit pyörii ampumissuunnan mukana tätä pitää fixata
    rectMode(CENTER);
    fill(red(_color)-64, green(_color)-64, blue(_color)-64);
    rect(_x, _y - 20, 20, 20, 4);
    */

    
    fill(_color);
    ellipse(_x, _y, _width - 20, _width - 20);

  }

}
