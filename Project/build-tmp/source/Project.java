import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import g4p_controls.G4P; 
import g4p_controls.GAlign; 
import g4p_controls.GButton; 
import g4p_controls.GCScheme; 
import g4p_controls.GEvent; 
import g4p_controls.GLabel; 
import org.gamecontrolplus.Configuration; 
import org.gamecontrolplus.ControlDevice; 
import org.gamecontrolplus.ControlIO; 
import com.onformative.leap.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Project extends PApplet {












//Leap motion library


ControlIO controlIO;
int panelHeight;
GLabel lblPath, lblSketch;
GButton btnSelSketch;

LeapMotionP5 leap;

int p2Bar = 0;
int p2X = 0;

int test = 100;

boolean testingGamePad = true;

boolean gameStart = true;
boolean disableBall = true;

int p2Scrore = 0;
int p1Scrore = 0;

float x = 150;
float y = 150;
float speedX = random(3, 5);
float speedY = random(3, 5);
int p1Color = 0xff83ff00;
int p2Color = 0xffff0000;
int diam;
int rectSize = 150;
float diamHit;

ControlDevice gamepad;

float xPower = 550;
float yPower = 450;

float power = 1;

public void setup() {
  //size(1920,1080);
  
  p2X = width-30;
  controlIO = ControlIO.getInstance(this);
  noStroke();
  
  ellipseMode(CENTER);
  leap = new LeapMotionP5(this);
  fill(255);
  
  //kijken als de juiste controler is conected nog doen
  
  //zoek het juiste device
  if(!testingGamePad) gamepad = controlIO.getDevice(6);
  println(gamepad);
}

public void draw() {
    background(255);
//Toon score
    textSize(32);
    fill(128);
    text(p1Scrore, width/2+25, 30);
    text(p2Scrore, width/2-20, 30);
    fill(200);
    rect(width/2+10, 0, 5, height);

    fill(128,128,128);
    diam = 20;
    ellipse(x, y, diam, diam);
    
    ellipse(xPower, yPower, 50, 50);
   
    fill(p1Color);
    rect(30, mouseY-rectSize/2, 10, rectSize); //player 1 bar
    fill(p2Color);
    rect(p2X, p2Bar-rectSize/2, 10, rectSize);
   
    if (gameStart) {
   
      if(disableBall)
      {
        x = x + speedX;
        y = y + speedY;
      }

  

      //player 1 / left side 
      if ( x < 30 && x > 20 && y > mouseY-rectSize/2 && y < mouseY+rectSize/2 ) {
        speedX = speedX * -1;
        x += speedX;
        fill(random(0,128),random(0,128),random(0,128));
        diamHit = random(75,150);
        ellipse(x,y,diamHit,diamHit);   
      }

      if (x < 0) {
        p1Scrore++; 
        gameStart = false;
        x = 150;
        y = 150;
        speedX = random(3, 5);
        speedY = random(3, 5);
        rectSize = 150;
      }

      //player 2 / right side
      if ( x > p2X && x < p2X+10 && y > p2Bar-rectSize/2 && y < p2Bar+rectSize/2 ) {
        speedX = speedX * -1;
        x += speedX;
        fill(random(0,128),random(0,128),random(0,128));
        diamHit = random(75,150);
        ellipse(x,y,diamHit,diamHit); 
      }
      
      if ( xPower > p2X && xPower < p2X+10 && yPower > p2Bar-rectSize/2 && yPower < p2Bar+rectSize/2 ) {
        power = round(power);
        if(power == 1){
          rectSize = 75;
           println("1");
           setNewPowerup();
           int s = second(); 
           println(s);
           int stoppower = s + 10;
           if(s == stoppower){
             rectSize = 150;
           }
         }
         if(power == 2){
           println("2");
           setNewPowerup();
         }
         if(power == 3){
           println("3");
           setNewPowerup();
         } 
        
      }

      // resets things if you lose
      if (x > width) {
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


  if(testingGamePad == false){
    //controler hat besturing
    if(gamepad.getHat(0).up()){
      p2Bar-=10;
    }
    if(gamepad.getHat(0).down()){
      p2Bar+=10;
    }
    //controler knop ingedrukt
    if(gamepad.getButton(1).pressed() == true && p2X == width/2+20){
      p2X -= 0;
    }else if(gamepad.getButton(1).pressed()){
      p2X -= 1;
    }else{
      p2X = width-30;
    }
    //};
  }
}
public void setNewPowerup(){
  xPower = random(width /2, width);
  yPower = random(0 , height);
  power = random(0.5f,3.5f);
  println(xPower + " " + yPower + " " + power);
}
public void keyPressed() {
  if (key == CODED) {
      if (keyCode == UP) {
        p2Bar -= 20;
      } else if (keyCode == DOWN) {
        p2Bar += 20;
      } 
  }
}
public void mousePressed() {
  gameStart = true;
}
  public void settings() {  size(800,600);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Project" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
