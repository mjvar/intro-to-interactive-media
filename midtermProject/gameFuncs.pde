void runGame(){
  // If a level is active
  if(gameOn){
    imageMode(CENTER);
    image(bg, width/2,height/2);
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
    
    slowMechanics();
    showMeter();
  }
  // If a level has yet to be set up
  else if(!levelSetup){
    // set up the level (or menu) based on current level
    switch(currentLevel){
      case -1:
        levelScreen();
        break;
      case 0:
        startScreen();
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
      case 4:
        level4();
        break;
      case 5:
        level5();
        break;
      case 6:
        level6();
        break;
      case 7:
        level7();
        break;
      case 8:
        level8();
        break;
      case 9:
        level9();
        break;
      case 10:
        level10();
        break;
      case 11:
        level11();
        break;
      case 12:
        level12();
        break;
      default:
        // Handler case for bugs (of which I hope there are none)
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
      // Or go to the menu
      else if(key == 'm'){
        menuMusicPlayed = false;
        levelSetup = false;
        currentLevel = 0;
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
      // Or go to the menu
      else if(key == 'm'){
        menuMusicPlayed = false;
        levelSetup = false;
        currentLevel = 0;
      }
    }
  }
  mouseReleased = false;
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
  // Delete inactive bullets to avoid big stinky lag (IMPORTANT!!)
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
  menuMusic.stop();
  
  slowMeter = 200;
}

void winScreen(){
  // Show the win graphic
  pushMatrix();
  imageMode(CENTER);
  image(winScreens[fIt%4], width/2, height/2);
  popMatrix();
  // animating it
  if(frameCount%20 == 0){
    fIt++;
  }
}

void deathScreen(){
  // Show the win graphic
  pushMatrix();
  imageMode(CENTER);
  image(deathScreens[fIt%4], width/2, height/2);
  popMatrix();
  // animating it
  if(frameCount%20 == 0){
    fIt++;
  }
}

void showMeter(){
  // Show the slow meter in the top left
  pushMatrix();
  rectMode(CORNER);
  fill(255);
  if(slowMeter < 10){
    // If you're low on meter, this is bad!! I should warn you by turning red!!!
    fill(255,0,0);
  }
  stroke(0);
  strokeWeight(5);
  // Size changes based on meter amount
  rect(width*0.01, height*0.01, map(slowMeter, 0, 200, width*0.01, width*0.1), height*0.03);
  popMatrix();
}

void slowMechanics(){
  // Implement slow mechanics
  if(slowOn && slowMeter > 0){
    // If space is pressed AND meter not empty, do the slow stuff
    slowMeter--;
    musicRate = 0.8;
    currentSpeed = 0.5;
  }
  else{
    if(!slowOn && slowMeter < 200){
      // If space is NOT pressed AND meter is not full, fill it
      // Otherwise, user has to release space to fill the meter
      slowMeter++;
    }
    musicRate = 1;
    currentSpeed = 3;
  }
}

void levelScreen(){
  imageMode(CENTER);
  image(bg, width/2, height/2);
  
  // Print all the level icons
  for(int x = 0; x < 4; x++){
    for(int y = 0; y < 3; y++){
      imageMode(CENTER);
      if(mouseX > (1+x)*width/5 - 50 && mouseX < (1+x)*width/5 + 50 && mouseY > (1+y)*height/4 - 75 && mouseY < (1+y)*height/4 + 75){
        // Expand a level icon when moused over
        image(lvs[x + y*4], (1+x)*width/5, (1+y)*height/4, 110, 165);
        if(mouseReleased){
            currentLevel = (x + y*4) + 1;
        }
      }
      else{
        image(lvs[x + y*4], (1+x)*width/5, (1+y)*height/4);
      }
    }
  }
}

void startScreen(){
  deathSound.stop();
  winSound.stop();
  
  if(!menuMusicPlayed){
    menuMusicPlayed = true;
    menuMusic.loop();
  }
  imageMode(CENTER);
  image(startScreen, width/2,height/2);
  
  if(mouseX > width/4 - 100 && mouseX < width/4 + 100 && mouseY > height*0.7 - 50 && mouseY < height*0.7 + 50){
    // Expand icon when moused over
    image(start, width/4, height*0.7, 220, 110);
    if(mouseReleased){
      currentLevel = 1;
    }
  }
  else{
    image(start, width/4, height*0.7, 200, 100);
  }
  
  if(mouseX > 3*width/4 - 100 && mouseX < 3*width/4 + 100 && mouseY > height*0.7 - 50 && mouseY < height*0.7 + 50){
    // Expand icon when moused over
    image(levels, 3*width/4, height*0.7, 220, 110);
    if(mouseReleased){
      currentLevel = -1;
    }
  }
  else{
    image(levels, 3*width/4, height*0.7, 200, 100);
  }
}
