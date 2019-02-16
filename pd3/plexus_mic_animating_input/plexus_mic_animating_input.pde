// Example 20-5: Live Input with Sonia

import processing.sound.*;

AudioIn input;
Amplitude analyzer;

Ball b[];
int k = 100;

void setup() {
size(700, 700);

// Start listening to the microphone
// Create an Audio input and grab the 1st channel
input = new AudioIn(this, 0);

// start the Audio Input
input.start();

// create a new Amplitude analyzer
analyzer = new Amplitude(this);

// Patch the input to an volume analyzer
analyzer.input(input);

// create ball
b = new Ball[55];
for(int i=0;i<b.length;i++)
{
b[i] = new Ball(random(50,width),random(50,height),random(4,7),random(2,4));
}

}

void draw() {
background(0);

fill(0);
stroke(255);

plexus();

}

class Ball
{

// Get the overall volume (between 0 and 1.0)
float vol = analyzer.analyze();

float x,y,dx,dy;
Ball(float x, float y, float dx, float dy)
{
this.x = x;
this.y = y;
this.dx = dx;
this.dy = dy;
BallMoved();
}
void BallMoved()
{
x+=dx;
y+=dy;
if(x>width || x<0)dx = -dx;
if(y>height || y<0)dy = -dy;
ellipse(x,y,3,3);
}
}

void plexus()
{
for(int i=0;i<b.length;i++)
{
b[i].BallMoved();
for(int j=0;j<b.length;j++)
{
if(b[i].x-b[j].x<k && b[i].y-b[j].y<k && b[i].x-b[j].x>-k && b[i].y-b[j].y>-k)
{
stroke(255);
line(b[i].x,b[i].y,b[j].x,b[j].y);
}
}
}
}
