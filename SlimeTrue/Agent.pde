float SS = 0.5;
float SA = radians(22.5);
float SO = 9;
float SW = 1;
float RA = radians(45);

class Agent
{
  PVector location;
  float rotation;
  
  Agent(float x, float y, float r)
  {
    location = new PVector(x, y);
    rotation = r;
  }
  
  void move()
  {
    // assume that loadPixels was called
    location.x += cos(rotation)*SS;
    location.y += sin(rotation)*SS;
    if(checkEdge() && attemptMove())
    {
        pixels[round(location.y)*width+round(location.x)] = color(255);
    }
    else
    {
      rotation = random(TWO_PI);
    }
  }
  
  boolean attemptMove()
  {
    if(round(location.y)*width+round(location.x) == round(location.y-sin(rotation)*SS)*width+round(location.x-cos(rotation)*SS))
      return true;
    return red(pixels[round(location.y)*width+round(location.x)]) < 255;
  }
  
  boolean checkEdge()
  {
    if(round(location.x) < 0 || round(location.x) >= width || 
       round(location.y) < 0 || round(location.y) >= height)
      return false;
    return true;
  }
  
  float sense(float rotDelta)
  {
    float x, y, sum;
    sum = 0;
    x = location.x+cos(rotation+rotDelta)*SO;
    y = location.y+sin(rotation+rotDelta)*SO;
    for(float i=-SS; i <=SS; i++)
    {
      for(float j=-SS; j<=SS; j++)
      {
         if(round(x+j) >= 0 && round(x+j) < width && round(y+i) >= 0 && round(y+i) < height)
           sum += red(pixels[round(y+i)*width+round(x+j)]);
      }
    }
    return sum;
  }
  
  void turn()
  {
    float F, FL, FR;
    F = sense(0);
    FR = sense(SA);
    FL = sense(-SA);
    
    if(F > FL && F > FR)
      return;
    else if(F < FL && F < FR)
      rotation += random(-1,1)*RA;
    else if(FL < FR)
      rotation += RA;
    else if(FR < FL)
      rotation -= RA;
  }
}
