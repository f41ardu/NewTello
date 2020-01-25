/* 
 (c) 01/2020 f41ardu
 MIT Lisence 
 Start new devlopment for Tello using Processing 
 Platform Raspberry PI 3+ 
*/ 

import controlP5.*;
import hypermedia.net.*;

ControlP5 cp5; 
Slider2D slider1, slider2; 

UDP udp;

String ip = "192.168.10.1";
int port =8889;
int start = 0;
int time = 0; 

String received ="";
Boolean receivedData = false;
String input= "";
String output = "";
String buttonValue="";
String controllCommand="";
boolean debug = false; 

PFont font;

void setup() {

  size(800, 500);

  font = createFont("SansSerif.plain", 40);
  textFont(font, 20);
  textAlign(LEFT, CENTER);

  cp5 = new ControlP5(this);
  controllerLayout();
 
  
  //UDP setup using default handler receive
  udp = new UDP(this, 9000);
  udp.log(false);
  udp.listen(true);

  // https://stackoverflow.com/questions/58980573/how-to-implement-rc-command-on-virtual-joystick
  // Now for the continuous control over the aircraft you need 
  // to send the virtualStickData with at least 5 Hz.
  //frameRate(10); 

  // set tello into sdk mode 
  byte[] byteBuffer = "command".getBytes();
  udp.send(byteBuffer, ip, port );   // the message to send

  
}

void draw() {
  background(0);

  fill(0, 250, 0);

  text("DJI Tello Control", 150, 30);
  // show what Tello tell us 
  text("Received:" + received, 150, 70);
  // show time 
  int m = (millis()-start)/1000;
  text("Time:" +  m, 150, 110);
  if (buttonValue != "Stick1" && buttonValue != "Stick2") {
    if (debug) println(buttonValue); 
    sendData(buttonValue); 
    buttonValue="";
  }

  // a: left/right (-100~100)
  int a = int(slider2.getArrayValue()[0]);
  // a: forward/backward (-100~100)
  int b = -int(slider2.getArrayValue()[1]);
  // c: up/down (-100~100)
  int c = -int(slider1.getArrayValue()[1]);
  // d: yaw (-100~100)
  int d = int(slider1.getArrayValue()[0]);
  //println(a+" "+b+" "+c+" "+d);
  controllCommand = "rc "+a+" "+b+" "+c+" "+d; 
  // println(controllCommand);
  // here send rc command every 500 ms
  if (millis() > time + 40)
  {
    if (debug) {
      println("we send");
      println(controllCommand);
    }
    sendData(controllCommand);
    time = millis();
  }
  
  // if mouse is released reset sliders
  slider1.setValue(0, 0);
  slider2.setValue(0, 0);
}

// might be not needed 
void sendData(String inputData) {
  if (input != "") { 
    // udp send require byteArray
    byte[] byteBuffer = inputData.getBytes();
    udp.send(byteBuffer, ip, port );   // the message to send
  }
}


void toggle(boolean theFlag) {
  if (theFlag==true) {
    int s = 5;
  } else {
    int s = 6;
  }
  println("a toggle event.");
}
