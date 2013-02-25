PFont f;
OutPutStream striimi;
Textbox textbox;

String pelaajan_nimi = "";

void setup() {
  size(1024,768);
  striimi = new OutPutStream();
  textbox = new Textbox(width/2-100, height/2-30, "Pelaajan nimi");
}

void keyPressed() {
  textbox.read_key(); // kerro textboxille että uutta dataa key-muuttujassa
  println(textbox.get_data()); // tulosta tähän mennessä luetut kirjaimet konsoliin
}

int kahva = 0;

void draw() {
  
  if (kahva == 0) {
    background(0,150,200,40);
    textbox.display();
    if(textbox.is_ready()) {
      pelaajan_nimi = textbox.get_data();
      kahva = 1;
    }
  }
    
  if (kahva == 1){
    
    //tervehdiPelaajaa- funktion pitaisi saada nimi parametrina
    striimi.tervehdiPelaaja(pelaajan_nimi);
    kahva = 2;
    
  }
  
  else if (kahva == 2){
    
    striimi.aloitaPeli();
    kahva = 1;
    
  }
  

}
