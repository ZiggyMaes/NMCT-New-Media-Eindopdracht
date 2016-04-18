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

int bolX = 0;
int bolY = 0;

int test = 100;

boolean testingGamePad = false;

boolean gameStart = false;

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
  
  controlIO = ControlIO.getInstance(this);
  noStroke();
  
  ellipseMode(CENTER);
  leap = new LeapMotionP5(this);
  fill(255);
  
  /*test = controlIO.getMatchedDevice("test");
  if (test == null) {
    println("No suitable device configured");
    exit(); // End the program NOW!
  }*/
  //ControlDevice device = controlIO.getDevice(3);
  
  
  //println(device.getInputs());
  //println(device.getHats());
  //println(device.getHat(0));
  //println(device.getSlider(0).getTotalValue());
  /*G4P.messagesEnabled(false);                                                                             
  G4P.setGlobalColorScheme(GCScheme.GREEN_SCHEME);
  if (frame != null)
    frame.setTitle("Game Input Device Configurator");
  registerMethod("dispose", this);
  TConfigUI.pathToSketch = sketchPath("");
  
  println(device);
  */
}

public void draw() {
    background(255);
   
    fill(128,128,128);
    diam = 20;
    ellipse(x, y, diam, diam);
   
    fill(p1Color);
    rect(30, mouseY-rectSize/2, 10, rectSize); //player 1 bar
    fill(p2Color);
    rect(width-30, mouseY-rectSize/2, 10, rectSize);
   
   
    if (gameStart) {
   
      x = x + speedX;
      y = y + speedY;
   
      // if ball hits movable bar, invert X direction and apply effects
      if ( x > width-30 && x < width -20 && y > mouseY-rectSize/2 && y < mouseY+rectSize/2 ) {
        speedX = speedX * -1;
        x += speedX;
        fill(random(0,128),random(0,128),random(0,128));
        diamHit = random(75,150);
        ellipse(x,y,diamHit,diamHit); 
      }
      else if ( x < 30 && x > 20 && y > mouseY-rectSize/2 && y < mouseY+rectSize/2 ) {
        speedX = speedX * -1;
        x += speedX;
        fill(random(0,128),random(0,128),random(0,128));
        diamHit = random(75,150);
        ellipse(x,y,diamHit,diamHit); 
      }
      
      // resets things if you lose
      if (x > width) {
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
    //println(test);
    //background(0);
    //ControlDevice device = controlIO.getDevice(3);
    //println(device.getSlider(0).getValue());
    //println(device.getHat(0).up());
    //println(device.getButton(1).pressed());
       
    /*if(device.getHat(0).up()){
      bolY-=10;
    }
    if(device.getHat(0).down()){
      bolY+=10;
    }
    if(device.getHat(0).left()){
      bolX-=10;
    }
    if(device.getHat(0).right()){
      bolX+=10;
    }*/
    /*if(device.getButton(1).pressed() == true){
      int projectielX = bolX;
      int projectielY = bolY;
      test = 0;
      /*ellipse(projectielX,projectielY,5,5);
      schiet(bolX,bolY);*/
      /*if(test < 100){
        projectielX += 1;
        projectielY += 1;
        ellipse(projectielX,projectielY,5,5);
        ellipse(bolX,bolY,10,10);
      }*/
    //}
    //int projectielX = bolX;
    //int projectielY = bolY;
    if(test == 0){
      int projectielX = bolX;
      int projectielY = bolY;
      while(test < 100){
        test++;
        projectielX++;
        projectielY++;
        println(projectielX + " + " + projectielY + " en " + test);
        background(0);
        ellipse(projectielX,projectielY,5,5);
        ellipse(bolX,bolY,10,10);
      }
    }
    ellipse(bolX,bolY,10,10);
    if (keyPressed) {
      if (key == 'a' || key == 'A') {
        println("ingedrukt");
        int projectielX = bolX;
        int projectielY = bolY;
        test = 0;
        ellipse(projectielX,projectielY,5,5);
        schiet(bolX,bolY, 0);
      }
    }
  }
}
public void keyPressed() {
  if (key == CODED) {
      if (keyCode == UP) {
        bolY-=10;
      } else if (keyCode == DOWN) {
        bolY+=10;
      } else if (keyCode == LEFT) {
        bolX-=10;
      } else if (keyCode == RIGHT) {
        bolX+=10;
      }
      
  }
}
public void schiet(int projectielX, int projectielY, int player){
  for (int i = 0; i < 200; i = i+1) {
      projectielX += 1;
      projectielY += 1;
      background(0);
      ellipse(projectielX,projectielY,5,5);
      ellipse(bolX,bolY,10,10);
      //background(0);
    }
}
public void mousePressed() {
  gameStart = !gameStart;
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
