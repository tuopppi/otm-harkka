/* Kentta-luokka
 *  Kentta sisältää yksittäisen kentän kartan muodon,
 *  kartan värin, taustavärin. Lopulta myös tiedot
 *  vihollisista.
 */
class Kentta {
 
  Kentta(color taustaVari, color reittiVari, int[] rX, int[] rY) {
    _taustaVari = taustaVari;
    _reittiVari = reittiVari;
    _rX = rX;
    _rY = rY;
  }
 
  public void draw() {
   
    //piirretään trippaileva tausta
    piirraTausta();
      
    noStroke();
    for(int i = 0; i < _rX.length-1; ++i) {
      fill(_reittiVari);
      
      //reitin yksittäisten päätepisteiden oltava toisella;
      //JOKO samalla y-koordinaatilla
      //TAI samalla x-koordinaatilla
      //ja vain toisella
      if(_rY[i] == _rY[i+1] && _rX[i] != _rX[i+1]) {
        rect(_rX[i], _rY[i]-0.5*_reittiPaksuus, _rX[i+1]-_rX[i], _reittiPaksuus);
        pushMatrix();
          translate(-0.5*_reittiPaksuus, 0*_reittiPaksuus);
          rect(_rX[i], _rY[i]-0.5*_reittiPaksuus, _reittiPaksuus, _reittiPaksuus, _reittiPyoreys);
        popMatrix();
      }
      else if(_rX[i] == _rX[i+1]) {
        rect(_rX[i]-0.5*_reittiPaksuus, _rY[i], _reittiPaksuus, _rY[i+1]-_rY[i]);
        pushMatrix();
          translate(0*_reittiPaksuus, -0.5*_reittiPaksuus);
          rect(_rX[i]-0.5*_reittiPaksuus, _rY[i], _reittiPaksuus, _reittiPaksuus, _reittiPyoreys);
        popMatrix();
      }
      else {
        println("karttavirhe"); //jos tyhmä kartantekijä on tehnyt virheen,
        exit();
      }
    }

  }
  
  private void piirraTausta() {
    //20*20 pikseleistä jotain hienoa _taustaVariin liittyvää
    final int koko = 20;
      
    int aika1 = (millis()/100)%500 + 12;
    if(aika1 > 256) {
      aika1 = 256 - (aika1 - 256);
    }
      
    pushMatrix();
    translate(width/2, 0);
    for(int y = 0; y < height/koko; ++y) {
      for(int x = width/(-2*koko); x < width/(2*koko); ++x) {
        //huippuunsa viritetty matrix-efektialgoritmi
        fill(((red(_taustaVari)*sin(-1*sqrt(y*aika1)/200-x*aika1/200)*aika1/10))%255-230,
                 ((green(_taustaVari)*sin(-1*sqrt(y*aika1)/200-x*aika1/200)*aika1/10)%255)-230,
                 ((blue(_taustaVari)*sin(-1*sqrt(y*aika1)/200-x*aika1/200)*aika1/10)%255)-230);
        rect(x*koko, y*koko, koko, koko);
      }
    }
    popMatrix();
  }
    
  private color _taustaVari;
  private color _reittiVari;
  private final int _reittiPaksuus = 30;
  private final int _reittiPyoreys = 12;
  
  private int[] _rX;
  private int[] _rY;
 
}

