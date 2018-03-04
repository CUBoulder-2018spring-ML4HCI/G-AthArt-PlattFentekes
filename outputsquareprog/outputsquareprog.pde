//This demo allows wekinator to control background color (hue)
//This is a continuous value between 0 and 1

//Necessary for OSC communication with Wekinator:
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress dest;

//Parameters of sketch
float myHue;
PFont myFont;
float breathstate;
int state;
int secondstart;
int secondend;

void setup() {
  //Initialize OSC communication
  oscP5 = new OscP5(this,12000); //listen for OSC messages on port 12000 (Wekinator default)
  dest = new NetAddress("127.0.0.1",6448); //send messages back to Wekinator on port 6448, localhost (this machine) (default)
  
  colorMode(HSB);
  size(400,400, P3D);
  smooth();
  background(255);

  //Initialize appearance
  myHue = 255;
  myFont = createFont("Arial", 14);
}

void draw() {
  background(myHue, 255, 255);
  drawtext();
  if (breathstate==1){
    secondstart=second();
    breathin();
  }
  else if (breathstate==2){
    secondstart=second();
    breathout();
  }
  else if (breathstate==3 && state==1){
    secondstart=second();
    pause1();
  }
  else if (breathstate==3 && state==2){
    secondstart=second();
    pause2();
  }
  
  
}

//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
 if (theOscMessage.checkAddrPattern("/wek/outputs")==true) {
     if(theOscMessage.checkTypetag("f")) { // looking for 1 control value
        float receivedHue = theOscMessage.get(0).floatValue();
        breathstate= receivedHue;
        println(receivedHue);
     } else {
        println("Error: unexpected OSC message received by Processing: ");
        theOscMessage.print();
      }
 }
}






//Write instructions to screen.
void drawtext() {
    stroke(0);
    textFont(myFont);
    textAlign(LEFT, TOP); 
    fill(0, 0, 255);
    text("Listening for /wek/outputs on port 12000", 10, 40);
    text("Square Breathing Trainer", 10, 10);
    text("Breathe in", 155, 95);
    text("Breathe out", 155, 310);
    text("Pause", 290, 202);
    text("Pause", 50, 202);
    
}

void squaredrawer() {
line(100, 300, 280, 300);
strokeWeight(20);
stroke(#436723);
line(100, 120, 280, 120);

line(100, 120, 100, 300);

line(280, 120, 280, 300);

}

void breathin() {
line(100, 120, 280, 120);
line(100, 120, 100, 300);
line(280, 120, 280, 300);
strokeWeight(5);
stroke(#436723);
line(100, 300, 280, 300);
state=1;
}

void pause1() {
line(100, 300, 280, 300);
line(100, 120, 100, 300);
line(280, 120, 280, 300);
strokeWeight(5);
stroke(#436723);
line(100, 120, 280, 120);
}

void breathout() {
line(100, 300, 280, 300);
line(100, 120, 280, 120);
line(280, 120, 280, 300);
strokeWeight(5);
stroke(#436723);
line(100, 120, 100, 300);
state=2;
}

void pause2() {
line(100, 300, 280, 300);
line(100, 120, 280, 120);
line(100, 120, 100, 300);
strokeWeight(5);
stroke(#436723);
line(280, 120, 280, 300);
}