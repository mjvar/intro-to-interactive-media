// Global var for size of boxes
int step = 15;

// Class for any individual rectangle
class Glyph{
  PVector[] pts = new PVector[6];
  
  Glyph(int x, int y){
    // Initialize 6 points to create a rectangle
    pts[0] = new PVector(x,y);
    pts[1] = new PVector(x + step*0.75,y);
    pts[2] = new PVector(x,y + step);
    pts[3] = new PVector(x + step*0.75, y + step);
    pts[4] = new PVector(x, y + step/2);
    pts[5] = new PVector(x + step*0.75, y + step/2);
  }
  
  void drawGlyph(){
    stroke(230);
    // Draw this individual glyph using its points
    // rand is a random threshold that increases the lower the box is
    float rand = map(this.pts[0].y, 0, 800, 0.1, 1);
    
    //Use random value (based on threshold) to see if the line is drawn
    if(random(0,1) > rand)
      line(this.pts[0].x, this.pts[0].y, this.pts[1].x, this.pts[1].y);
    if(random(0,1) > rand)
      line(this.pts[2].x, this.pts[2].y, this.pts[1].x, this.pts[1].y);
    if(random(0,1) > rand)
      line(this.pts[3].x, this.pts[3].y, this.pts[1].x, this.pts[1].y);
    if(random(0,1) > rand)
      line(this.pts[3].x, this.pts[3].y, this.pts[2].x, this.pts[2].y);
    if(random(0,1) > rand)
      line(this.pts[3].x, this.pts[3].y, this.pts[0].x, this.pts[0].y);
    if(random(0,1) > rand)
      line(this.pts[2].x, this.pts[2].y, this.pts[0].x, this.pts[0].y);
    if(random(0,1) > rand)
      line(this.pts[5].x, this.pts[5].y, this.pts[4].x, this.pts[4].y);
  }
}

// Function to generate glyphs into the ArrayList
ArrayList<Glyph> generateGlyphs(){
  ArrayList<Glyph> glyphs = new ArrayList<Glyph>();
  for(int x = step*3; x < width-3*step; x+=step){
    for(int y = step*3; y < height-4*step; y+=step*1.5){
      // Create a glyph with points based on x and y
      // as we traverse the canvas
      glyphs.add(new Glyph(x, y));
    }
  }
  return(glyphs);
}

void showGlyphs(ArrayList<Glyph> glyphs){
  for(Glyph g : glyphs){
    g.drawGlyph();
  }
}

void addNoise(){
  // Draw noise in the background
  // grain is grain size, noiseOff affects
  // how "zoomed in" we are to the noise plane
  int grain = 1;
  float noiseOff = 0.005;
  for(int x = 0; x < width; x+=grain){
    for(int y = 0; y < height; y+=grain){
      noStroke();
      fill(map(noise(x*noiseOff,y*noiseOff),0,1,0,60));
      rect(x, y, grain, grain);
    }
  }
}

void setup(){
  size(600,800);
}

void draw(){
  background(0);
  
  ArrayList<Glyph> glyphs = generateGlyphs();
  
  addNoise();
  showGlyphs(glyphs);
  
  noLoop();
}
