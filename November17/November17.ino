
#include "pitches.h"

const int outPin = 3;
const int inPin = 4;
const int buttonPin = 7;
const int buzzPin = 8;

// One octave
int pitches[] = {
  NOTE_C4, NOTE_D4, NOTE_E4, NOTE_F4,
  NOTE_G4, NOTE_A4, NOTE_B4, NOTE_C5
};

void setup() {
  pinMode(outPin, OUTPUT);
  pinMode(inPin, INPUT);

  pinMode(buttonPin, INPUT);
  pinMode(buzzPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {

  digitalWrite(outPin, LOW);
  delayMicroseconds(2);

  digitalWrite(outPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(outPin, LOW);

  // Read pulse from dist. sensor
  long d = pulseIn(inPin, HIGH);
  // Constrain duration of pulse to prevent craziness
  long duration = constrain(d, 100, 2500);
  // Map to integer value
  int noteVal = int(map(duration, 100,2500, 0, 7));

  Serial.println(duration);

  // If the button is pressed, play the sound
  if(digitalRead(buttonPin) == 1){
    tone(buzzPin, pitches[noteVal]);
  }
  // Otherwise stop it
  else{
    noTone(8);
  }

}
