// global vars for entities
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Shooter> shooters = new ArrayList<Shooter>();
ArrayList<Particle> particles = new ArrayList<Particle>();
Ship myShip = new Ship(shipDiam, new PVector(shipDiam, height/2));
Portal myPortal;

void level1(){
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height/2));
  myPortal = new Portal(new PVector(width-shipDiam, height/2));
  
  // Initialize shooters for this level
  shooters.add(new Shooter(new PVector(width/4, 0), new PVector(0, 1), 60));
  shooters.add(new Shooter(new PVector(width/2, height), new PVector(0, -1), 60));
  shooters.add(new Shooter(new PVector(width*0.75, 0), new PVector(0, 1), 60));
  
  globalResets();
}

void level2(){     
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height/2));
  myPortal = new Portal(new PVector(width-shipDiam, height/2));
 
  // Initialize shooters for this level
  shooters.add(new Shooter(new PVector(300, 0), new PVector(1, 1), 60));
  shooters.add(new Shooter(new PVector(300, height), new PVector(1, -1), 60));
  
  globalResets();
}

void level3(){     
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height*0.9));
  myPortal = new Portal(new PVector(width-shipDiam, height*0.1));
 
  // Initialize shooters for this level
  shooters.add(new Shooter(new PVector(0, 250), new PVector(1, 0), 60));
  shooters.add(new Shooter(new PVector(0, 400), new PVector(1, 0), 60));
  shooters.add(new Shooter(new PVector(0, 550), new PVector(1, 0), 60));
  shooters.add(new Shooter(new PVector(250, height), new PVector(0, -1), 60));
  shooters.add(new Shooter(new PVector(400, height), new PVector(0, -1), 60));
  shooters.add(new Shooter(new PVector(550, height), new PVector(0, -1), 60));
  shooters.add(new Shooter(new PVector(700, 0), new PVector(1, 1), 60));
  shooters.add(new Shooter(new PVector(850, 0), new PVector(1, 1), 60));
  shooters.add(new Shooter(new PVector(1000, 0), new PVector(1, 1), 60));
  
  globalResets();
}

class Ship{
  PVector loc = new PVector();
  int diam;  
  
  boolean isUp, isLeft, isRight, isDown;
  
  Ship(int d, PVector l){
    // Set ship diameter
    diam = d;
    loc = l.copy();
  }
  
  void displayShip(){
    float imgScl = 1.8;
    imageMode(CENTER);
    if(isUp){
      if(isLeft){
        image(dr, loc.x, loc.y, diam*imgScl, diam*imgScl);
      }
      else if(isRight){
        image(dl, loc.x, loc.y, diam*imgScl, diam*imgScl);
      }
      else{
        image(d, loc.x, loc.y, diam*imgScl, diam*imgScl);
      }
    }
    else if(isDown){
      if(isLeft){
        image(ur, loc.x, loc.y, diam*imgScl, diam*imgScl);
      }
      else if(isRight){
        image(ul, loc.x, loc.y, diam*imgScl, diam*imgScl);
      }
      else{
        image(u, loc.x, loc.y, diam*imgScl, diam*imgScl);
      }
    }
    else if(isLeft){
      image(r, loc.x, loc.y, diam*imgScl, diam*imgScl);
    }
    else if(isRight){
      image(l, loc.x, loc.y, diam*imgScl, diam*imgScl);
    }
    else{
      image(base, loc.x, loc.y, diam*imgScl, diam*imgScl);
    }
    //fill(255);
    //ellipse(loc.x, loc.y, diam, diam);
  }
  
  boolean setMove(int k, boolean b){
    switch(k){
      case +'W':
        return isUp = b;
      case +'A':
        return isLeft = b;
      case +'S':
        return isDown = b;
      case +'D':
        return isRight = b;
      default:
        return b;
    }
  }
  
  void moveShip(){
    // Move ship based on current active directions, constrained to canvas
    int r = diam >> 1;
    loc.x = constrain(loc.x + currentSpeed*(int(isRight) - int(isLeft)), r, width  - r);
    loc.y = constrain(loc.y + currentSpeed*(int(isDown)  - int(isUp)),   r, height - r);
  }
}

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float lifespan;

  Particle(PVector l, PVector v) {
    acc = new PVector(0, 0.05);
    vel = v.copy();
    loc = l.copy();
    lifespan = 255.0;
  }

  void updateParticles() {
    vel.add(acc);
    loc.add(vel);
    lifespan -= 1.0;
  }

  void displayParticles() {
    stroke(255, lifespan);
    fill(255, lifespan);
    ellipse(loc.x, loc.y, 8, 8);
  }

  boolean isDead() {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
}

class Shooter{
  PVector loc;
  PVector dir;
  int freq;
  
  Shooter(PVector l, PVector d, int f){
    loc = l.copy();
    dir = d.copy();    
    freq = f;
  }
  
  void shootBullet(){
    if(frameCount % (freq/currentSpeed) == 0){
      bullets.add(new Bullet(loc, dir));
    }
  }
  
  void displayShooter(){
    fill(255);
    ellipse(loc.x, loc.y, 100, 100);
  }
}

class Bullet{
  PVector loc;
  PVector vel;
  
  Bullet(PVector l, PVector v){
    loc = l.copy();
    vel = v.copy();
  }
  
  void updateBullet(){
    // Move bullet based on current game speed
    loc.add(PVector.mult(vel, currentSpeed));
  }
  
  void displayBullet() {
    // Display bullet with a trail
    for(int i = 0; i < 7; i++){
      fill(255, 153, 20, 160);
      noStroke();
      ellipse(loc.x - vel.x*(i+1)*3, loc.y - vel.y*(i+1)*3, 8-i, 8-i);
    }
    fill(255);
    rectMode(CENTER);
    rect(loc.x, loc.y, 8, 8);
  }
}

class Portal{
  // End goal for any given level
  PVector loc;
  
  Portal(PVector l){
    loc = l.copy();
  }
  
  void displayPortal(){
    fill(143, 232, 65);
    ellipse(loc.x, loc.y, shipDiam, shipDiam);
  }
}
