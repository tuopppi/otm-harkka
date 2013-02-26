import java.util.*;

class Kentta {
  private List<PVector> _reitti;
  
  Kentta() {
    background(140,199,78);
    _reitti = new ArrayList<PVector>();
    _reitti.add(new PVector(6, 0));
    _reitti.add(new PVector(6, 1));
    _reitti.add(new PVector(6, 2));
    _reitti.add(new PVector(6, 3));
    _reitti.add(new PVector(6, 4));
    _reitti.add(new PVector(6, 5));
    _reitti.add(new PVector(7, 5));
    _reitti.add(new PVector(8, 5));
    _reitti.add(new PVector(9, 5));
    _reitti.add(new PVector(9, 6));
    _reitti.add(new PVector(9, 7));
    _reitti.add(new PVector(9, 8));
    _reitti.add(new PVector(9, 9));
    _reitti.add(new PVector(8, 9));
    _reitti.add(new PVector(7, 9));
    _reitti.add(new PVector(6, 9));
    _reitti.add(new PVector(5, 9));
    _reitti.add(new PVector(5, 10));
    _reitti.add(new PVector(5, 11));
  }
  
  PVector get_coord(int x, int y) {
    return new PVector((int)(x/50), (int)(y/50));
  }
  
  Iterator aloitusruutu() {
    return _reitti.iterator();
  }
  
  boolean is_free(PVector k) {
    return !_reitti.contains(k);
  }
  
  void set_color(PVector kk) {
    noStroke();
    fill(212,178,68);
    rectMode(CORNER);
    rect(kk.x*50, kk.y*50, 50, 50);
  }
  
  void draw() {
    
    for(int i = 1; i < 12; i++) {
      //line(i * 50,0, i*50,height);
      //line(0, i * 50, width, i*50);
    }
    
    Iterator it=_reitti.iterator();
    while(it.hasNext()) {
      this.set_color((PVector)it.next());
    }

  }
  
}

