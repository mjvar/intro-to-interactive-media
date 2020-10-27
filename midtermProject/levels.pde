// SHOOTER TYPES:
// 0 - regular, shoots at set direction
// 1 - sniper, shoots in player's direction
// 2 - berserker, rotates around rapidly, shooting in all directions

void level1(){
  // Easy level, introduce basic concepts
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height/2));
  myPortal = new Portal(new PVector(width-shipDiam, height/2));
  
  shooters.add(new Shooter(0, new PVector(width/4, 0), 60, new PVector(0, 1)));
  shooters.add(new Shooter(0, new PVector(width/2, height), 60, new PVector(0, -1)));
  shooters.add(new Shooter(0, new PVector(width*0.75, 0), 60, new PVector(0, 1)));
  
  globalResets();
}

void level2(){     
  // Easy as well, just showing you bullets can be diagonal
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height/2));
  myPortal = new Portal(new PVector(width-shipDiam, height/2));
 
  shooters.add(new Shooter(0, new PVector(300, 0), 60, new PVector(1, 1)));
  shooters.add(new Shooter(0, new PVector(300, height), 60, new PVector(1, -1)));
  
  globalResets();
}

void level3(){     
  // What if we combined them?
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height*0.9));
  myPortal = new Portal(new PVector(width-shipDiam, height*0.05));
 
  shooters.add(new Shooter(0, new PVector(0, 250), 60, new PVector(1, 0)));
  shooters.add(new Shooter(0, new PVector(0, 400), 60, new PVector(1, 0)));
  shooters.add(new Shooter(0, new PVector(0, 550), 60, new PVector(1, 0)));
  shooters.add(new Shooter(0, new PVector(250, height), 60, new PVector(0, -1)));
  shooters.add(new Shooter(0, new PVector(400, height), 60, new PVector(0, -1)));
  shooters.add(new Shooter(0, new PVector(550, height), 60, new PVector(0, -1)));
  shooters.add(new Shooter(0, new PVector(700, 0), 60, new PVector(1, 1)));
  shooters.add(new Shooter(0, new PVector(850, 0), 60, new PVector(1, 1)));
  shooters.add(new Shooter(0, new PVector(1000, 0), 60, new PVector(1, 1)));
  
  globalResets();
}

void level4(){
  // What if we combined them and made it even harder?
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height/2));
  myPortal = new Portal(new PVector(width-shipDiam, height/2));
  
  shooters.add(new Shooter(0, new PVector(0, 0), 60, new PVector(1, 0.6)));
  shooters.add(new Shooter(0, new PVector(0, height), 60, new PVector(1, -0.6)));
  shooters.add(new Shooter(0, new PVector(width, 0), 60, new PVector(-1, 1)));
  shooters.add(new Shooter(0, new PVector(width, height), 60, new PVector(-1, -1)));
  shooters.add(new Shooter(0, new PVector(width/3, 0), 60, new PVector(0, 1)));
  shooters.add(new Shooter(0, new PVector(2*width/3, height), 60, new PVector(0, -1)));
  
  globalResets();
}

void level5(){
  // Teach the player "HEY MY BULLETS CAN FOLLOW YOU"
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height*0.1));
  myPortal = new Portal(new PVector(width-shipDiam, height*0.9));
  
  shooters.add(new Shooter(0, new PVector(width/3, 0), 60, new PVector(0, 1)));
  shooters.add(new Shooter(1, new PVector(2*width/3, height), 60));
  
  globalResets();
}

void level6(){
  // Teach the player "I'M STILL FOLLOWING YOU"
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height*0.1));
  myPortal = new Portal(new PVector(width-shipDiam, height*0.9));
  
  shooters.add(new Shooter(0, new PVector(width/2, 0), 60, new PVector(0, 1)));
  shooters.add(new Shooter(1, new PVector(width/2, height), 60));
  shooters.add(new Shooter(1, new PVector(3*width/4, 0), 60));
  shooters.add(new Shooter(0, new PVector(3*width/4, height), 60, new PVector(0, -1)));  
  
  globalResets();
}

void level7(){
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height/2));
  myPortal = new Portal(new PVector(width-shipDiam, height/2));
  
  shooters.add(new Shooter(1, new PVector(width/2, 0), 60));
  shooters.add(new Shooter(1, new PVector(width/2, height), 60));
  shooters.add(new Shooter(1, new PVector(3*width/4, height), 60));
  shooters.add(new Shooter(1, new PVector(3*width/4, 0), 60));
  shooters.add(new Shooter(0, new PVector(width, 0), 60, new PVector(-1, 1)));
  shooters.add(new Shooter(0, new PVector(width, height), 60, new PVector(-1, -1)));
  
  globalResets();
}

void level8(){
  // Teach the player true pain
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height*0.1));
  myPortal = new Portal(new PVector(width-shipDiam, height*0.9));
  
  shooters.add(new Shooter(2, new PVector(width/2, height/2), 6));
  
  globalResets();
}

void level9(){
  // This is getting really difficult
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height*0.1));
  myPortal = new Portal(new PVector(width-shipDiam, height*0.9));
  
  shooters.add(new Shooter(2, new PVector(width/3, height/2), 12));
  shooters.add(new Shooter(2, new PVector(2*width/3, height/2), 12));
  
  globalResets();
}

void level10(){
  // TRY THIS
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height/2));
  myPortal = new Portal(new PVector(width-shipDiam, height/2));
  
  shooters.add(new Shooter(1, new PVector(width/3, 0), 60));
  shooters.add(new Shooter(1, new PVector(width/3, height), 60));
  shooters.add(new Shooter(2, new PVector(5*width/7, height/2), 6));
  
  globalResets();
}

void level11(){
  // and this
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height/2));
  myPortal = new Portal(new PVector(width-shipDiam, height/2));
  
  shooters.add(new Shooter(1, new PVector(4*width/7, height/2), 60));;
  shooters.add(new Shooter(2, new PVector(5*width/7, 3*height/8), 9));
  shooters.add(new Shooter(2, new PVector(5*width/7, 5*height/8), 9));
  
  globalResets();
}

void level12(){
  // Pain: The Level
  bullets = new ArrayList<Bullet>();
  shooters = new ArrayList<Shooter>();
  
  myShip = new Ship(shipDiam, new PVector(shipDiam, height/2));
  myPortal = new Portal(new PVector(width-shipDiam, height/2));
  
  shooters.add(new Shooter(2, new PVector(4*width/7, 0), 9));
  shooters.add(new Shooter(2, new PVector(4*width/7, height), 9));
  shooters.add(new Shooter(2, new PVector(3*width/7, 0), 9));
  shooters.add(new Shooter(2, new PVector(3*width/7, height), 9));
  shooters.add(new Shooter(1, new PVector(0, height), 60));
  
  globalResets();
}
