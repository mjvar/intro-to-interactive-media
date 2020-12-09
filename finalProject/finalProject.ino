#include <Servo.h>

Servo myServo;

const int servoPin = 5;
const int echoPin = 6;
const int trigPin = 7;

void setup() {
  // put your setup code here, to run once:
  myServo.attach(servoPin);
  myServo.write(20);

  pinMode(echoPin, INPUT);
  pinMode(trigPin, OUTPUT);

  Serial.begin(9600);
}

void loop() {
  scan();
  
}

void scan(){
  
  delay(1000);
  // put your main code here, to run repeatedly:
  for(int i = 20; i < 160; i++){
    myServo.write(i);
    delay(20);
    getDistanceReading(i);
  }
  delay(1000);
  for(int i = 160; i > 20; i--){
    myServo.write(i);
    delay(20);
    getDistanceReading(i);
  }
}

void getDistanceReading(int i){
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(trigPin, LOW);

  long d = pulseIn(echoPin, HIGH);

  String info = String(i) + "," + String(d);
  Serial.println(info);
}
