/* //<>//
 * Bouncy Bouncy :-) 
 * by Ronny Recinos
 * 
*/

//Creates a Particle array particleBox
drawBoxes[] particleBox;
int minElements = 0, maxElements = 1000;

animatedCircles[] myCircleArray = new animatedCircles[100]; 
animatedQuads[]   myQuadArray   = new animatedQuads[100]; 

void setup() { 
  size(1024, 768);
  smooth(); // Smooths the edges
  particleBox = new drawBoxes[maxElements]; // Creates an array of Particles
  
  // Loops through the Circle array and creates Objects in every loop
  for(int i=0; i<myCircleArray.length; i++) { 
    myCircleArray[i] = new animatedCircles(512,384,25);  
    myQuadArray[i]   = new animatedQuads(507,394,511,385,507,375,503,385);    
  }
  
  // This for-loop is used for adding the drawBoxes objects to the particleBox
   for (int i=1; i <= minElements; i++){
    particleBox[i] = new drawBoxes(width/2, height/2, random(TWO_PI)); 
   }
  
}

void draw() { 
  background(0); 
  
  // Loops through and draws circles and quads, also animating them through each loop
  for(int i=0; i<myCircleArray.length; i++) {
    myCircleArray[i].update();
    myCircleArray[i].collisionCheck();
    myCircleArray[i].drawCircle(); 
    
    myQuadArray[i].update();
    myQuadArray[i].collisionCheck();
    myQuadArray[i].drawQuad(); 
  }
  
  // Used for drawing boxes around the mouse cursor
  if (minElements == maxElements - 1) // Once minElements hits the max amount of Elements, it will reset the particleBox by making it point to a brand new drawBoxes
  {
    minElements = 0; 
    particleBox = new drawBoxes[maxElements]; 
  }
  
  // This loop is used to constantly update and show the boxes within the particleBox array
  for (int i = 1; i <= minElements; i++)
  {
    particleBox[i].update();
    particleBox[i].show();
  }
  
}

// This class is used to draw the animated circles
class animatedCircles {

  // Data members
  float x, y, xSpeed, ySpeed, circleSize, x2, x3, x4, y2, y3, y4; 
  int timedBrightness = 255;
  
  // Constructor
  animatedCircles(float xpos, float ypos, float setCircleSize) {
    x = xpos;
    y = ypos; 
    circleSize = setCircleSize;
    
    xSpeed = random(-10, 10); 
    ySpeed = random(-10, 10); 
    
  }
  
  // Method functions
  void update() {
    x += xSpeed; 
    y += ySpeed;  
  }
  
  void collisionCheck() { 
    
    float halfOfCircle = circleSize/2; 
    
    if ( (x < halfOfCircle) || (x > width-halfOfCircle)){ 
      xSpeed = -xSpeed; 
    }  
    
    if( (y < halfOfCircle) || (y > height-halfOfCircle)) { 
      ySpeed = -ySpeed;  
    }
    
  }
  
  void drawCircle() { 
    // Increases the sizes of the circles
    if(mousePressed){
        if(mouseX < 50)
        circleSize = mouseX;
    }
    
    // Colors the circles
    color hue = int(map(dist(mouseX, mouseY, x, y), 0, (width + height)/2, 0, 255));
    colorMode(HSB); // HSB = Hue/Saturation/Brightness
    stroke(hue, 255, timedBrightness);
    fill(hue, 255, timedBrightness, 100);
    ellipse(x, y, circleSize, circleSize);
  }

}

// This class is used to create the Quads
class animatedQuads {
  
  // Data members
  float x1, y1, xSpeed, ySpeed, x2, x3, x4, y2, y3, y4; 
  int timedBrightness = 255;
  
  // Constructor
  animatedQuads(float x1pos, float y1pos, float x2pos, float y2pos, float x3pos, float y3pos, float x4pos, float y4pos) {
    x1 = x1pos; y1 = y1pos;  
    x2 = x2pos; y2 = y2pos; 
    x3 = x3pos; y3 = y3pos; 
    x4 = x4pos; y4 = y4pos;     
  
    xSpeed = random(-10, 10); 
    ySpeed = random(-10, 10); 
    
  }
  
  // Method Functions
  void update() {
    x1 += xSpeed; y1 += ySpeed;
    x2 += xSpeed; y2 += ySpeed;  
    x3 += xSpeed; y3 += ySpeed;
    x4 += xSpeed; y4 += ySpeed;      
  }
  
  void collisionCheck() { 
      
    if ( (x1 < 0) || (x1 > width)){ 
      xSpeed = -xSpeed; 
    }  
    
    if( (y1 < 0) || (y1 > height)) { 
      ySpeed = -ySpeed;  
    }
    
  } 
  
  void drawQuad() { 
    color hue = int(map(dist(mouseX, mouseY, x1, y1), 155, (width + height)/2, 0, 255));
    colorMode(HSB); // HSB = Hue/Saturation/Brightness
    stroke(hue, 255, timedBrightness);
    fill(hue, 255, timedBrightness, 100);
    quad(x1, y1, x2, y2, x3, y3, x4, y4);
  }
  
}

// This class is used to draw boxes around the mouse cursor
class drawBoxes
{
  float x, y, timedBrightness = 255, xSpeed, ySpeed, speed = random(1, 10), randomBoxSize = random(5, 20);
  boolean box = false;
  
  // Constructor
  drawBoxes(float xPos, float yPos, float radians)
  {
    x = xPos;
    y = yPos;
    
    xSpeed = cos(radians) * speed;
    ySpeed = sin(radians) * speed;
    
    if (random(100)>50)
      box = true;
  }
  
  // Method Functions
  void update()
  {
    x += xSpeed;
    y += ySpeed;
    
    if (x <= 0 || x >= width){
      xSpeed = -xSpeed;
    }
    if (y <= 0 || y >= height){
      ySpeed = -ySpeed;
    }
    timedBrightness -= 10 / 10; // This controls the speed of the color changing to black so it "disappears"
  }
  
  void show()
  {
      
    //map(value, start1, stop1, start2, stop2)
    //dist(x1, y1, x2, y2)
    color hue = int(map(dist(mouseX, mouseY, x, y), 0, (width + height)/2, 0, 255));
    colorMode(HSB); // HSB = Hue/Saturation/Brightness
    stroke(hue, 255, timedBrightness);
    fill(hue, 255, timedBrightness, 150);
    if (box)
      rect(x, y, randomBoxSize, randomBoxSize);
  }
}

void mouseDragged()
{ 
  // When mouse is dragged it use the newly created drawBoxes objects to fill the particleBox array so it can be used to draw the boxes around the mouse cursor
  if (minElements < maxElements - 1){ 
  minElements++;
  particleBox[minElements] = new drawBoxes(mouseX, mouseY, random(360));
  }
}
