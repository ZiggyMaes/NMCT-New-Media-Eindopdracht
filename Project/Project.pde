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

boolean testingGamePad = false;

boolean gameStart = false;

//Player variables
int p1Bar = height/2;
int p2Bar = height/2;

int p1Color = 0xff83ff00;
int p2Color = 0xffff0000;

int p1Scrore = 0;
int p2Scrore = 0;


PVector ball;
float speedX = random(3, 5);
float speedY = random(3, 5);

int diam;
int rectSize = 150;
float diamHit;

public void setup() {
  size(1920,1080);
  controlIO = ControlIO.getInstance(this);
  noStroke();
  smooth();
  ellipseMode(CENTER);
  leap = new LeapMotionP5(this);
  fill(255);
  ball = new PVector(width/2,height/2);
  
  //kijken als de juiste controler is conected nog doen
  
  //zoek het juiste device
  //ControlDevice device = controlIO.getDevice(3);
}

public void draw() {
    background(255);
   
//Toon score
    textSize(32);
    fill(128);
    text(p1Scrore, width/2+60, 30);
    text(p2Scrore, width/2-90, 30);
    fill(200);
    rect(width/2-2.5, 0, 5, height);

    fill(128,128,128);
    diam = 20;
    println("var: "+ball.x);
    ellipse(ball.x, ball.y, diam, diam);

    //player 1 bar
    fill(p1Color);
    rect(20, mouseY-rectSize/2, 10, rectSize);

    //player 2 bar
    fill(p2Color);
    rect(width-30, p2Bar-rectSize/2, 10, rectSize); 
   
    if (gameStart) 
    {
   
      ball.x += speedX;
      ball.y += + speedY;
  

      //player 1 / left side 
      if ( ball.x < 30 && ball.x > 20 && ball.y > mouseY-rectSize/2 && ball.y < mouseY+rectSize/2 ) 
      {
        speedX *= -1;
        ball.x += speedX;
        fill(random(0,128),random(0,128),random(0,128));
        diamHit = random(75,150);
        ellipse(ball.x, ball.y,diamHit, diamHit);   
      }

      if (ball.x < 0)
      {
        p1Scrore++; 
        ResetGame();
      }
      else if (ball.x > width) 
      {
        p2Scrore++; 
        ResetGame();
      }

      //player 2 / right side
      if ( ball.x > width-30 && ball.x < width -20 && ball.y > p2Bar-rectSize/2 && ball.y < p2Bar+rectSize/2 ) {
        speedX = speedX * -1;
        ball.x += speedX;
        fill(random(0,128),random(0,128),random(0,128));
        diamHit = random(75,150);
        ellipse(ball.x, ball.y, diamHit, diamHit); 
      }
   
      // if ball hits up or down, change direction of Y  
      if ( ball.y > height || ball.y < 0 ) 
      {
        speedY = speedY * -1;
        ball.y += speedY;
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

void ResetGame()
{
  gameStart = false;
  ball.x = width/2;
  ball.y = height/2;
  speedX = random(3, 5);
  speedY = random(3, 5);
  rectSize = 150;
}