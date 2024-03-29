import java.util.List;

class Ormy implements Comparable {

  private List<PVector> _reitti;
  // Monennessako ruudussa ollaan reitillä
  private int _pos_indx = 0; 
  
  // kuinka monen millisekunnin välein liikutaan yksi ruutu
  private int _nopeus;
  private int _prev_move_time = millis();
  private color _vari;
  float _hitpoints; 
  private PVector _xy_position;
 
    
  Ormy(List<PVector> reitti, int nopeus, color vari, float hitpoints) {
    _reitti = reitti;
    _nopeus = nopeus;
    _vari = vari;
    _hitpoints = hitpoints;
  }
 
  void draw() {
    this.move();
    
    if(elossa()) {
      
      _xy_position = smooth_position_xy();
      
      fill(_vari);
     
      ellipse(_xy_position.x, _xy_position.y, 20, 20);
    }
  }

  void vahingoita(float vahinko) {
    _hitpoints -= vahinko;
  }

  // se joka on lähimpänä maaliruutua tulee listassa ensimmäiseksi
  int compareTo(Object toinen) {
    return ((Ormy)toinen).getPosition() - this.getPosition();
  }

  int getPosition() {
    return _pos_indx;
  }

  PVector getXYPosition() {
    return _xy_position;
  }
  
  private boolean elossa() {
    return _hitpoints > 0;
  }
  
  // Siirtää örmyä yhden ruudun eteenpäin jos on kulunut riittävästi aikaa
  private void move() {
    // kun on kulunut @nopeus verran milliskunteja, siirrytään seuraavaan ruutuun
    if(_prev_move_time + _nopeus < millis()) {
      _prev_move_time = millis();
      _pos_indx++;
    }
    
    // ollaan vikassa ruudussa, kuole
    if(_pos_indx + 1 >= _reitti.size()) {
      _hitpoints = 0;
      _pos_indx = 0;
      pelaaja.vahenna_elamia();
    }
  }
  
  // Laskee mihin kohtaan örmy pitää piirtää, jotta saadaan siisti liukuva animaatio
  private PVector smooth_position_xy() {
    // laskeskellaan mihin suuntaan ollaan liikkumassa, 
    PVector now = (PVector)_reitti.get(_pos_indx);
    PVector next = (PVector)_reitti.get(_pos_indx+1);
    PVector _direction = PVector.sub(next, now);
    
    // Kuinka suuri osuus tämän aikablokin matkasta on kuljettu 0..1
    float partition = abs(millis() - _prev_move_time) / (float)_nopeus;
    
    //             |------ perusosa ----------------|   |-----------pehmeä animaatio-------|
    return new PVector(_reitti.get(_pos_indx).x*50+25 + (int)(_direction.x * partition * 50),
                       _reitti.get(_pos_indx).y*50+25 + (int)(_direction.y * partition * 50));
  }
  
}
