// Procedural map generation using Voronoi tesellations.
// Distance from each point is calculated using Manhattan
// distance rather than Euclidean distance.

int dotDim = 20;
int dotCount = dotDim * dotDim;
PVector[] pts = new PVector[dotCount];

IntList land;

//The PointContainer class exists solely to
//work with findNearest. When finding the
//point nearest any given pixel, we can use
//PointContainer to return both the point's
//index in pts[] and its distance from the pixel
//in one fell swoop.
class PointContainer{
  int index;
  float dist;
  
  PointContainer(int i, float d){
    this.index = i;
    this.dist = d;
  }
}

//Find the nearest point from array pts to any given pixel (x/y value).
PointContainer findNearest(PVector[] pts, float x, float y){
  float minDist = width*2;
  float tempDist = 0;
  int index = 0;
  for(int i = index; i < pts.length; i++){
    tempDist = dist(pts[i].x, pts[i].y, x, y);
    //tempDist = abs(pts[i].x - x) + abs(pts[i].y - y); // Using Manhattan distance calculation
    if(tempDist < minDist){
      minDist = tempDist;
      index = i;
    }
  }
  return(new PointContainer(index, minDist));
}

//Figure out which points should represent land.
//This can be done a multitude of ways. For simplicity,
//this version will generate land from a circle at the
//center of the canvas.
IntList chooseLand(PVector[] pts){
  IntList land = new IntList();
  int i = 0;
  float edgeFactor = 0.05;
  for(PVector p : pts){
    //In this if statement we can add a random value
    //to "skip" some land tiles, and turn them into 
    //inland bodies of water, like lakes!
    if(dist(p.x, p.y, width/2, height/2) < 300 && random(0,1)<0.95){
      land.append(i);
    }
    else if(p.x < width * (1-edgeFactor) && p.y < height * (1-edgeFactor) && p.x > width * edgeFactor && p.y  > height * edgeFactor && random(0,1)>0.95){
      land.append(i);
    }
    i++;
  }
  return(land);
}

void printWater(){
  loadPixels();
  
  updatePixels();
}

//Prints land pixels based on land tiles
//chosen in chooseLand().
void printLand(){
  loadPixels();
  for(int x = 0; x < width; x++){
     for(int y = 0; y < height; y++){
       int pixelI = x + y * width;
       PointContainer current = findNearest(pts,x,y);
       if(land.hasValue(current.index)){
         pixels[pixelI] = color(0,map(current.dist, 0, 50, 150, 180),0);
       }
     }
  }
  updatePixels();
}

void setup(){
  size(800,800);
  float scaleFactor = width/dotDim * 1.2; 
  float randomFactor = 20;
  for(int x = 0; x < dotDim; x++){
    for(int y = 0; y < dotDim; y++){
      // Here we initialize points on a grid with x and y values based on scaling, but agitate them by a small noise factor.
      pts[x + y * dotDim] = new PVector(x * scaleFactor + random(-randomFactor,randomFactor), y * scaleFactor + random(-randomFactor,randomFactor));
    }
  }
}

void draw(){
  background(50,100,255);
  //First, we choose which points are "land" values.
  land = chooseLand(pts);
  
  //We print the water first, on top of which the land will fall.
  printWater();
  
  //Then, given these values, we use the Voronoi diagram to
  //print land in "tiles", based on their closest point.
  printLand();
  
  //strokeWeight(5);
  //stroke(255,0,0);
  //for(PVector v : pts){
  //  point(v.x, v.y);
  //}
  
  noLoop();
}
