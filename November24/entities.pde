float shieldWidth = PI*0.1;

class Enemy{
  PVector pos;
  PVector dir;
  int rad = 20;
  int vel = 5;
  
  Enemy(PVector p){
    pos = p.copy();
    dir = PVector.sub(new PVector(width/2,height/2), pos).normalize();
  }
  
  void displayEnemy(){
    pushMatrix();
    noStroke();
    fill(140);
    ellipse(pos.x, pos.y, rad, rad);
    popMatrix();
  }
  
  void updateEnemy(){
    pos.add(PVector.mult(dir, vel));
  }
}

void clearEnemies(){
  for(Enemy e : enemies){
    if(e.pos.x < -20 || e.pos.x > width + 20 || e.pos.y < -20 || e.pos.y > height + 20){
      enemies.remove(e);
    }
  }
}

void activateShield(){
  if(inByte[1] == 1){
    activeShield = true;
  }
  else{
    activeShield = false;
  }
}

void checkEnemies(){
  for(int i = 0; i < enemies.size(); i++){
    if(dist(enemies.get(i).pos.x, enemies.get(i).pos.y, width/2, height/2) < 50){
      shieldWidth -= PI*0.05;
      enemies.remove(i);
    }
    else if(dist(enemies.get(i).pos.x, enemies.get(i).pos.y, width/2, height/2) < 80 
    && PVector.angleBetween(new PVector(-enemies.get(i).dir.x,-enemies.get(i).dir.y),
    new PVector(cos(shieldAngle),sin(shieldAngle))) < shieldWidth+0.2
    && activeShield){
      enemies.remove(i);
    }
    if(shieldWidth <= 0){
      noLoop();
    }
  }
}
