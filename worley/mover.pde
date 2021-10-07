class Mover
{
  PVector location, velocity, acceleration;
  
  Mover()
  {
    location = new PVector(random(width), random(height), random(height));
    velocity = new PVector(random(-3,3), random(-3,3), random(-3,3));
    acceleration = new PVector(0,0,0);
  }
  
  void move()
  {
    checkEdge();
    //acceleration.add(new PVector(mouseX-location.x, mouseY-location.y, mouseY-location.z));
    //acceleration.normalize();
    //velocity.add(acceleration);
    location.x += velocity.x;
    location.y += velocity.y;
    location.z += velocity.z;
    //acceleration.x = acceleration.y = acceleration.z = 0;
    
  }
  
  void checkEdge()
  {
    if(location.x < 0 || location.x > width)
    {
      velocity.x *= -1;
    }
    if(location.y < 0 || location.y > height)
    {
      velocity.y *= -1;
    }
    if(location.z < 0 || location.z > height)
    {
      velocity.z *= -1;
    }
  }
    
}
