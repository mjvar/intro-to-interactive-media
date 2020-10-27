import processing.sound.*;
// Sound files for game audio
SoundFile gameMusic;
SoundFile deathSound;
SoundFile winSound;
SoundFile menuMusic;

// Menu/screen stuff
PImage[] deathScreens = new PImage[4];
PImage[] winScreens = new PImage[4];
PImage startScreen;
PImage bg;
PImage start;
PImage levels;

// Ship assets
PImage base;
PImage u;
PImage d;
PImage l;
PImage r;
PImage ul;
PImage ur;
PImage dl;
PImage dr;

// Other pics
PImage shooty;
PImage portal;

// Level icons
PImage[] lvs = new PImage[12];

// WHY DOES PROCESSING NOT HAVE THIS BUILT IN
// They already did it for mousePressed !!!!!
boolean mouseReleased = false;

// Music control things
boolean deathSoundPlayed = false;
boolean winSoundPlayed = false;
boolean menuMusicPlayed = false;
float musicRate = 1;

// Global var for movement
float currentSpeed = 3; 

int shipDiam = 40;

// Game control things
int currentLevel = 0;
boolean gameOn = false;
boolean levelWin = false;
boolean levelSetup = false;
boolean slowOn = false;

// Frame iterator for win/death screens
int fIt = 0;

void setup() {
  size(1200, 700);
    
  // Loading game sounds
  gameMusic = new SoundFile(this, "sounds/game-music.mp3");
  deathSound = new SoundFile(this, "sounds/death-sound.mp3");
  winSound = new SoundFile(this, "sounds/win-sound.mp3");
  menuMusic = new SoundFile(this, "sounds/menu-music.mp3");
  
  // Loading ship sprites
  base = loadImage("images/base.png");
  u = loadImage("images/u.png");
  ul = loadImage("images/ul.png");
  ur = loadImage("images/ur.png");
  d = loadImage("images/d.png");
  dl = loadImage("images/dl.png");
  dr = loadImage("images/dr.png");
  l = loadImage("images/l.png");
  r = loadImage("images/r.png");
  
  shooty = loadImage("images/shooty.png");
  portal = loadImage("images/portal.png");
  
  // Loading win/death screens
  for(int i = 0; i <= 3; i++){
    deathScreens[i] = loadImage("images/death" + str(i) + ".png");
    winScreens[i] = loadImage("images/win" + str(i) + ".png");
  }
  
  // Loading other menu assets
  startScreen = loadImage("images/startscreen.png");
  bg = loadImage("images/bg.png");
  start = loadImage("images/start.png");
  levels = loadImage("images/levels.png");
  
  // Loading level icons
  for(int i = 0; i < 12; i++){
    lvs[i] = loadImage("images/lv" + str(i+1) + ".png");
  }
  
  // Play that funky music
  menuMusic.loop();
}      

void draw() {
  // Setting rate of music
  gameMusic.rate(musicRate);
  
  // Run the game
  runGame();
}

void keyPressed(){
  // For slow stuff
  if(key == ' '){
    if(slowMeter > 0){
      slowOn = true;
    }
  }
  else {
    myShip.setMove(keyCode, true);
  }
}

void keyReleased(){
  // For slow stuff
  if(key == ' '){
    slowOn = false;
  }
  else {
    myShip.setMove(keyCode, false);
  }
}

void mouseClicked(){
  mouseReleased = true;
}
