const int outPin = 3;
const int inPin = 4;

void setup() {
  pinMode(outPin, OUTPUT);
  pinMode(inPin, INPUT);
  Serial.begin(9600);
}

void loop() {
  digitalWrite(outPin, LOW);
  delayMicroseconds(2);
  digitalWrite(outPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(outPin, LOW);

  long duration = analogRead(inPin);

  Serial.println(duration);
}
