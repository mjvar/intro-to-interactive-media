const int buttonPin = A0;
const int potPin = A2;

const int redPin = 5;
const int bluePin = 6;

const int partialRed = 9;
const int partialBlue = 11;

int buttonRead;
int potRead;
float rate;

int sirenIterator = 0;
int redMix = 0;
int blueMix = 255;
int mixer = 1;

boolean on = false;

boolean buttonReleased = true;

void setup() {
  // put your setup code here, to run once:
  pinMode(A0, INPUT);
  pinMode(A2, INPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);

  Serial.begin(9600);
}

void loop() {
  buttonRead = digitalRead(buttonPin);
  potRead = analogRead(potPin);
  rate = map(potRead, 0, 1023, 50, 200);

  if(buttonRead == 1){
    buttonReleased = false;
  }
  else{
    if(!buttonReleased){
      on = !on;
    }
    buttonReleased = true;
  }

  if(on == true){
    siren(rate);
  }
  else{
    digitalWrite(redPin,LOW);
    digitalWrite(bluePin,LOW);
    analogWrite(partialRed, 0);
    analogWrite(partialBlue, 0);
  }
}

void siren(int rate){
  if(sirenIterator%2==0){
    digitalWrite(redPin,HIGH);
    digitalWrite(bluePin,LOW);
  }
  else{
    digitalWrite(bluePin,HIGH);
    digitalWrite(redPin,LOW);
  }
  
  sirenIterator++;

  redMix += mixer*(rate/3);
  blueMix -= mixer*(rate/3);

  analogWrite(partialRed, redMix);
  analogWrite(partialBlue, blueMix);

  if(redMix >= 255 || redMix <= 0){
    mixer = -mixer;
  }
  
  delay(rate);
}
