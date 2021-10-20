class AgentCollection
{
  Agent[] agents;
  int n;
  float EV_DIV;
  float rEV, gEV, bEV;
  
  AgentCollection(int _n, int r, int g, int b, char typePosition, char typeRotation)
  {
    n = _n;
    agents = new Agent[n];
    
    EV_DIV = 1000;
    rEV = (rB_COL-r)/EV_DIV;
    gEV = (gB_COL-g)/EV_DIV;
    bEV = (bB_COL-b)/EV_DIV;
    
    float x, y, rot;
  
    for(int i=0; i<n; i++)
    {
      if(typePosition == 'r')
      {
        x = random(width);
        y = random(height);
      }
      else if(typePosition == 'c')
      {
        x = width/2+cos(float(i)/AG_NUM*TWO_PI)*100;
        y = height/2+sin(float(i)/AG_NUM*TWO_PI)*100;
      }
      else
      {
        x = random(width);
        y = random(height);
      }
      
      if(typeRotation == 'r')
      {
        rot = random(TWO_PI);
      }
      else if(typeRotation == 'c')
      {
        rot = -float(i)/n*TWO_PI;
      }
      else
      {
        rot = random(TWO_PI);
      }
      agents[i] = new Agent(x, y, rot, r, g, b);
    }
  }
  
  void move()
  {
    for(int i=0; i<n; i++)
    {
       agents[i].move(); 
    }
  }
  
  void turn()
  {
     for(int i=0; i<n; i++)
    {
       agents[i].turn(); 
    }
  }

  void diffuseAndEvaporate()
  {
    int div;
    for(int y = 0; y < height; y++)
    {
       for(int x = 0; x < width; x++)
       {
         float sumR, sumB, sumG;
         sumR  = sumG = sumB = 0;
         div = 0;
           for(int j = -1; j < 2; j++)
           {
             for(int i = -1; i<2; i++)
             {
               if(y+j >= 0 && x+i >= 0 && y+j <= height-1 && x+i <= width-1)
               {
                 div += 1;
                 sumR += red(pixels[(y+j)*width+(x+i)]);
                 sumG += green(pixels[(y+j)*width+(x+i)]);
                 sumB += blue(pixels[(y+j)*width+(x+i)]);
               }
             }
         }
         float valEvR = red(pixels[y*width+x])-rEV;
         float valEvBlurR = sumR/div;
         
         float valEvG = green(pixels[y*width+x])-gEV;
         float valEvBlurG = sumG/div;
         
         float valEvB = blue(pixels[y*width+x])-bEV;
         float valEvBlurB = sumB/div;
         
         color valEvDiffR = lerpColor(color(valEvBlurR, valEvBlurG, valEvBlurB), color(valEvR, valEvG, valEvB), DIFF);
         
         pixels[y*width+x] = valEvDiffR;
       }
    }
  }
}
