import processing.pdf.*;

int R = 500;
float DN = 0.002;
float PH = 0.001;

int POINTS_NO = 20;
int N = 0;

float BCOL = 255;
int COLS = 5;
float brightness = 10;
float[][] colors2 = {{69/brightness, 185/brightness, 146/brightness}, 
                    {116/brightness, 223/brightness, 184/brightness}, 
                    {17/brightness, 72/brightness, 51/brightness}, 
                    {38/brightness, 131/brightness, 92/brightness}, 
                    {8/brightness, 92/brightness, 60/brightness}};
                    
                    
float[][] colors = {{(255-69)/brightness, (255-185)/brightness, (255-146)/brightness}, 
                    {(255-116)/brightness, (255-223)/brightness, (255-184)/brightness}, 
                    {(255-17)/brightness, (255-72)/brightness, (255-51)/brightness}, 
                    {(255-38)/brightness, (255-131)/brightness, (255-92)/brightness}, 
                    {(255-8)/brightness, (255-92)/brightness, (255-60)/brightness}};
//float[][] colors2 = {{69, 185, 146}, {116, 223, 184}, {17, 72, 51}, {38, 131, 92}, {8, 92, 60}};

Blob b;
Worley w;
Circles c;
ExpandingBlob eb;

int circlesDrawn = 0;
boolean drawn;

void setup()
{
  size(700,1000,P2D);
  background(BCOL);
  stroke(255);
  noFill();
  
  w = new Worley();
  c = new Circles();
  b = new Blob(c);
  
  eb = new ExpandingBlob(20);
  
  //w = new Worley();
  noLoop();
  
  //beginRecord(PDF, "malachite"+millis()+".pdf");
}

void draw()
{
  blendMode(SUBTRACT);
  eb.drawBlob();
  saveImg(1);
  
  //filter(BLUR, 8);
  //eb.drawBlob();
  //saveImg(2);
  println("FIN");
}

float hash(float x, float limit)
{
  return (limit)/2*sin(pow(0.99,x)*x+sin(0.2*x))+(limit)/2+0.01*log(x+1);
  //return (log(x+1)+sin(x))%(COLS-1);
  //return constrain((COLS-1)/2*sin(0.15*x)+(COLS-1)/2+0.7*sin(x)+0.7, 0, COLS-1);//+log(x+1);
  
}

void saveImg(int n)
{
  save("./img"+hour()+""+minute()+""+second()+n+".png");
}

void mousePressed()
{
  saveFrame("./img.png");
}
