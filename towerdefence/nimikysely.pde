/* Piirtää tekstilaatikon koordinaatteihin x,y
 * Tekstilaatikolle täytyy kertoa tapahtuneesta keyPressed eventistä kutsumalla
 * read_key() funktiota.
 */
class Textbox {
  int _pos_x, _pos_y; // Nämä voi asettaa rakentajassa
  String _label = "";
  String _data = "";
  boolean _ready = false;
  
  int RECT_WIDTH = 200;
  int RECT_HEIGHT = 30;
  int TEXT_SIZE = 16; 

  Textbox(int pos_x, int pos_y, String label) {
    _pos_x = pos_x;
    _pos_y = pos_y;
    _label = label;
  }

  void draw() {
    textSize(TEXT_SIZE);
    
    // Label
    fill(255); 
    text(_label, _pos_x, _pos_y);

    // Taustalaatikko
    fill(255);
    rect(_pos_x, _pos_y + 10, RECT_WIDTH, RECT_HEIGHT);

    // Teksti laatikon sisällä
    fill(0);
    text(_data, _pos_x + 8, _pos_y + TEXT_SIZE * 2);
  }
  
  // Palauttaa tähän mennessä kirjoitetut tiedot
  String get_data() {
    return _data;
  }
  
  boolean is_ready() {
    return _ready;
  }

  // Kutsu tätä keyPressed funktiossa
  void read_key() {
    if ((key >= 'A' && key <= 'z') || key == ' ') {
      _data = _data + key;
    }
    
    if(key == BACKSPACE && _data.length() > 0) {
      _data = _data.substring(0, _data.length()-1);
    }
    
    if(key == ENTER && _data.length() > 0) {
      _ready = true;
    }
  }
}



