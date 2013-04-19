static final int PUNAHINTA = 100;
static final int SINIHINTA = 150;
static final int VIHRHINTA = 200;

/* Geneerinen torni, tästä voi erikoistaa erilaisia torneja */
public class Tower {
  int _x, _y;
  int _width = 50;
  int _level = 1;
  boolean _locked = false;
  boolean _draw_info = false;
  color _color;
  String nimi;
  int hinta;
  
  static final int puna_idx = 1;
  static final int sini_idx = 2;
  static final int vihr_idx = 3;
      
  Tower(int type) throws Exception {
    _x = 0;
    _y = 0;

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
  }
  
  boolean clicked(int click_x, int click_y) {
      int maxx = _x + _width/2;
      int minx = _x - _width/2;
      int maxy = _y + _width/2;
      int miny = _y - _width/2;
      
      if( maxx > click_x && 
          minx < click_x &&
          maxy > click_y && 
          miny < click_y) {
        return true;
      } else { 
        return false;
      }
  }
  
  void upgrade() {
    _level = _level + 1;
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

  /* Piirretään viiva tornista kohteeseen */
  void ammu(PVector kohde) {
    pushMatrix();
    strokeWeight(3);
    stroke(_color);
    line(_x, _y, kohde.x, kohde.y);
    popMatrix();
  }
  
  void draw() {
    /* Perustornin piirtäminen */
    strokeWeight(1);
    stroke(0);
    fill(255);
    ellipse(_x, _y, _width, _width);
    
    /* TODO: jos haluaa että tornit pyörii ampumissuunnan mukana tätä pitää fixata
    rectMode(CENTER);
    fill(red(_color)-64, green(_color)-64, blue(_color)-64);
    rect(_x, _y - 20, 20, 20, 4);
    */

    fill(_color);
    ellipse(_x, _y, _width - 10, _width - 10);
  }

}
