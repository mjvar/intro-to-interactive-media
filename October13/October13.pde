// Matthew Varona - October 13, 2020
// Fruit Ninja game, but the ninja just likes fruit.
// Use the arrow keys to move.

PFont font;
PImage spritesheet;
PImage[][] sprites;
PImage fruitsheet;
PImage[][] fruits;
PImage grass;
int direction = 1; // 0 up
int step = 0;
int walkstep = 0;
int x, y;
int face = 0;
int speed = 40;
int move = 10;
boolean fruitSpawned = false;
int fruitX, fruitY, fruitChoiceX, fruitChoiceY;
int score = 0;

void moveNinja() {
  direction = 0;
  if (keyPressed) {
    direction = 1;
    face = 0;
    if (keyCode == DOWN) {
      y+=move;
    }
    if (keyCode == LEFT) {
      face = 1;
      x-=move;
    }
    if (keyCode == RIGHT) {
      x+=move;
    }
    if (keyCode == UP) {
      y-=move;
    }
    if (frameCount%(speed/6)==0) {
      walkstep = (walkstep+1) % 4;
    }
    if (face == 1) {
      pushMatrix();
      translate(x,y);
      scale(-1,1);
      image(sprites[direction][walkstep], 0,0);
      popMatrix();
    }
    else {
      image(sprites[direction][walkstep], x, y);
    }
  }
  else {
    if (frameCount%speed==0) {
      step = (step+1) % 2;
    }
    image(sprites[direction][step], x, y);
  }
  if (dist(x, y, fruitX, fruitY) < 100){
     fruitSpawned = false;
     score += 1;
  }
}

void spawnFruit() {
  if(!fruitSpawned){
    fruitX = int(random(100,width-100));
    fruitY = int(random(100,height-100));
    fruitChoiceX = int(random(0,2.99));
    fruitChoiceY = int(random(0,2.99));
    fruitSpawned = true;
  }
}

void setup() {
  size(800,800);
  
  font = createFont("media/EightBitDragon-anqx.ttf", 30);
  
  grass = loadImage("media/grass.png");
  
  spritesheet = loadImage("media/sheet.png");
  sprites = new PImage[2][6];

  int w = 105;
  int h = 140;

  for (int x = 0; x < 2; x++) {
    sprites[0][x] = spritesheet.get(x*100, 0, 100, h);
  }
  
  for (int x = 0; x < 4; x++) {
    sprites[1][x] = spritesheet.get(x*w, h, w, h);
  }
  
  fruitsheet = loadImage("media/fruits.png");
  fruits = new PImage[3][3];

  int w2 = 100;
  int h2 = 100;

  for (int x = 0; x < 3; x++) {
    for (int y = 0; y < 3; y++) {
      fruits[x][y] = fruitsheet.get(x*w2, y*w2, w2, h2);
    }
  }

  x = width/2;
  y = height/2;
  
  imageMode(CENTER);
}

void draw() {
  background(0);
  image(grass, width/2, height/2);
  
  textFont(font);
  text("Score: " + score, 10, 30);
  
  moveNinja();
  spawnFruit();

  image(fruits[fruitChoiceX][fruitChoiceY], fruitX, fruitY);
}
