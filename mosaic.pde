import oscP5.*;
import netP5.*;
OscP5 oscP5;

boolean debug=false;


PImage i1, syd, a,s;

float x1,y1,x2,y2;

int currentImage;
int timePoint;

final int maxImages=2;   //number of images to display
final int interval=60000; //milliseconds! delay switch image


void setup()
{
  size(3072, 768);
  oscP5 = new OscP5(this,12000);
 
  s = loadImage("spot2.png");
  
  currentImage=1;
//get current 'time
timePoint=millis();
  
}
void draw()
{
  background(0);
  //have we reached time for next image?
  if(millis()>timePoint){
    showNext();
    //get time for next image
    timePoint=millis() + interval;
  }
  
  tint(255, 126);  // Apply transparency without changing color
  image(a, 0, 0);
  noStroke();
  fill(255);
  //ellipse(mouseX, mouseY, 400, 400);
  image(s, map(x1,0,1,0,width)-200, map(y1,1,0,0,height)-200,400,400);
  image(s, map(x2,0,1,0,width)-200, map(y2,1,0,0,height)-200,400,400);
  image(s, map(x1,0,1,0,width)-200, map(y1,1,0,0,height)-200,400,400);
  image(s, map(x2,0,1,0,width)-200, map(y2,1,0,0,height)-200,400,400);
  image(s, map(x1,0,1,0,width)-200, map(y1,1,0,0,height)-200,400,400);
  image(s, map(x2,0,1,0,width)-200, map(y2,1,0,0,height)-200,400,400);
  image(s, map(x1,0,1,0,width)-200, map(y1,1,0,0,height)-200,400,400);
  image(s, map(x2,0,1,0,width)-200, map(y2,1,0,0,height)-200,400,400);
  blend(a, 0, 0, 3072, 768, 0, 0, 3072, 768, DARKEST);
}


void oscEvent(OscMessage theOscMessage) {

    String addr = theOscMessage.addrPattern();
    println(addr);
    if (debug) {
      text("message OSC : "+ addr , 20, 20);
    }
    
    if(theOscMessage.checkAddrPattern("/1/xy")==true) {
    /* check if the typetag is the right one. */
     //xy pad writes to values to one address
      
      x1 = theOscMessage.get(1).floatValue();
      y1= theOscMessage.get(0).floatValue();//XYpad[0] = theOscMessage.get(1).floatValue(); //buttons dont work if i put this(get(1)) into a float at begining of function...???
      //println(x1+","+y1);
    }
     if(theOscMessage.checkAddrPattern("/1/xy2")==true) {
    /* check if the typetag is the right one. */
     //xy pad writes to values to one address
      
      x2 = theOscMessage.get(1).floatValue();
      y2= theOscMessage.get(0).floatValue();//XYpad[0] = theOscMessage.get(1).floatValue(); //buttons dont work if i put this(get(1)) into a float at begining of function...???
      //println(x1+","+y1);
    }

}

public void keyPressed() {
  if (key == 'd' || key == 'D')
    debug=!debug;
}

void showNext(){
 
  String imageFilename;
 
  //load file
  imageFilename="mosa"+str(currentImage) + ".png";
  a=loadImage(imageFilename);
  
  //set up for next image
  currentImage++;
  //reached last image?
  if(currentImage>maxImages) currentImage=1;
  //display
  //image(oneImage, 0, 0);
 
}

