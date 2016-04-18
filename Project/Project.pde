import g4p_controls.G4P;
import g4p_controls.GAlign;
import g4p_controls.GButton;
import g4p_controls.GCScheme;
import g4p_controls.GEvent;
import g4p_controls.GLabel;

import org.gamecontrolplus.Configuration;
import org.gamecontrolplus.ControlDevice;
import org.gamecontrolplus.ControlIO;

//Leap motion library
import com.onformative.leap.*;

ControlIO controlIO;
int panelHeight;
GLabel lblPath, lblSketch;
GButton btnSelSketch;

LeapMotionP5 leap;

int p2Bar = 0;

int test = 100;

boolean testingGamePad = false;

boolean gameStart = false;

int p2Scrore = 0;

float x = 150;
float y = 150;
float speedX = random(3, 5);
float speedY = random(3, 5);
int p1Color = 0xff83ff00;
int p2Color = 0xffff0000;
int diam;
int rectSize = 150;
float diamHit;

public void setup() {
  size(800,600);
  controlIO = ControlIO.getInstance(this);
  noStroke();
  smooth();
  ellipseMode(CENTER);
  leap = new LeapMotionP5(this);
  fill(255);
  
  //kijken als de juiste controler is conected nog doen
  
  //zoek het juiste device
  //ControlDevice device = controlIO.getDevice(3);
}

public void draw() {
    background(255);
   
    fill(128,128,128);
    diam = 20;
    ellipse(x, y, diam, diam);
   
    fill(p1Color);
    rect(30, mouseY-rectSize/2, 10, rectSize); //player 1 bar
    fill(p2Color);
    rect(width-30, p2Bar-rectSize/2, 10, rectSize);
   
    //Toon score
    text(p2Scrore, 10, 30);
   
    if (gameStart) {
   
      x = x + speedX;
      y = y + speedY;
  

      //player 1 / left side 
      if ( x < 30 && x > 20 && y > mouseY-rectSize/2 && y < mouseY+rectSize/2 ) {
        speedX = speedX * -1;
        x += speedX;
        fill(random(0,128),random(0,128),random(0,128));
        diamHit = random(75,150);
        ellipse(x,y,diamHit,diamHit);   
      }

      //player 2 / right side
      if ( x > width-30 && x < width -20 && y > p2Bar-rectSize/2 && y < p2Bar+rectSize/2 ) {
        speedX = speedX * -1;
        x += speedX;
        fill(random(0,128),random(0,128),random(0,128));
        diamHit = random(75,150);
        ellipse(x,y,diamHit,diamHit); 
      }

      // resets things if you lose
      if (x > width || x < 0) {
        p2Scrore++; 
        gameStart = false;
        x = 150;
        y = 150;
        speedX = random(3, 5);
        speedY = random(3, 5);
        rectSize = 150;
      }
   
   
      // if ball hits up or down, change direction of Y  
      if ( y > height || y < 0 ) {
        speedY = speedY * -1;
        y = y + speedY;
      }
    }

  if(testingGamePad == true){
    //controler hat besturing
    /*if(device.getHat(0).up()){
      p2Bar-=10;
    }
    if(device.getHat(0).down()){
      p2Bar+=10;
    }*/
    //controler knop ingedrukt
    /*if(device.getButton(1).pressed() == true){
      
      }*/
    //};
    }
}
void keyPressed() {
  if (key == CODED) {
      if (keyCode == UP) {
        p2Bar -= 20;
      } else if (keyCode == DOWN) {
        p2Bar += 20;
      }
  }
}
void mousePressed() {
  gameStart = true;
}