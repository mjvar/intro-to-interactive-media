import processing.serial.*;
import processing.sound.*;

Serial myPort;        // The serial port
int inByte[] = new int[2];

int angle;
int sensorDist;

int[] readings = new int[4]; 

int[] tempVals = new int[4]; 

String[] audioFileNames = new String[]{"beat","bass","chords","lead"};

SoundFile[][] loopFiles = new SoundFile[4][4];

boolean[] playing = new boolean[]{false,false,false,false};

int[] currentTracks = new int[]{0,0,0,0};

void setup () {
  // set the window size:
  size(1600, 1000);

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
  
  // Set initial reading values
  for(int i = 0; i < 4; i++){
    readings[i] = 100000;
    tempVals[i] = 100000;
  }
  
  for(int names = 0; names < 4; names++){
    for(int fileNo = 0; fileNo < 4; fileNo++){
      String tempName = "loops/" + audioFileNames[names] + str(fileNo+1) + ".aif";
      loopFiles[names][fileNo] = new SoundFile(this, tempName);
    }
  }
}

void draw () {
  angle = inByte[0];
  sensorDist = inByte[1];
  background(240);
  
  getReadings();
  //println(inByte);
  println(readings[0], readings[1], readings[2], readings[3]);
  //println(tempVals[0], tempVals[1], tempVals[2], tempVals[3]);
  
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

void getReadings(){
  // Method for reading distances to figure out which
  // loops to play. First, if the 
  if(angle <= 21 || angle >= 158){
    tempVals[0] = 100000;
    tempVals[1] = 100000;
    tempVals[2] = 100000;
    tempVals[3] = 100000;
  }
  
  if(angle > 125){
    if(sensorDist < tempVals[0]){
      readings[0] = sensorDist;
    } 
    tempVals[0] = readings[0];
  }
  else if(angle > 90){
    if(sensorDist < tempVals[1]){
      readings[1] = sensorDist;
    }
    tempVals[1] = readings[1];
  }
  else if(angle > 55){
    if(sensorDist < tempVals[2]){
      readings[2] = sensorDist;
    }
    tempVals[2] = readings[2];
  }
  else if(angle > 20){
    if(sensorDist < tempVals[3]){
      readings[3] = sensorDist;
    }
    tempVals[3] = readings[3];
  }
}

void checkPlaying(){
  for(int names = 0; names < 4; names++){
    playing[names] = false;
    for(int fileNo = 0; fileNo < 4; fileNo++){
      if(loopFiles[names][fileNo].isPlaying()){
        playing[names] = true;
      }
    }
  }
}

void playLoops(){
  for(int i = 0; i < 4; i++){
    if(!playing[i] && currentTracks[i] != 0){
      loopFiles[i][currentTracks[i]].play();
    }
  }
}
