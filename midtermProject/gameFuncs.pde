void runGame(){
  // If a level is active
  if(gameOn){
    background(0, 1);
    // Move ship
    myShip.moveShip();
    
    // Move and show bullets
    for(Bullet b : bullets){
      b.updateBullet();
      b.displayBullet();
    }
    
    // Shoot bullets and show shooters
    for(Shooter s : shooters){
      s.shootBullet();
      s.displayShooter();
    }
    
    // Show ship and portal 
    myShip.displayShip();
    myPortal.displayPortal();
    
    // Clean up dead bullets
    cleanBullets();
    
    // Check for win/loss conditions
    checkWin();
    checkDeath();
  }
  // If a level has yet to be set up
  else if(!levelSetup){
    // set up the level (or menu) based on current level
    switch(currentLevel){
      case 0:
        currentLevel++;
        break;
      case 1:
        level1();
        break;
      case 2:
        level2();
        break;
      case 3:
        level3();
        break;
      default:
        currentLevel = 0;
        break;
    }
  }
  // If the game has been won
  else if(levelWin){
    winScreen();
    gameMusic.stop();
    if(!winSoundPlayed){
      winSound.play();
      winSoundPlayed = true;
    }
    if(keyPressed){
      // Continue to next level
      if(key == 'c'){
        levelSetup = false;
        currentLevel++;
      }
    }
  }
  // If the player died
  else{
    deathScreen();
    gameMusic.stop();
    if(!deathSoundPlayed){
      deathSound.play();
      deathSoundPlayed = true;
    }
    if(keyPressed){
      // Restart level
      if(key == 'r'){
        levelSetup = false;
      }
    }
  }
}

void checkWin(){
  // Check if player reached portal
  if(dist(myPortal.loc.x, myPortal.loc.y, myShip.loc.x, myShip.loc.y) <= shipDiam){
    gameOn = false;
    levelWin = true;
  }
}

void checkDeath(){
  // Check if player has hit any active bullets
  for(Bullet b : bullets){
    if(dist(b.loc.x, b.loc.y, myShip.loc.x, myShip.loc.y) <= shipDiam/2){
      gameOn = false;
      fill(0);
    }
  }
}

void cleanBullets(){
  // Delete inactive bullets to avoid big stinky lag
  for(int i = 0; i < bullets.size() - 1; i++){
    if(bullets.get(i).loc.x < -20 || bullets.get(i).loc.x > width + 20 || bullets.get(i).loc.y < -20 || bullets.get(i).loc.y > height + 20){
      bullets.remove(i);
    }
  }
}

void globalResets(){  
  // These things reset every time a level ends,
  // so the program can call them all at once here
  deathSoundPlayed = false;
  winSoundPlayed = false;
  gameOn = true;
  levelSetup = true;
  levelWin = false;
  deathSound.stop();
  winSound.stop();
  gameMusic.loop();
}

void winScreen(){
  pushMatrix();
  fill(255);
  rectMode(CORNER);
  rect(0, height/3, width, height/3);
  imageMode(CENTER);
  image(winScreens[fIt%4], width/2, height/2);
  popMatrix();
  if(frameCount%20 == 0){
    fIt++;
  }
}

void deathScreen(){
  pushMatrix();
  fill(255);
  rectMode(CORNER);
  rect(0, height/3, width, height/3);
  imageMode(CENTER);
  image(deathScreens[fIt%4], width/2, height/2);
  popMatrix();
  if(frameCount%20 == 0){
    fIt++;
  }
}
