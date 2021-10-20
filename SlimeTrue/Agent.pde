class Agent
{
  PVector location;
  int r, g, b;
  float rotation;
  
  float SS;              // step size
  float SA;              // sensing angle
  float SO;              // sensing offset
  float SW;              // sensor width
  float RA;              // rotation angle
  float RRA;             // random factor in the rotation angle
  
  
  
  Agent(float x, float y, float rot, int _r, int _g, int _b)
  {
    location = new PVector(x, y);
    rotation = rot;
    r = _r;
    g = _g;
    b = _b;
    
    SS = 2;               
    SA = radians(22.5);   
    SO = 15;               
    SW = 2;              
    RA = radians(12.5);     
    RRA = 0.5;      
  }
  
  void move()
  {
    // assume that loadPixels was called
    location.x += cos(rotation)*SS;
    location.y += sin(rotation)*SS;
    if(checkEdge() && attemptMove())
    {
        pixels[round(location.y)*width+round(location.x)] = color(r,g,b);
    }
    else
    {
      location.x -= cos(rotation)*SS;
      location.y -= sin(rotation)*SS;
      rotation = random(TWO_PI);
    }
  }
  
  boolean attemptMove()
  {
    // if the agents hasn not moved
    if(round(location.y)*width+round(location.x) == round(location.y-sin(rotation)*SS)*width+round(location.x-cos(rotation)*SS))
      return true;
    // if there is an agent on the spot
    return red(pixels[round(location.y)*width+round(location.x)]) != r && blue(pixels[round(location.y)*width+round(location.x)]) != b && green(pixels[round(location.y)*width+round(location.x)]) != g;
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
           sum += red(pixels[round(y+i)*width+round(x+j)])+blue(pixels[round(y+i)*width+round(x+j)])+green(pixels[round(y+i)*width+round(x+j)]);
      }
    }
    // constant denoting the right sign for the sensing 
    return ((r+g+b)-(rB_COL+gB_COL+bB_COL))*sum;
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
