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
PVector speed = new PVector(random(3,5), random(3,5));

int diam;
int rectSize = 150;
float diamHit;

public void setup() {
  
  controlIO = ControlIO.getInstance(this);
  noStroke();
  
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
    rect(width/2-2.5f, 0, 5, height);

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
   
      ball.x += speed.x;
      ball.y += + speed.y;
  

      //player 1 / left side 
      if ( ball.x < 30 && ball.x > 20 && ball.y > mouseY-rectSize/2 && ball.y < mouseY+rectSize/2 ) 
      {
        speed.x *= -1;
        ball.x += speed.x;
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
        speed.x = speed.x * -1;
        ball.x += speed.x;
        fill(random(0,128),random(0,128),random(0,128));
        diamHit = random(75,150);
        ellipse(ball.x, ball.y, diamHit, diamHit); 
      }
   
      // if ball hits up or down, change direction of Y  
      if ( ball.y > height || ball.y < 0 ) 
      {
        speed.y = speed.y * -1;
        ball.y += speed.y;
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

public void ResetGame()
{
  gameStart = false;
  ball.x = width/2;
  ball.y = height/2;
  speed.x = random(3, 5);
  speed.y = random(3, 5);
  rectSize = 150;
}
  public void settings() {  size(1920,1080);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Project" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
