/* 
 Visualization of data from Winter's Biomechanics and Motor Control of Human Movement
 based on code by Greg Borenstein
 by Dustyn Roberts 2012-11-28
 */

int currentFrame = 0;
Frame[] frames;  // create an array of Frame objects
float rotation = 0;

void setup() {
  size(700, 400, P3D);
  frameRate(60);

  // read in the data and clean it up
  String[] lines = loadStrings("Raw_Coordinate_DATA(cm)-Table 1.csv");
  frames = new Frame[lines.length]; // initialize the frames array
  for (int i = 0; i < lines.length; i++) {  // initialize each each element of the frames array
    frames[i] = new Frame(lines[i]);
  }
  frames = (Frame[]) subset(frames, 3); // get rid of the first three rows of labels and such
}

void draw() {
  background(255);  // redraw a white background on each loop
  lights();

  // without these next 2 lines, dude walks on the ceiling
  translate(0, height, 0);
  rotateX(PI);
  
  // rotate to see 3D when mousePressed
  if (mousePressed) {
    rotation = map(mouseX, 0, width, -PI, PI);
    rotateY(rotation);
  }

  scale(2);  // data comes in as pixels, scale to make visible on screen

  frames[currentFrame].draw();  // this is where the magic happens

  currentFrame++;  // increment frame each time through draw
  if (currentFrame >= frames.length) {  // when dude falls off screen, start again at left
    currentFrame = 0;
  }
}

