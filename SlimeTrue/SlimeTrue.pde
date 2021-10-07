int[][] trail;
Agent[] agents;

int AG_NUM = 10000;
float EV = 0.1;
float DIFF = 0.75;

void setup()
{
  size(600,600);
  background(0);
  
  trail = new int[height][width];
  
  agents = new Agent[AG_NUM];
  for(int i=0; i<AG_NUM; i++)
  {
    agents[i] = new Agent(random(width), random(height-50, height-5), random(TWO_PI));
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
       float valEv = max(0, red(pixels[y*width+x])-EV);
       float valEvBlur = max(0, sum/9);
       color valEvDiff = lerpColor(color(valEvBlur), color(valEv), DIFF);
       pixels[y*width+x] = valEvDiff;
     }
  }
}
