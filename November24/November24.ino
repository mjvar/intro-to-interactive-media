int potRead;
int buttonRead;
String reading;

void setup() {
  // put your setup code here, to run once:
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  potRead = analogRead(A0);
  buttonRead = digitalRead(A1);
  reading = String(potRead) + "," + String(buttonRead);
  Serial.println(reading);
}
