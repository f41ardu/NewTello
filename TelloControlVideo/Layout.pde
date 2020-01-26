/* 
 (c) 01/2020 f41ardu
 MIT Lisence 
 Start new devlopment for Tello using Processing 
 Platform Raspberry PI 3+ 
 Version 1.0.1 base for further development
*/ 

// Define Layout for Button and Slider2D 


void controllerLayout() {
  cp5.addButton("command")
    .setStringValue("command") 
    .setPosition(50, 250)
    .setSize(80, 80)
    ;

// create a start toggle and change the default look to a (on/off) switch look
  takeoff = cp5.addToggle("Takeoff/Land")
     .setPosition(50,350)
     .setStringValue("land") 
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setColorBackground(color(0))
     .setSize(80,40)
     ;
// create a video toggle and change the default look to a (on/off) switch look
  video = cp5.addToggle("Video")
     .setPosition(50,430)
     .setStringValue("Streamoff") 
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setColorBackground(color(0))
     .setSize(80,40)
//     .hide()
     ;

  slider1 = cp5.addSlider2D("Stick1")
    .setPosition(210, 300)
    .setSize(150, 150)
    .setMinMax(-100, -100, 100, 100)
    .setValue(0, 0)
    .setColorBackground(color(255, 255, 0))
    //.disableCrosshair()
    ;
  slider2 = cp5.addSlider2D("Stick2")
    .setPosition(480, 300)
    .setSize(150, 150)
    .setMinMax(-100, -100, 100, 100)
    .setValue(0, 0)
    .setColorBackground(color(255, 0, 0))
    //.disableCrosshair()
    ;
}
