import java.util.Comparator; 
import java.util.*;

class Circle
{
  float x, y, radius;
  
  Circle(float _x, float _y, float _r)
  {
    x = _x;
    y = _y;
    radius = _r;
  }
  
  void drawCircle()
  {
    stroke(0);
    ellipse(x,y,2*radius,2*radius);
  }

}

class Circles
{
  ArrayList<Circle> circles;
  int minRadius, maxRadius, totalCircles, createCircleAttempts;

  Circles()
  {
    minRadius = 20;
    maxRadius = 300;
    totalCircles = 1000;
    createCircleAttempts = 500;
    circles = new ArrayList<Circle>();

    for ( var i = 0; i < totalCircles; i++ )
    {
      createCircles();
    }
    
    
    //for ( var c : circles )
    //{
    //  c.drawCircle();
    //}
   
  }

  void createCircles() 
  {
    boolean circleSafeToDraw = false;
    Circle newCircle = null;
    for(int tries = 0; tries < createCircleAttempts; tries++)
    {
      //newCircle = new Circle(random(width), random(height), minRadius);
      newCircle = new Circle(random(width), random(height), minRadius);
      if(doesCircleHaveACollision(newCircle))
      {
        continue;
      }
      else
      {
        circleSafeToDraw = true;
        break;
      }
    }
      
    if(!circleSafeToDraw)
    {
      return;
    }
    
    for(int radius = minRadius; radius < maxRadius; radius++)
    {
      newCircle.radius = radius;
      if(doesCircleHaveACollision(newCircle))
      {
        newCircle.radius--;
        break;
      }
    }
    circles.add(newCircle);
  }
  
  boolean doesCircleNotInside(Circle circle)
  {
    return (circle.x-circle.radius < 0 || circle.y - circle.radius < 0 || 
            circle.x+circle.radius >= width || circle.y + circle.radius >= height);
  }

  boolean doesCircleHaveACollision(Circle circle) 
  {
    for(int j = 0; j < circles.size(); j++)
    {
      Circle otherCircle = circles.get(j);
      float a = circle.radius + otherCircle.radius;
      float x = circle.x - otherCircle.x;
      float y = circle.y - otherCircle.y;
      
      if(sqrt(x*x+y*y)<a)
      {
        return true;
      }
    }
    
    if (circle.x-circle.radius < 0 || circle.y - circle.radius < 0 || 
        circle.x+circle.radius >= width || circle.y + circle.radius >= height)
      return true;


    return false;
  }
}
