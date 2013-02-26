/* Geneerinen torni, tästä voi erikoistaa erilaisia torneja */
class Tower {
  int _x, _y;
  int _width = 50;
  int _level = 1;
  boolean _locked = false;
  boolean _draw_info = false;
  
  Tower(int pos_x, int pos_y) {
    _x = pos_x;
    _y = pos_y;
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
  
  boolean info_visable() {
    return _draw_info;
  }
  
  void show_info() {
    _draw_info = true;
  }
  
  void hide_info() {
    _draw_info = false;
  }
  
  void set_location(PVector k) {
    if(!_locked) {
      _x = (int)k.x*50+25;
      _y = (int)k.y*50+25;
    }
  }
  
  void draw() {
      /* Perustornin piirtäminen */
    fill(255);
    ellipse(_x, _y, _width, _width);
    
    rectMode(CENTER);
    fill(64);
    rect(_x, _y - 20, 20, 20, 4);
    
    fill(128);
    ellipse(_x, _y, _width - 10, _width - 10);
  }

}
