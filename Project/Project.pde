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

int bolX = 0;
int bolY = 0;

int test = 100;

boolean testingGamePad = false;

public void setup() {
  size(800,600);
  controlIO = ControlIO.getInstance(this);
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
  if(testingGamePad == true){
    //println(test);
    background(0);
    ControlDevice device = controlIO.getDevice(3);
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
  }
}
void keyPressed() {
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
      if (keyCode == 'a') {
        int projectielX = bolX;
        int projectielY = bolY;
        test = 0;
      }
    }
}
public void schiet(int projectielX, int projectielY, int player){
  for (int i = 0; i < 200; i = i+1) {
      projectielX += 1;
      projectielY += 1;
      //background(0);
      ellipse(projectielX,projectielY,5,5);
      ellipse(bolX,bolY,10,10);
      //background(0);
    }
}