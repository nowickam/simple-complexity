import java.util.Arrays;

class AgentCollection
{
  public Agent[] agents;
  int n;
  float EV_DIV;
  float rEV, gEV, bEV;
  color[] background;
  
  AgentCollection(int _n, int r, int g, int b, char typePosition, char typeRotation, color[] _background)
  {
    n = _n;
    agents = new Agent[n];
    background = _background;
    
    EV_DIV = 5;
    //rEV = (rB_COL-r)/EV_DIV;
    //gEV = (gB_COL-g)/EV_DIV;
    //bEV = (bB_COL-b)/EV_DIV;
    
    
    
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
      agents[i] = new Agent(x, y, rot, r, g, b, background);
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
         rEV = (red(background[y*width+x]) - red(pixels[y*width+x]))/EV_DIV;
         float valEvR = red(pixels[y*width+x])+rEV;
         float valEvBlurR = sumR/div;
         if(rEV < 0)
         {
           valEvBlurR = constrain(valEvBlurR, red(background[y*width+x]), 255);
         }
         else
         {
           valEvBlurR = constrain(valEvBlurR, 0, red(background[y*width+x]));
         }
         
         gEV = (green(background[y*width+x]) - green(pixels[y*width+x]))/EV_DIV;
         float valEvG = green(pixels[y*width+x])+gEV;
         float valEvBlurG = sumG/div;
         if(gEV < 0)
         {
           valEvBlurG = constrain(valEvBlurG, green(background[y*width+x]), 255);
         }
         else
         {
           valEvBlurG = constrain(valEvBlurG, 0, green(background[y*width+x]));
         }
         
         bEV = (blue(background[y*width+x]) - blue(pixels[y*width+x]))/EV_DIV;
         float valEvB = blue(pixels[y*width+x])+bEV;
         float valEvBlurB = sumB/div;
         if(bEV < 0)
         {
           valEvBlurB = constrain(valEvBlurB, blue(background[y*width+x]), 255);
         }
         else
         {
           valEvBlurB = constrain(valEvBlurB, 0, blue(background[y*width+x]));
         }
         
         color valEvDiffR = lerpColor(color(valEvBlurR, valEvBlurG, valEvBlurB), color(valEvR, valEvG, valEvB), DIFF);
         
         //color valEvDiffR = color(valEvR, valEvG, valEvB);
         pixels[y*width+x] = valEvDiffR;
       }
    }
  }
}
