class Poste {
  int altura;
  int largura;
  int raioBola;
  int posX;
  int posY;
  int aberto;
  
  Poste(int posX, int posY) {
    this.altura = 50;
    this.largura = 5;
    this.raioBola = 6;
    this.posX = posX;
    this.posY = posY;
    this.aberto = 0;
  }
  
  void desenhaPoste() {
    pushMatrix();
    fill(30);
    strokeWeight(1);
    stroke(0);
    
    translate(this.posX, this.posY, 30);
    box(this.largura, this.largura, this.altura);
    translate(0, 0, (this.altura - 20));
    if (this.aberto == 1) {
      fill(0, 255, 0);
    } else if (this.aberto == 2) {
      fill(255, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    noStroke();
    sphere(this.raioBola);
    popMatrix();
  }
}