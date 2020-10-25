import processing.sound.*;
// Sound files for game audio
SoundFile gameMusic;
SoundFile deathSound;
SoundFile winSound;

PImage[] deathScreens = new PImage[4];
PImage[] winScreens = new PImage[4];

PImage base;
PImage u;
PImage d;
PImage l;
PImage r;
PImage ul;
PImage ur;
PImage dl;
PImage dr;

// Music control things
boolean deathSoundPlayed = false;
boolean winSoundPlayed = false;
float musicRate = 1;

// Global var for movement
float currentSpeed = 3; 

int shipDiam = 40;

// Game control things
int currentLevel = 0;
boolean gameOn = false;
boolean levelWin = false;
boolean levelSetup = false;

// Frame iterator for win/death screens
int fIt = 0;

void setup() {
  size(1200, 700);
    
  // Loading game sounds
  gameMusic = new SoundFile(this, "game-music.mp3");
  deathSound = new SoundFile(this, "death-sound.mp3");
  winSound = new SoundFile(this, "win-sound.mp3");
  
  base = loadImage("images/base.png");
  u = loadImage("images/u.png");
  ul = loadImage("images/ul.png");
  ur = loadImage("images/ur.png");
  d = loadImage("images/d.png");
  dl = loadImage("images/dl.png");
  dr = loadImage("images/dr.png");
  l = loadImage("images/l.png");
  r = loadImage("images/r.png");
  
  for(int i = 0; i <= 3; i++){
    deathScreens[i] = loadImage("images/death" + str(i) + ".png");
    winScreens[i] = loadImage("images/win" + str(i) + ".png");
  }
}      

void draw() {
  // Setting rate of music
  gameMusic.rate(musicRate);
  
  // Run the game
  runGame();
}

void keyPressed(){
  if(key == ' '){
    musicRate = 0.8;
    currentSpeed = 0.5;
  }
  else {
    myShip.setMove(keyCode, true);
  }
}

void keyReleased(){
  if(key == ' '){
    musicRate = 1;
    currentSpeed = 3;
  }
  else {
    myShip.setMove(keyCode, false);
  }
}
