import processing.sound.*;
SoundFile gameMusic;
SoundFile deathSound;
SoundFile winSound;

boolean deathSoundPlayed = false;
boolean winSoundPlayed = false;
float musicRate = 1;

// Globals for movement
float currentVel = 3; 

int shipDiam = 40;

boolean gameOn = false;
boolean levelWin = false;

void setup() {
  size(1200, 700);
  background(0);
  
  smooth(3);
    
  // Load a soundfile from the data folder of the sketch and play it back double the speed
  gameMusic = new SoundFile(this, "game-music.mp3");
  gameMusic.loop();
  
  deathSound = new SoundFile(this, "death-sound.mp3");
  winSound = new SoundFile(this, "win-sound.mp3");
  
  level1();
}      

void draw() {
  background(0, 1);
  gameMusic.rate(musicRate);
  
  if(gameOn){
    myShip.moveShip();
    
    for(Bullet b : bullets){
      b.updateBullet();
      b.displayBullet();
    }
    
    for(Shooter s : shooters){
      s.shootBullet();
      s.displayShooter();
    }
    
    myShip.displayShip();
    myPortal.displayPortal();
    cleanBullets();
    println(bullets.size());
    
    checkWin();
    checkDeath();
  }
  else if(levelWin){
    gameMusic.stop();
    if(!winSoundPlayed){
      winSound.play();
      winSoundPlayed = true;
    }
  }
  else{
    gameMusic.stop();
    if(!deathSoundPlayed){
      deathSound.play();
      deathSoundPlayed = true;
    }
  }
}

void keyPressed(){
  if(key == ' '){
    musicRate = 0.8;
    currentVel = 0.5;
  }
  else {
    myShip.setMove(keyCode, true);
  }
}

void keyReleased(){
  if(key == ' '){
    musicRate = 1;
    currentVel = 3;
  }
  else {
    myShip.setMove(keyCode, false);
  }
}
