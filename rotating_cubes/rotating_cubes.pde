int OFF_MAX = 300;

void setup() {
  size(1080, 1060, P3D);
}

void draw() {
  background(0);
  translate(width / 2, height / 2, -OFF_MAX);
  rotateY(frameCount * .01);
  rotateX(frameCount * .01);
  rotateZ(frameCount * .01);
  
  
  for (int xo = -OFF_MAX; xo <= OFF_MAX; xo += 50) {
    for (int yo = -OFF_MAX; yo <= OFF_MAX; yo += 50) {
      for (int zo = -OFF_MAX; zo <= OFF_MAX; zo += 50) {
        pushMatrix();
        translate(xo, yo, zo);
        rotateY(frameCount * .02);
        rotateX(frameCount * .02);
        rotateZ(frameCount * .02);
        fill(colorFromOffset(xo), colorFromOffset(yo), colorFromOffset(zo));
        box((float) (20 + (Math.sin(frameCount / 20.0)) * 15));
        popMatrix();
      }
    }
  }
}

int colorFromOffset(int offset) {
  return(int) ((offset + OFF_MAX) / (2.8 * OFF_MAX) * 255);
}
