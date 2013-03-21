import javax.swing.Timer;
import java.awt.event.*;

class Laskuri{
  
  private int time;
  
  Laskuri(){
    time = 20;
  }
  
  Timer laskuri = new Timer(500, new ActionListener() {
    public void actionPerformed(ActionEvent e) {
      
      if(time > 0){
        --time;
      }
      else{
       time = 20; 
      }
    }
  });
  
  void starttaaLaskuri(){
    laskuri.start();  
  }
  
  void pysaytaLaskuri(){
    laskuri.stop();
  }
  
  public void setTime(int time){
    this.time = time;
  }
  
  public int getTime(){
    return time;
  }
  
  
   
}
