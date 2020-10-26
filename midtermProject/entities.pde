// global vars for entities
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Shooter> shooters = new ArrayList<Shooter>();
Ship myShip = new Ship(shipDiam, new PVector(shipDiam, height/2));
Portal myPortal;

int slowMeter = 200;

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
    float imgScl = 1.4;
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
    // This is the hitbox of the ship, in case I want to see it
    //fill(255);
    //ellipse(loc.x, loc.y, diam, diam);
  }
  
  boolean setMove(int k, boolean b){
    // Nice, smooth, spicy diagonal movement
    // WHY WAS THIS SO HARD IN PROCESSING
    switch(k){
      case +'W':
      case UP:
        return isUp = b;
   
      case +'S':
      case DOWN:
        return isDown = b;
   
      case +'A':
      case LEFT:
        return isLeft = b;
   
      case +'D':
      case RIGHT:
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

class Shooter{
  PVector loc;
  PVector dir;
  
  // Frequency of shooting (important for Berserker)
  int freq;
  
  // SHOOTER TYPES:
  // 0 - regular, shoots at set direction
  // 1 - sniper, shoots in player's direction
  // 2 - berserker, rotates around rapidly, shooting in all directions
  int type;
  
  // Theta value for rotations for berserker
  float theta = 0;
  
  Shooter(int t, PVector l, int f, PVector d){
    // Constructor for Regular, which takes a set direction
    loc = l.copy();
    dir = d.copy();    
    freq = f;
    type = t;
  }
  
  Shooter(int t, PVector l, int f){
    // Constructor for Berserker and Sniper, which don't take a set direction
    loc = l.copy();
    dir = new PVector(0,0);   
    freq = f;
    type = t;
  }
  
  void shootBullet(){
    theta += 0.1;
    if(frameCount % (freq/currentSpeed) == 0){
      if(type == 0){
        // REGULAR - just shoot in provided direction
        bullets.add(new Bullet(loc, dir));
      }
      else if(type == 1){
        // SNIPER - shoot in direction of player
        PVector d = PVector.sub(myShip.loc, loc);
        bullets.add(new Bullet(loc, d.normalize()));
      }
      else if(type == 2){
        // BERSERKER - shoot in a spiral pattern
        PVector d = new PVector(cos(theta),sin(theta));
        bullets.add(new Bullet(loc, d));
      }
    }
  }
  
  void displayShooter(){
    fill(255);
    imageMode(CENTER);
    image(shooty, loc.x, loc.y);
    //ellipse(loc.x, loc.y, 100, 100);
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
    image(portal, loc.x, loc.y, shipDiam*1.4, shipDiam*1.4);
    //ellipse(loc.x, loc.y, shipDiam, shipDiam);
  }
}
