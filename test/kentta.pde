import java.util.*;

class Kentta {
  private List<PVector> _reitti;
  private List<Ormy> _hirviot;
  private Laskuri _laskuri;
  
  Kentta(Laskuri laskuri) {
    _laskuri = laskuri;
    
    background(140,199,78);
       
    // Määritellään ruudut jotka ovat osa hirviöiden reittiä
    _reitti = new ArrayList<PVector>();
    _reitti.addAll(Arrays.asList(
      new PVector(6, -1), new PVector(6, 0), new PVector(6, 1), new PVector(6, 2), // ...
      new PVector(6, 3), new PVector(6, 4), new PVector(6, 5), //alas
      new PVector(7, 5), new PVector(8, 5), new PVector(9, 5), // oikealle
      new PVector(9, 6), new PVector(9, 7) , new PVector(9, 8), new PVector(9, 9), // alas
      new PVector(8, 9), new PVector(7, 9), new PVector(6, 9), new PVector(5, 9), // vasemmalle
      new PVector(5, 10), new PVector(5, 11), new PVector(5, 12) // alas
      
    ));
    
    // Spawnaa hirviöt
    // !!! Huom, määrittele reitti ennen hirviöitä
    _hirviot = new ArrayList<Ormy>();
    spawnaaHirviot();    
  }
  
  void spawnaaHirviot() {
    for(int i = 10; i < 80; i++) {
      _hirviot.add(new Ormy(_reitti, i*10, color(i*10 % 255)));
    }
  }
  
  PVector get_coord(int x, int y) {
    PVector tmpcoord = new PVector((int)(x/50), (int)(y/50));
    if(tmpcoord.x > 11) {
      tmpcoord.x = 11;
    }
    if(tmpcoord.y > 11) {
      tmpcoord.y = 11;
    }
    return tmpcoord;
  }
  
  boolean is_free(PVector k) {
    
    boolean toisenTorninPaalle = false;
    for(int i=0; i<tornienLkm-1; ++i) {
      if(abs(tornit[i]._x - (mouseX)) < 25 && abs(tornit[i]._y - (mouseY)) < 25/*tornit[i]._x, tornit[i]._x) == get_coord(mouseX, mouseY)*/) {
        toisenTorninPaalle = true;
        break;
      }
    }
    //jos ei reitillä eikä toisen tornin päällä -> true
    return !_reitti.contains(k) && !toisenTorninPaalle;
  }
  
  void set_color(PVector kk) {
    noStroke();
    fill(212,178,68);
    rectMode(CORNER);
    rect(kk.x*50, kk.y*50, 50, 50);
  }
  
  void draw() {
    
    // Väritellään reitin ruudut uudelleen, koska niiden yli on kulkenut örmyjä jotka muuten jättävät 
    // värivanan peräänsä
    Iterator ruudut_it = _reitti.iterator();
    while(ruudut_it.hasNext()) {
      this.set_color((PVector)ruudut_it.next());
    }
    
    // Tarkistetaan onko hirviö kuollut, jos on poistetaan listalta
    Iterator hirviot_it = _hirviot.iterator();
    while(hirviot_it.hasNext()) {
      Ormy o = (Ormy)(hirviot_it.next());
      if(o.elossa()) {
        o.draw();
      } else {
        hirviot_it.remove();
      }      
    }
    
    if(laskuri.getTime() <= 0) {
      spawnaaHirviot();
      laskuri.setTime(5); // uudet hirviöt 5s jälkeen
    }

  }
  
}

