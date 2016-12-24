class Carro {
  int id;
  Pista pista; // random
  float posicao; // Posicao que o carro estara ao longo da pista
  int velocidadeMax;
  int velocidade;
  int aceleracao;
  int tamanhoX;
  int tamanhoY;
  int tamanhoZ;
  boolean ativo;
  boolean cruzamento_01_ok;
  boolean cruzamento_02_ok;

  Carro(int id, int velocidade) {
    this.id = id;
    this.velocidadeMax = 10;
    this.velocidade = velocidade;
    this.aceleracao = 2;
    this.tamanhoX = 40;
    this.tamanhoY = 20;
    this.tamanhoZ = 10;
    this.posicao = 0;
    this.ativo = false;
    this.cruzamento_01_ok = false;
    this.cruzamento_02_ok = false;
  }

  void setVelocidade(int vel) {
    this.velocidade = vel;
  }

  void drawCar() {
    if (this.ativo == true) {
      pushMatrix();
      fill(109, 33, 60);
      strokeWeight(1.3);
      stroke(0);
      translate(width/2, height/2, 150);
      rotateX(-PI/4);
      rotateY(PI/4);
      rotateX(PI/2);
    
      //println(this.posicao);
    
      switch (this.pista.id) {
      case 0:
        translate(-400, 80, 0);
        break;
      case 1:
        rotateZ(-PI/2);
        translate(-300, 275, 0);
        break;
      case 2:
        rotateZ(PI);
        translate(-1300, 265, 0);
        break;
      case 3:
        rotateZ(PI / 2);
        translate(-900, 75, 0);
        break;
      }
  
      translate(this.posicao, 0, 0);
      box(tamanhoX, tamanhoY, tamanhoZ);
      
      float maxPosition = 0;
      
      switch (this.pista.id) {
      case 0:
        maxPosition = 1300;
        break;
      case 1:
        maxPosition = 1500;
        break;
      case 2:
        maxPosition = 1650;
        break;
      case 3:
        maxPosition = 1300;
        break;
      }
      
      if (this.posicao >= maxPosition) {
        this.removeCar();
      }
      
      popMatrix();
    }
  } 
  
  void removeCar() {
    if (this.pista != null) {
      this.pista.listaCarros.remove(this);
      this.pista.countCarsPassed++;
    }
    //println("Pista " + this.pista.id + " Passou " + this.pista.countCarsPassed + " Carros");
    this.ativo = false;
    this.posicao = 0;
    this.cruzamento_01_ok = false;
    this.cruzamento_02_ok = false;
  }
  
  void moveCar() {
    if(this.ativo) {
      boolean permiteMov = true;
      boolean permiteMovCar = true;
      float newPosition = (this.posicao + this.velocidade);
      
      permiteMov = verificaCruzamentos();
      permiteMovCar = verificaCarros();
      
      if (permiteMov && permiteMovCar) {
        this.posicao = newPosition;
      }
    }
  }
  
  boolean verificaCarros() {
    for (Carro car : this.pista.listaCarros) {
      if (car != this) {
        if (car.posicao > this.posicao && car.posicao <= (this.posicao + this.tamanhoX + 20)) {
          return false;
        }
      }
    }
    
    return true;
  }
  
  boolean verificaCruzamentos() {
    float newPosition = (this.posicao + this.velocidade);
    
    if ((newPosition + this.tamanhoX) >= this.pista.cruzamento_01_pos && !this.cruzamento_01_ok) {
      if (this.pista.cruzamento_01_aberto != 1 && this.pista.cruzamento_01_aberto != 2) {
        return false;
      } else {
        for (Carro car : this.pista.listaCarros) {
          if (car != this) {
            if (car.posicao > this.posicao && car.posicao <= (this.posicao + this.tamanhoX + 140)) {
              return false;
            } 
          }
        }
        this.cruzamento_01_ok = true;
        return true;
      }
    }  
    
    if ((newPosition + this.tamanhoX) >= this.pista.cruzamento_02_pos && !this.cruzamento_02_ok) {
      if (this.pista.cruzamento_02_aberto != 1 && this.pista.cruzamento_02_aberto != 2) {
        return false;
      } else {
        for (Carro car : this.pista.listaCarros) {
          if (car != this) {
            if (car.posicao > this.posicao && car.posicao <= (this.posicao + this.tamanhoX + 140)) {
              return false;
            } 
          }
        }
        this.cruzamento_02_ok = true;
        return true;
      }
    }
    return true;
  }
  
  void ativaCarro(Pista[] pista) {
    if (!this.ativo) {
      int ativa = int(random(250));
      if (ativa == 0) {
        int aux = int(random(4));
        this.pista = pista[aux];
        this.ativo = true;
        this.pista.listaCarros.add(this);
      } 
    }
  }
}