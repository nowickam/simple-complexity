int[][] trail;
Agent[] agents;

int AG_NUM = 25000;
int B_COL = 255;
int COL = 0;
float EV_DIV = 250;
float EV = (COL-B_COL)/EV_DIV;
float DIFF = 0.75;

void setup()
{
  size(900,900);
  background(B_COL);
  
  trail = new int[height][width];
  
  agents = new Agent[AG_NUM];
  for(int i=0; i<AG_NUM; i++)
  {
    agents[i] = new Agent(random(width), random(height), random(TWO_PI));
  }
}

void draw()
{
  loadPixels();
  
  diffuseAndEvaporate();
  moveAndTurn();
  
  
  updatePixels();
}

void moveAndTurn()
{
  for(int i=0; i<AG_NUM; i++)
  {
     agents[i].move(); 
  }
  for(int i=0; i<AG_NUM; i++)
  {
     agents[i].turn(); 
  }
}

void diffuseAndEvaporate()
{
  for(int y = 0; y < height; y++)
  {
     for(int x = 0; x < width; x++)
     {
       float sum = 0;
         for(int j = -1; j < 2; j++)
         {
           for(int i = -1; i<2; i++)
           {
             if(y+j >= 0 && x+i >= 0 && y+j <= height-1 && x+i <= width-1)
             {
               sum += red(pixels[(y+j)*width+(x+i)]);
             }
           }
       }
       float valEv = red(pixels[y*width+x])-EV;
       float valEvBlur = sum/9;
       color valEvDiff = lerpColor(color(valEvBlur), color(valEv), DIFF);
       pixels[y*width+x] = valEvDiff;
     }
  }
}
