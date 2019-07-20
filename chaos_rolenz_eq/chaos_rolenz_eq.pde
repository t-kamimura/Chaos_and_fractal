/* Rolenz_equation                         */
/* ローレンツ方程式の曲線を２次元上に描く    */
/* ３次元もやってみたいが，今後の課題とする  */
/*               copyright Tomoya Kamimura */

float x = 100, y = 100, z = 100;
float X,Y;
static float theta = -PI/4;
static float dt = 0.00005;
static int rateX = 15, rateY = 30;
static float a =  10, b = 28, c = 8/3;
 
void setup() {
  size(800, 800);
  blendMode(ADD);
  background(1);
  stroke(120, 120, 255, 10);
  println(x);
}
 
void draw() {
  float dx, dy, dz;
  float _X=x, _Y=y;
  println(x);
  //background(1);
  for (int i = 0; i < 10000; i++) {
 
    dx = -a*x + a*y;
    dy = -x*z + b*x - y;
    dz = x*y - c*z;
    
    x = x+dx*dt;
    y = y+dy*dt;
    z = z+dz*dt;
    
    X = x*cos(theta) - y*sin(theta);
    Y = x*sin(theta) + y*cos(theta);
    point(X*rateX + 0.5*width, Y*rateY + 0.5*height);
    _X = X;
    _Y = Y;
  }
}
