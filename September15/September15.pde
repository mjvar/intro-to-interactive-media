void face(){
  //Skin tone and face shape
  fill(229,194,152);
  rectMode(CENTER);
  stroke(0);
  strokeWeight(5);
  rect(400, 500, 100, 100);
  ellipse(400, 300, 350, 400);
  
  //Eyes
  fill(255);
  ellipse(330,250,70,50);
  ellipse(470,250,70,50);
  
  //Pupils, mapped to mouse position
  fill(0);
  float leftPupilX = map(mouseX, 0, 800, 320, 340);
  float leftPupilY = map(mouseY, 0, 800, 240, 260);
  float rightPupilX = map(mouseX, 0, 800, 460, 480);
  float rightPupilY = map(mouseY, 0, 800, 240, 260);
  
  ellipse(leftPupilX,leftPupilY,20,20);
  ellipse(rightPupilX,rightPupilY,20,20);
  
  //Brows
  noFill();
  strokeWeight(10);
  arc(320, 410, 400, 400, radians(260), radians(280));
  arc(446, 400, 400, 400, radians(270), radians(290));
  
  //Nose
  curve(380,350,400,300,400,370,250,300);
  
  //Mouth
  arc(320, 700, 600, 600, radians(270), radians(300));
  
  //Bangs
  fill(54, 32, 0);
  strokeWeight(5);
  arc(500, -101, 600, 600, radians(81), radians(129), OPEN);
  
  pushMatrix();
  noStroke();
  rotate(radians(15));
  rect(460, 10, 200, 50);
  rect(460, 23, 270, 50);
  popMatrix();
  
}

void hair(){
  strokeWeight(5);
  stroke(0);
  fill(54, 32, 0);
  ellipse(400, 360, 500, 600);
}

void body(){
  //Torso and arms
  strokeWeight(5);
  stroke(0);
  fill(255, 247, 0);
  rect(400, 840, 500, 600, 150);
  line(240, 680, 240, 800);
  line(560, 680, 560, 800);
  
  //Shirt collar
  fill(229,194,152);
  arc(400, 505, 120, 120, radians(33), radians(147), OPEN);
}

void setup(){
  size(800,800);
}

void draw(){
  //Draw background and features of portrait
  background(255, 166, 237);
  hair();
  face();
  body();

  //Print mouse X and Y; useful so I don't have to eyeball drawing coordinates myself 
  print(mouseX, mouseY);

  //Save each frame so I can export it as a GIF
  //saveFrame("###.png");
}
