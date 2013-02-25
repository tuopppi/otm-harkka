class OutPutStream  {    
  
  void tervehdiPelaaja(String pelaaja)  {    
    
    f = createFont("Georgia",20,true); 
    background(0,150,200,40);
    textFont(f,32);                 
    fill(20);                        
    text("Tervetuloa pelaamaan " + pelaaja + "!",width/4,height/2);  //Display Text
    delay(2000);  
    
  } 
  
  void aloitaPeli(){
    
    f = createFont("Georgia",20,true); 
    background(0,150,200,40);
    textFont(f,32);                
    fill(20);                        
    text("Peli alkoi!",width/4,height/2);  //Display Text
    delay(2000); 
    
  }
   

}  

