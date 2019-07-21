static final int MAX_LEVEL = 5;
static final int VERT_NUM = 5;
static final float k = 0.5;
static final int alpha = 120;

void setup() {
  size(800, 800);
  background(0);
  blendMode(ADD);
  noFill();
  
  float x = width / 2;
  float y = height / 2;
  float r = 200;
  
  fractalLoop(r, x, y, 0);

}

void fractalLoop(float _r, float _x, float _y, int level) {
  
  if (level > MAX_LEVEL) return;
    
  stroke(12 + 30 * level, 30 * level, 12 + 50 * level, alpha);
  
  drawShape(_r, _x, _y);

  for (int i = 0; i < VERT_NUM; i++) {
    float x = _r * cos(TWO_PI / VERT_NUM * (i+0.5)) + _x;
    float y = _r * sin(TWO_PI / VERT_NUM * (i+0.5)) + _y;
    
    fractalLoop(_r * k, x, y, level + 1);
  }  
}

void drawShape(float _r, float _x, float _y) {
  
  beginShape();
  for (int i = 0; i < VERT_NUM; i++) {
    
    float x = _r * cos(TWO_PI / VERT_NUM * i) + _x;
    float y = _r * sin(TWO_PI / VERT_NUM * i) + _y;
    
    vertex(x, y);
  }
  endShape(CLOSE);
}
