HScrollbar h1 = new HScrollbar(50, 50, 200, 16, 5, 1, 101, "Densidade de Carros");
HScrollbar h2 = new HScrollbar(50, 75, 200, 16, 5, 1, 21, "Velocidade Máxima");

int NUMCARS = h1.getVal();
int VELOCIDADE = h2.getVal();

Pista[] pista = new Pista[4];
Carro[] c = new Carro[100];


void setup() {
  size(1000, 800, P3D);
  background(0);
  lights();
  
  for (int i = 0; i < pista.length; i++) {
    pista[i] = new Pista(i);
  }
  
  setCruzamentos();
  
  for (int i = 0; i < c.length; i++) {
    c[i] = new Carro(i, VELOCIDADE);
  }
  
}

void draw() {
  drawBackground();
  drawStreet();
  atualizaCruzamentos();
  atualizaCarros();
  h1.update();
  NUMCARS = h1.getVal();
  h1.display();
  
  h2.update();
  h2.display();
}

void drawBackground() {
  background(0);
  noStroke();
  pushMatrix();
  translate(width/2, height/2, 108);
  rotateX(-PI/4);
  rotateY(PI/4);
  fill(140, 131, 127);
  translate(0, 1, 0);
  box(100000, 1, 100000);
  popMatrix();
}

void drawStreet() {
  for (int i = 0; i < pista.length; i++) {
    pista[i].desenhaPista();
  }
}

void atualizaCarros() {
  VELOCIDADE = h2.getVal();
  for (int i = 0; i < c.length; i++) {
    c[i].setVelocidade(VELOCIDADE);
    if (i < NUMCARS) {
      c[i].ativaCarro(pista);
      c[i].moveCar();
      c[i].drawCar();
    } else {
      c[i].removeCar();
    }
  }
}

void setCruzamentos() {
  for (int i = 0; i < pista.length; i++) {
    int aberto = int(random(2));
    pista[i].cruzamento_01_aberto = aberto;
    pista[i].p1.aberto = aberto;
    pista[(i + 3) % 4].cruzamento_02_aberto = (aberto + 1) % 2;
    pista[(i + 3) % 4].p2.aberto = (aberto + 1) % 2;
    
    if (aberto == 1) {
      pista[i].cruzamento_01_aberto_horario = millis() / 1000.0;
    } else {
      pista[(i + 3) % 4].cruzamento_02_aberto_horario = millis() / 1000.0;
    }
  }
}

void atualizaCruzamentos() {
  for (int i = 0; i < pista.length; i++) {
    if (pista[i].cruzamento_01_aberto == 1) {
      float seconds = millis() / 1000.0;
      float tempoAmarelo = (pista[i].cruzamento_01_tempo / 5) * 4;
      
      if (seconds > pista[i].cruzamento_01_aberto_horario + tempoAmarelo) {
        pista[i].cruzamento_01_aberto = 2;
        pista[i].p1.aberto = 2;
      }
    }
    
    if (pista[i].cruzamento_02_aberto == 1) {
      float seconds = millis() / 1000.0;
      float tempoAmarelo = (pista[i].cruzamento_02_tempo / 5) * 4;
      
      if (seconds > pista[i].cruzamento_02_aberto_horario + tempoAmarelo) {
        pista[i].cruzamento_02_aberto = 2;
        pista[i].p2.aberto = 2;
      }
    }
    
    if (pista[i].cruzamento_01_aberto == 2) {
      float seconds = millis() / 1000.0;
      if (seconds > pista[i].cruzamento_01_aberto_horario + pista[i].cruzamento_01_tempo) {
        pista[i].cruzamento_01_aberto = 0;
        pista[i].p1.aberto = 0;
        pista[i].cruzamento_01_aberto_horario = -1;
        pista[(i + 3) % 4].cruzamento_02_aberto = 3;
        pista[(i + 3) % 4].cruzamento_02_delay = millis() / 1000.0; 
      }
    }
    
    if (pista[i].cruzamento_02_aberto == 2) {
      float seconds = millis() / 1000.0;
      if (seconds > pista[i].cruzamento_02_aberto_horario + pista[i].cruzamento_02_tempo) {
        pista[i].cruzamento_02_aberto = 0;
        pista[i].p2.aberto = 0;
        pista[i].cruzamento_02_aberto_horario = -1;
        pista[(i + 1) % 4].cruzamento_01_aberto = 3;
        pista[(i + 1) % 4].cruzamento_01_delay = millis() / 1000.0;
      }
    }
    
    if (pista[i].cruzamento_01_aberto == 3) {
      float seconds = millis() / 1000.0;
      if (seconds > pista[i].cruzamento_01_delay + 0.5) {
        pista[i].cruzamento_01_aberto = 1;
        pista[i].p1.aberto = 1;
        pista[i].cruzamento_01_aberto_horario = millis() / 1000.0; 
        pista[i].cruzamento_01_tempo = random(2, 10);
      }
    }
    
    if (pista[i].cruzamento_02_aberto == 3) {
      float seconds = millis() / 1000.0;
      if (seconds > pista[i].cruzamento_02_delay + 0.5) {
        pista[i].cruzamento_02_aberto = 1;
        pista[i].p2.aberto = 1;
        pista[i].cruzamento_02_aberto_horario = millis() / 1000.0; 
        pista[i].cruzamento_02_tempo = random(2, 10);
      }
    }
  }
}