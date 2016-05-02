import g4p_controls.G4P;
import g4p_controls.GAlign;
import g4p_controls.GButton;
import g4p_controls.GCScheme;
import g4p_controls.GEvent;
import g4p_controls.GLabel;

import org.gamecontrolplus.Configuration;
import org.gamecontrolplus.ControlDevice;
import org.gamecontrolplus.ControlIO;

//Leap motion libraries
import com.onformative.leap.*;
import com.leapmotion.leap.*;

//Library objects
ControlIO controlIO;
ControlDevice gamepad;
LeapMotionP5 leap;

//Player Variables
PVector p1Pos = new PVector(0,0);
PVector p2Pos = new PVector(0,0);
PVector p1Size = new PVector(10, 150);
PVector p2Size = new PVector(10, 150);
int p1Score = 0;
int p2Score = 0;
color p1Color = #83ff00;
color p2Color = #ff0000;

//Game Variables
boolean gameStart = false;
//--Ball
PVector ballPos = new PVector(0, 0);
PVector ballSpeed = new PVector(random(3, 5), random(3, 5));
int ballDia;
//--Powerups
boolean powerUp = false;
color[] powerUpColors = {#FF0000, #00FF00, #0000FF}; 
PVector powerUpPos = new PVector(550, 450);
float powerUpId = random(1, 3+1);
float previousPowerUp;
int endPowerTime;

public void setup()
{
  controlIO = ControlIO.getInstance(this);
  leap = new LeapMotionP5(this);
  gamepad = controlIO.getDevice(6);

  size(800,600);
  noStroke();
  smooth();
  ellipseMode(CENTER);
  fill(255);

  p1Pos.x = 30;
  p1Pos.y = height/2 - p1Size.y/2;

  p2Pos.x = width - 30 - p2Size.x;
  p2Pos.y = height/2 + p2Size.y/2;
}

public void draw() 
{
  //Variables
  PVector handPos = new PVector();
  ArrayList<Hand> hands = leap.getHandList();
  int sec = second();
  float hitDia;
  ballDia = 20;

  background(255);

  //Display score
  textSize(32);
  fill(128);
  text(p1Score, width/2+25, 30);
  text(p2Score, width/2-20, 30);
  fill(200);
  rect(width/2+10, 0, 5, height);

  //Render ball
  fill(128,128,128);
  ellipse(ballPos.x, ballPos.y, ballDia, ballDia);

  if(hands.size() == 1)
  {  
      for (Hand h : hands) { p1Pos.y = leap.getPosition(h).y; }
  }
 
  //Render player bars
  fill(p1Color);
  rect(p1Pos.x, p1Pos.y-p1Size.y/2, p1Size.x, p1Size.y);
  fill(p2Color);
  rect(p2Pos.x, p2Pos.y-p2Size.y/2, p2Size.x, p2Size.y);
  
  //Game runtime logic
  if (gameStart) 
  {
    ballPos.x += ballSpeed.x;
    ballPos.y += ballSpeed.y;

    //Player 1 / left player collision detection
    if (ballPos.x <= p1Pos.x && ballPos.x >= p1Pos.x-p1Size.x && ballPos.y > p1Pos.y-p1Size.y/2 && ballPos.y < p1Pos.y + p1Size.y/2)
    {
      ballSpeed.x *= -1; // Invert ball
      ballPos.x += ballSpeed.x;
      //Hit marker when ball collides with player bar
      fill(random(0,128),random(0,128),random(0,128));
      hitDia = random(75,150);
      ellipse(ballPos.x, ballPos.y, hitDia, hitDia);   
    }

    //scoring
    if (ballPos.x < 0)
    {
      p1Score++; 
      gameStart = false;
      ballPos.x = 150;
      ballPos.y = 150;
      ballSpeed.x = random(3, 5);
      ballSpeed.y = random(3, 5);
      p1Size.y = 150;
      p2Size.y = 150;
    }
    else if (ballPos.x > width) 
    {
      p2Score++; 
      gameStart = false;
      ballPos.x = 150;
      ballPos.y = 150;
      ballSpeed.x = random(3, 5);
      ballSpeed.y = random(3, 5);
      p1Size.y = 150;
      p2Size.y = 150;
    }


    //player 2 / right side
    if ( ballPos.x > p2Pos.x && ballPos.x < p2Pos.x+10 && ballPos.y > p2Pos.y-p2Size.y/2 && ballPos.y < p2Pos.y+p2Size.y/2 )
    {
      ballSpeed.x *= -1;
      ballPos.x += ballSpeed.x;
      fill(random(0,128),random(0,128),random(0,128));
      hitDia = random(75,150);
      ellipse(ballPos.x, ballPos.y, hitDia, hitDia);  
    }
    
    if ( powerUpPos.x + 25 > p2Pos.x && powerUpPos.x - 25 < p2Pos.x + 10 && powerUpPos.y + 25 > p2Pos.y-p2Size.y/2 && powerUpPos.y - 25 < p2Pos.y + p2Size.y / 2 ) 
    {
      powerUpId = round(powerUpId);

      if(powerUpId == 1 && powerUp == true)
      {
         p1Size.y = 75;
         p2Size.y = 150;
         previousPowerUp = powerUpId;
         endPowerTime = sec + 10;
         powerUp = false;
       }
       if(powerUpId == 2 && powerUp == true)
       {
         p1Size.y = 150;
         p2Size.y = 300;
         previousPowerUp = powerUpId;
         endPowerTime = sec + 10;
         powerUp = false;
       }
       if(powerUpId == 3 && powerUp == true)
       {
         p1Size.y = 150;
         p2Size.y = 150;
         ballSpeed.x = random(3, 5)+2;
         ballSpeed.y = random(3, 5)+2;
         powerUp = false;
       }
    }

    if(sec == endPowerTime)
    {
      if(previousPowerUp == 1) p1Size.y = 150;
      else if(previousPowerUp == 2) p2Size.y = 150;
    }
 
    if (ballPos.y > height || ballPos.y < 0 ) 
    {
      ballSpeed.y *= -1;
      ballPos.y += ballSpeed.y;
    }
  }

  //controler hat besturing
  if(gamepad.getHat(0).up() && p2Pos.y - p2Size.y/2 - 20 > 0) p2Pos.y -= 5;
  if(gamepad.getHat(0).down() && p2Pos.y + p2Size.y/2 + 20 < height) p2Pos.y += 5;
  if(gamepad.getHat(0).left() && p2Pos.x > width/2+20) p2Pos.x -= 1;

  if(gamepad.getHat(0).right() && p2Pos.x < width-20) p2Pos.x += 1;

  if(sec%20 == 0 && powerUp == false)
  {
      powerUp = true;
      generateNewPowerup();
  }
  if(powerUp == true)
  {
    fill(powerUpColors[int(powerUpId-1)]);
    ellipse(powerUpPos.x, powerUpPos.y, 50, 50);
  }
}
void generateNewPowerup()
{
  powerUpPos.x = random(width/2 + 55, width - 55);
  powerUpPos.y = random(0 + 55, height - 55);
  powerUpId = random(0.5,3.5);
}
void keyPressed()
{
  if (key == CODED) 
  {
      if (keyCode == UP) p2Pos.y -= 20;
      else if (keyCode == DOWN) p2Pos.y += 20;
  }
}
void mousePressed() { gameStart = true; }