ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Shooter> shooters = new ArrayList<Shooter>();
Ship myShip;
Portal myPortal;

void level1(){
  gameOn = true;
  
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height/2));
  myPortal = new Portal(new PVector(width-shipDiam, height/2));
  
  
  // Initialize shooters for this level
  shooters.add(new Shooter(new PVector(width/4, 0), new PVector(1, 1), 60));
  shooters.add(new Shooter(new PVector(width/2, height), new PVector(0, -1), 60));
  shooters.add(new Shooter(new PVector(width*0.75, 0), new PVector(0, 1), 60));
}

class Ship{
  PVector loc = new PVector();
  int diam;  
  
  boolean isUp, isLeft, isRight, isDown;
  
  Ship(int d, PVector l){
    // Set ship diameter
    diam = d;
    loc = l.get();
  }
  
  void displayShip(){
    fill(255);
    ellipse(loc.x, loc.y, diam, diam);
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
    loc.x = constrain(loc.x + currentVel*(int(isRight) - int(isLeft)), r, width  - r);
    loc.y = constrain(loc.y + currentVel*(int(isDown)  - int(isUp)),   r, height - r);
  }
}

class Shooter{
  PVector loc;
  PVector dir;
  int freq;
  
  Shooter(PVector l, PVector d, int f){
    loc = l.get();
    dir = d.get();    
    freq = f;
  }
  
  void shootBullet(){
    if(frameCount % (freq/currentVel) == 0){
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
    loc = l.get();
    vel = v.get();
  }
  
  void updateBullet(){
    loc.add(PVector.mult(vel, currentVel));
  }
  
  void displayBullet() {
    for(int i = 0; i < 7; i++){
      fill(255, 153, 20, 160);
      noStroke();
      ellipse(loc.x - vel.x*(i+1)*3, loc.y - vel.y*(i+1)*3, 8-i, 8-i);
    }
    fill(255);
    ellipse(loc.x, loc.y, 8, 8);
  }
}

class Portal{
  PVector loc;
  
  Portal(PVector l){
    loc = l.get();
  }
  
  void displayPortal(){
    fill(143, 232, 65);
    ellipse(loc.x, loc.y, shipDiam, shipDiam);
  }
}
