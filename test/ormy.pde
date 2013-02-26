import java.util.*;

class Ormy {
  Iterator _sijainti;
  PVector pos;
  Ormy(Kentta kentta) {
    _sijainti = kentta.aloitusruutu();
    this.move();
  }
  
  void move() {
     try {
       pos = (PVector)_sijainti.next();
     } catch (NoSuchElementException e) {
       _sijainti = kentta.aloitusruutu();
     }
  }
  
  void draw() {
    ellipse((int)pos.x*50+25, (int)pos.y*50+25, 10, 10);
  }
  
}
