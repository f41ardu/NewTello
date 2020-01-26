/* 
 (c) 01/2020 f41ardu
 MIT Lisence 
 Start new devlopment for Tello using Processing 
 Platform Raspberry PI 3+ 
 Version 1.1.0 base for further development
*/ 

import controlP5.*;
import hypermedia.net.*;
import gohai.glvideo.*; 

// define control objects
ControlP5 cp5; 
Toggle takeoff,video;
Slider2D slider1, slider2; 

UDP udp;       // define UDP object 
GLVideo videostream; // define VIDEO object


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
boolean toggleValue = false;
boolean toggleStart = false; 
boolean debug = false; 

PFont font;

void setup() {

  size(800, 500 ,P3D);

  font = createFont("SansSerif.plain", 40);
  textFont(font, 20);
  textAlign(LEFT, CENTER);

  cp5 = new ControlP5(this);
  controllerLayout();
 
  //UDP setup using default handler receive
  udp = new UDP(this, 9000);
  udp.log(false);
  udp.listen(true);
  
  // we connect to Tello via this custom GStreamer pipeline
  videostream = new GLVideo(this, "udpsrc port=11111 ! decodebin", GLVideo.NO_SYNC);
  videostream.play();
  frameRate(20); 

  // set tello into sdk mode 
  byte[] byteBuffer = "command".getBytes();
  udp.send(byteBuffer, ip, port );   // the message to send

  
}

void draw() {
  background(0);

  fill(0, 250, 0);

  text("DJI Tello Control V1.0", 50, 30);
  // show what Tello tell us 
  text("Received:" + received, 50, 70);
  // show time 
  int m = (millis()-start)/1000;
  text("Time:" +  m, 50, 110);
  text("Send:               " , 50, 140);
  if (buttonValue != "") {
    text("Send:" + buttonValue, 50, 140);
  }
  if (buttonValue != "") {
    if (debug) println(buttonValue); 
    sendData(buttonValue); 
    buttonValue="";
  }
  
   toggleValue = video.getBooleanValue();
   if(toggleValue==true) {
    if (debug) println("Toggle On"); 
    video.setStringValue("Streamon"); 
    video.setColorActive(color(255,0, 0)); 
  } else {
    if (debug) println("Toggle Off"); 
    video.setStringValue("Streamoff");
    video.setColorActive(color(0,255,0)); 
  }
   toggleStart = takeoff.getBooleanValue();
   if(toggleStart==true) {
    if (debug) println("takeoff"); 
    takeoff.setStringValue("takeoff"); 
    takeoff.setColorActive(color(255,0, 0)); 
  } else {
    if (debug) println("land"); 
    takeoff.setStringValue("land");
    takeoff.setColorActive(color(0,255,0)); 
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
  if (debug) println(controllCommand);
  // here we send rc command every 100 ms
  if (millis() > time + 50)
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
  
  if (videostream.available()) {
    videostream.read();
    //println(video.width()+":"+video.height());
  }
  image(videostream, 300, 5, 620/2, 480/2);
}

// might be not needed 
void sendData(String inputData) {
  if (input != "") {
    if (debug) println(inputData);
    // udp send require byteArray
    byte[] byteBuffer = inputData.getBytes();
    udp.send(byteBuffer, ip, port );   // the message to send
  }
}
