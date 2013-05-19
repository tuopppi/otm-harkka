class OutPutStream  {    
  
  void tervehdiPelaaja(String pelaaja)  {    
    background(0,150,200,40);
    textFont(valikkoFontti,32);                 
    fill(20);                        
    text("Tervetuloa pelaamaan " + pelaaja + "!",width/4,height/2);  //Display Text
  } 
  
  void aloitaPeli(){
    background(0,150,200,40);
    textFont(valikkoFontti,32);                
    fill(20);                        
    text("Peli alkoi!",width/4,height/2);  //Display Text
  }

}  

