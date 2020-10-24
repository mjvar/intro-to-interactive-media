void checkWin(){
  if(dist(myPortal.loc.x, myPortal.loc.y, myShip.loc.x, myShip.loc.y) <= shipDiam){
    gameOn = false;
    levelWin = true;
  }
}

void checkDeath(){
  for(Bullet b : bullets){
    if(dist(b.loc.x, b.loc.y, myShip.loc.x, myShip.loc.y) <= shipDiam/2){
      gameOn = false;
      fill(0);
    }
  }
}

void cleanBullets(){
  for(int i = 0; i < bullets.size() - 1; i++){
    if(bullets.get(i).loc.x < -20 || bullets.get(i).loc.x > width + 20 || bullets.get(i).loc.y < -20 || bullets.get(i).loc.y > height + 20){
      bullets.remove(i);
    }
  }
}

void winScreen(){
  
}
