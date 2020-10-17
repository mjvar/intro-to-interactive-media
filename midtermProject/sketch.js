let mySound;
let currentY;
let songRate = 1;

function preload() {
  mySound = loadSound('bullet-time.mp3');
}

function setup() {
  let cnv = createCanvas(windowWidth, windowHeight);
}

function draw() {
  background(220);
  mySound.rate(songRate);
  currentY = map(songRate, 0.9, 1, height*0.6, height*0.4);
  line(0, currentY, width, currentY);
}

function mousePressed(){
	mySound.loop();
}

function keyPressed(){
	songRate = 0.9;
}

function keyReleased(){
	songRate = 1;
}