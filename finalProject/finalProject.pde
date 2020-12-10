import processing.serial.*;
import processing.sound.*;

// serial stuff
Serial myPort;       
int inByte[] = new int[2];

// Array of cleaned readings
int[] readings = new int[4]; 
// Array of temporary reading values for comparison
int[] tempVals = new int[4]; 

String[] audioFileNames = new String[]{"beat","bass","chords","lead"};

SoundFile[][] loopFiles = new SoundFile[4][4];

boolean[] playing = new boolean[]{false,false,false,false};

// Array of currently playing tracks
int[] currentTracks = new int[]{0,0,0,0};

int time = -9000;

int bands = 128;
FFT[] ffts = new FFT[]{new FFT(this,bands),new FFT(this,bands),new FFT(this,bands),new FFT(this,bands)};
float[][] spectra = new float[4][128];

void setup () {
  size(1200, 800);

  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my Mac is always my
  // Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[4], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set initial background:
  background(0);
  
  // Set initial reading values
  for(int i = 0; i < 4; i++){
    readings[i] = 100000;
    tempVals[i] = 100000;
  }
  
  // Load sound files
  for(int names = 0; names < 4; names++){
    for(int fileNo = 0; fileNo < 4; fileNo++){
      String tempName = "loops/" + audioFileNames[names] + str(fileNo+1) + ".aif";
      loopFiles[names][fileNo] = new SoundFile(this, tempName);
    }
  }
  
  // Load FFT spectra with 0-arrays
  for(int x = 0; x < 4; x++){
    for(int y = 0; y < 128; y++){
      spectra[x][y] = 0;
    }
  }
}

void draw () {  
  getReadings();
  checkPlaying();
  playLoops();
  updateVisualizer();
  displayViz();
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    inByte = int(split(inString,","));
    // Update angle and sensor distance every frame
    angle = inByte[0];
    sensorDist = inByte[1];
  }
}

void getReadings(){
  // Method for reading distances to figure out which loops to play. 
  if(inByte[0] <= 21 || inByte[0] >= 158){
    // If the scanner has reached the end of its rotation, reset temp values
    tempVals[0] = 100000;
    tempVals[1] = 100000;
    tempVals[2] = 100000;
    tempVals[3] = 100000;
  }
  
  // Get the LOWEST possible reading in each angle range
  if(angle > 125){
    if(sensorDist < tempVals[3]){
      readings[3] = sensorDist;
    } 
    tempVals[3] = readings[3];
  }
  else if(angle > 90){
    if(sensorDist < tempVals[2]){
      readings[2] = sensorDist;
    }
    tempVals[2] = readings[2];
  }
  else if(angle > 55){
    if(sensorDist < tempVals[1]){
      readings[1] = sensorDist;
    }
    tempVals[1] = readings[1];
  }
  else if(angle > 20){
    if(sensorDist < tempVals[0]){
      readings[0] = sensorDist;
    }
    tempVals[0] = readings[0];
  }
}

void checkPlaying(){
  // Check which tracks are playing
  for(int names = 0; names < 4; names++){
    playing[names] = false;
    for(int fileNo = 0; fileNo < 4; fileNo++){
      if(loopFiles[names][fileNo].isPlaying()){
        playing[names] = true;
      }
    }
  }
}

void updateVisualizer(){
  // Get new FFT values from the tracks that are playing
  for(int i = 0; i < 4; i++){
    if(currentTracks[i] > 0){
      ffts[i].input(loopFiles[i][currentTracks[i]-1]);
      
      ffts[i].analyze(spectra[i]);
      println(spectra[i]);
    }
  }
}

void displayViz(){
  // Visualization drawing function
  pushMatrix();
  colorMode(HSB);
  translate(width/2,height/2);
  rotate(frameCount*0.013);
  int[] vizRads = new int[]{100,200,300,400};
  int dispRad = 200;
  for(int inst = 0; inst < 4; inst++){ 
    for(int i = 0; i < 50; i++){
      stroke(360,100,100,50);
      strokeWeight((inst+1));
      float theta1 = map(i, 0, 50, 0, TWO_PI);
      float theta2 = map(i+1, 0, 50, 0, TWO_PI);
      // Alter point location based on FFT reading
      point(cos(theta1)*(vizRads[inst] + map(spectra[inst][i],0,1,-dispRad,dispRad)),sin(theta1)*(vizRads[inst] + map(spectra[inst][i],0,1,-dispRad,dispRad)));
      point(cos(theta2)*(vizRads[inst] + map(spectra[inst][i],0,1,-dispRad,dispRad)),sin(theta2)*(vizRads[inst] + map(spectra[inst][i],0,1,-dispRad,dispRad)));
      strokeWeight(1);
      stroke(map(spectra[inst][i],0,1,180,360),100,100,50);
      line(cos(theta1)*(vizRads[inst] + map(spectra[inst][i],0,1,-dispRad,dispRad)),sin(theta1)*(vizRads[inst] + map(spectra[inst][i],0,1,-dispRad,dispRad)),
      cos(theta2)*(vizRads[inst] + map(spectra[inst][i],0,1,-dispRad,dispRad)),sin(theta2)*(vizRads[inst] + map(spectra[inst][i],0,1,-dispRad,dispRad)));
    }
  }
  popMatrix();
}

void playLoops(){
  // Choose which tracks to play based on sensor readings
  if(millis() > time + 8000){
    // Play loops every 8 seconds
    background(0,1);
    for(int i = 0; i < 4; i++){
      if(readings[i] > 1400){
        currentTracks[i] = 0;
      }
      else if(readings[i] > 990){
        currentTracks[i] = 1;
      }
      else if(readings[i] > 700){
        currentTracks[i] = 2;
      }
      else if(readings[i] > 400){
        currentTracks[i] = 3;
      }
      else{
        currentTracks[i] = 4;
      }
      if(currentTracks[i] > 0){
        loopFiles[i][currentTracks[i]-1].play();
      }
    }
    time = millis();
  }
}
