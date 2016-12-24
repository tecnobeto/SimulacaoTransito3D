class Pista {
  int id;
  int tamanhoX;
  int tamanhoY;
  int tamanhoZ;
  
  float cruzamento_01_pos;
  int cruzamento_01_aberto;
  float cruzamento_01_tempo;
  float cruzamento_01_aberto_horario;
  float cruzamento_01_delay;
  Poste p1;
  
  float cruzamento_02_pos;
  int cruzamento_02_aberto;
  float cruzamento_02_tempo;
  float cruzamento_02_aberto_horario;
  float cruzamento_02_delay;
  Poste p2;
  
  ArrayList<Carro> listaCarros = new ArrayList();
  
  int countCarsPassed;
  
  Pista(int id) {
    this.id = id;
    this.tamanhoX = 100000;
    this.tamanhoY = 100;
    this.tamanhoZ = 10;
    
    switch(this.id) {
    case 0:
      this.cruzamento_01_pos = 290;   
      this.cruzamento_02_pos = 640;
      p1 = new Poste(380, 40);
      p2 = new Poste(750, 40);
      break;
    case 1:
      this.cruzamento_01_pos = 190;   
      this.cruzamento_02_pos = 530;
      p1 = new Poste(280, 40);
      p2 = new Poste(640, 40);
      break;
    case 2:
      this.cruzamento_01_pos = 980;   
      this.cruzamento_02_pos = 1340;
      p1 = new Poste(1080, 40);
      p2 = new Poste(1450, 40);
      break;
    case 3:
      this.cruzamento_01_pos = 595;   
      this.cruzamento_02_pos = 945;
      p1 = new Poste(695, 40);
      p2 = new Poste(1055, 40);
      break;
    }
    
    this.cruzamento_01_aberto = 0;
    this.cruzamento_02_aberto = 0;
    
    this.cruzamento_01_tempo = random(2, 10);
    this.cruzamento_02_tempo = random(2, 10);
    
    this.countCarsPassed = 0;
  }
  
  void desenhaPista() {
    pushMatrix();
    fill(45);
    strokeWeight(0.1);
    stroke(227, 179, 44);
    translate(width/2, height/2, 110);
    rotateX(-PI/4);
    rotateY(PI/4);
    rotateX(PI/2);
  
    switch (this.id) {
    case 0:
      translate(-400, 90, 0);
      break;
    case 1:
      rotateZ(-PI/2);
      translate(-300, 285, 0);
      break;
    case 2:
      rotateZ(PI);
      translate(-1300, 275, 0);
      break;
    case 3:
      rotateZ(PI / 2);
      translate(-900, 85, 0);
      break;
    }

    box(tamanhoX, tamanhoY, tamanhoZ);   
    
    p1.desenhaPoste();
    p2.desenhaPoste();
    popMatrix();
  }
}