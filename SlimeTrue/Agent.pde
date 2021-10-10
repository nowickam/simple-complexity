float SS = 1;                // step size
float SA = radians(22.5);    // sensing angle
float SO = 9;                // sensing offset
float SW = 2;                // sensor width
float RA = radians(45);      // rotation angle
float RRA = 0.5;             // random factor in the rotation angle


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
        pixels[round(location.y)*width+round(location.x)] = color(COL);
    }
    else
    {
      rotation = random(TWO_PI);
    }
  }
  
  boolean attemptMove()
  {
    // if the agents hasn not moved
    if(round(location.y)*width+round(location.x) == round(location.y-sin(rotation)*SS)*width+round(location.x-cos(rotation)*SS))
      return true;
    // if there is an agent on the spot
    return red(pixels[round(location.y)*width+round(location.x)]) != COL;
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
    // location of the sensor
    x = location.x+cos(rotation+rotDelta)*SO;
    y = location.y+sin(rotation+rotDelta)*SO;
    // kernel SSxSS 
    for(float i=-SW; i <=SW; i++)
    {
      for(float j=-SW; j<=SW; j++)
      {
         if(round(x+j) >= 0 && round(x+j) < width && round(y+i) >= 0 && round(y+i) < height)
           sum += red(pixels[round(y+i)*width+round(x+j)]);
      }
    }
    // constant denoting the right sign for the sensing 
    return (COL-B_COL)*sum;
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
      rotation += random(-RRA, RRA)*RA + RA;
    else if(FR < FL)
      rotation -= random(-RRA, RRA)*RA + RA;
  }
}
