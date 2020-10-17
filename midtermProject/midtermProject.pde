import processing.sound.*;
SoundFile file;
float musicRate = 1;

void setup() {
  size(640, 360);
  background(255);
    
  // Load a soundfile from the data folder of the sketch and play it back double the speed
  file = new SoundFile(this, "bullet-time.mp3");
  file.loop();
}      

void draw() {
  file.rate(musicRate);
}

void keyPressed(){
  musicRate = 0.8;
}

void keyReleased(){
  musicRate = 1;
}
