/* Geneerinen torni, tästä voi erikoistaa erilaisia torneja */
class Tower {
  int _x, _y;
  int _level = 1;
  boolean _locked = false;
  boolean _draw_info = false;
  
  Tower(int pos_x, int pos_y) {
    _x = pos_x;
    _y = pos_y;
  }
  
  void upgrade() {
    _level = _level + 1;
  }
  
  void lock() {
    _locked = true;
  }
  
  void show_info() {
    _draw_info = true;
  }
  
  void hide_info() {
    _draw_info = false;
  }
  
  void set_location(int pos_x, int pos_y) {
    if(!_locked) {
      _x = pos_x;
      _y = pos_y;
    }
  }
  
  void draw() {
    if(_draw_info) {
      this.draw_info();
    }
    this.draw_tower();
  }
  
  void draw_tower() {
    /* Perustornin piirtäminen */
    fill(255);
    ellipse(_x, _y, 50, 50);
    
    rectMode(CENTER);
    fill(64);
    rect(_x, _y - 20, 20, 20,4);
    
    fill(128);
    ellipse(_x, _y, 40, 40);
  }
  
  void draw_info() {
    // infopanel
    rectMode(CORNER);
    fill(255);
    rect(width - 110, 10, 100, 100);
    
    // range
    ellipse(_x, _y, _level * 100, _level * 100);
  }

}
