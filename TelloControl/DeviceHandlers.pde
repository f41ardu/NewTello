/* 
 (c) 01/2020 f41ardu
 MIT Lisence 
 Start new devlopment for Tello using Processing 
 Platform Raspberry PI 3+ 
 Version 1.1.1 add second device handle  
*/ 

// all device handlers for UDP, mouse and controlP5 events

// udp
void receive( byte[] data, String ip, int port) {          // <-- default handler
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

// udp
void MYreceive( byte[] data2, String ip2, int port2 ) {   // <-- extended handler
  myreceived = ""; 
  for (int i=0; i < data2.length; i++) {
    myreceived+=char(data2[i]); 
// Debug will be removed later
    print(char(data2[i]));
  }
  // Debug will be removed later
  myreceivedData = true;
  println();
}

// controlP5
public void controlEvent(ControlEvent theEvent) {
  // println(theEvent.getController().getName());
  //buttonValue = theEvent.getController().getName();
  buttonValue = theEvent.getController().getStringValue(); 
}
