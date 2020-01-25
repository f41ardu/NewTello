// all device handlers for UDP, mouse and controlP5 events

// udp
void receive( byte[] data ) {          // <-- default handler
  //void MYreceive( byte[] data, String ip, int port ) {   // <-- extended handler
  received = ""; 
  for (int i=0; i < data.length; i++) {
    received+=char(data[i]); 
// Debug will be removed later
    print(char(data[i]));
  }
  // Debug will be removed later
  receivedData = true;
  println();
}

// mouse 
void mousePressed() {

  { 
    if ( mousePressed && mouseButton == ' ') {
      if (input.length()>0) {
        input = input.substring(0, input.length()-1);
      }
    } else if (mousePressed && mouseButton == ' ') {
      input = "";
    } else if (mousePressed && mouseButton != ' ') {
      input = input + (key) ;
    }

    if (mousePressed && mouseButton == ' ') {
      input = input.substring(0, input.length()-1);
      input = input + ' ';
    }  
    if (mousePressed && mouseButton == ' ') {

      output = input = input.substring(0, input.length()-1);
      input = "";
    }
  }
}

// controlP5
public void controlEvent(ControlEvent theEvent) {
  // println(theEvent.getController().getName());
  buttonValue = theEvent.getController().getName();
}
