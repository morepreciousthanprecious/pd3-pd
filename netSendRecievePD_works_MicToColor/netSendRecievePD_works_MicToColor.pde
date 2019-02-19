import processing.net.*;

Server tcpServer=null;
Client client;

int position;
int rad = 60;        // Width of the shape
float xpos, ypos;    // Starting position of shape    

float xspeed = 2.8;  // Speed of the shape
float yspeed = 2.2;  // Speed of the shape

int xdirection = 1;  // Left or Right
int ydirection = 1;  // Top to Bottom


void setup() 
{
  tcpServer = new Server(this, 3443);
  client = new Client(this, "127.0.0.1", 3445);
  size(640, 360);
  noStroke();
  frameRate(30);
  ellipseMode(RADIUS);
  // Set the starting position of the shape
  xpos = width/2;
  ypos = height/2;
}

void draw() 
{

  if (tcpServer!=null) {
    Client c = tcpServer.available();
    while (c!=null && c.available()>0) {
      //get message from Pure Data
      String msg = c.readString().trim();
      if (msg.indexOf("\n") > 0) {
      String num = msg.replace(" ","").replace(";", "").replace(".", "").substring(0, msg.indexOf("\n") -1);
        position = Integer.parseInt(num);   
      }
      println(msg);
      //println("123");
    }
  }


  background(position);

  // Update the position of the shape
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );

  // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
  if (xpos > width-rad || xpos < rad) {
    xdirection *= -1;
  }
  if (ypos > height-rad || ypos < rad) {
    ydirection *= -1;
  }
  // Draw the shape
  ellipse(xpos, ypos, rad, rad);
  xspeed = position;
  yspeed = position;
}
