/*
 Define Layout for Button and Slider2D 
*/

void controllerLayout() {
  cp5.addButton("command")
    .setPosition(50, 50)
    .setSize(100, 80);

  cp5.addButton("takeoff")
    .setPosition(50, 150)
    .setSize(100, 80)
    ; 

   cp5.addButton("land")
   .setPosition(50, 250)
   .setSize(100,80)
   ;
/*   
   cp5.addButton("Backward")
   .setPosition(50, 350)
   .setSize(100,80)
   ;
   */
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
