import processing.serial.*;

Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph
int inByte[] = new int[2];

float shieldAngle;

boolean activeShield;

ArrayList<Enemy> enemies = new ArrayList<Enemy>();

void setup () {
  // set the window size:
  size(1000, 800);

  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my Mac is always my
  // Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[5], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set initial background:
  background(0);
}

void draw () {
  background(240);
  shieldAngle = map(inByte[0],0,1023,0,TWO_PI);
  
  displayChar();
  displayShield();
  
  if(frameCount % 60 == 0){
    if(random(1) > 0.5){
      enemies.add(new Enemy(new PVector(random(0, width), 0)));
    }
    else{
      enemies.add(new Enemy(new PVector(random(0, width), height)));
    }
  }
  
  for(Enemy e : enemies){
    e.updateEnemy();
    e.displayEnemy();
  }
  activateShield();
  checkEnemies();
}

void displayChar(){
  pushMatrix();
  noStroke();
  fill(40);
  ellipse(width/2,height/2,100,100);
  popMatrix();
}

void displayShield(){
  pushMatrix();
  stroke(10, 50);
  if(activeShield){
    stroke(10);
  }
  strokeWeight(10);
  noFill();
  arc(width/2,height/2,140,140,shieldAngle-shieldWidth,shieldAngle+shieldWidth);
  popMatrix();
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    inByte = int(split(inString,","));
  }
}
