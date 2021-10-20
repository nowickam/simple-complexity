class Worley
{
  PVector[] points;
  float xoff, yoff, off;
  
  Worley()
  {
     points = new PVector[POINTS_NO];
    for(int i = 0; i < POINTS_NO; i++)
    {
      points[i] = new PVector(random(width), random(height));
    }
    xoff = 0;
    yoff = 0;
    off = 0.00001;
   
  }
  
  void drawWorley()
  {
    loadPixels();
    for(int y = 0; y < height; y++)
    {
       for(int x = 0; x < width; x++)
       {
         int index = y * width + x;
         float[] distances = new float[POINTS_NO];
         float angle = noise(xoff,yoff)*TWO_PI;
         PVector vec = PVector.fromAngle(angle);
         stroke(255);
         vec.mult(8);
         xoff += off;
         yoff += off;
         for(int i = 0; i < POINTS_NO; i++)
         {
           float d = dist(points[i].x, points[i].y, x+vec.x, y+vec.y);
           distances[i] = d;
         }  
         
         distances = sort(distances);
         
         float r = colors[round(hash(distances[N], COLS-1))%COLS][0]+map(noise(distances[N]), 0, 1, -30, 30);
         float g = colors[round(hash(distances[N], COLS-1))%COLS][1]+map(noise(distances[N]), 0, 1, -30, 30);
         float b = colors[round(hash(distances[N], COLS-1))%COLS][2]+map(noise(distances[N]), 0, 1, -30, 30);
         
         //float r = colors[round(map(hash(distances[N]), 0, width/8, 0, 4))%COLS][0]+noise(distances[N])*20;
         //float g = colors[round(map(hash(distances[N]), 0, width/8, 0, 4))%COLS][1]+noise(distances[N])*20;
         //float b = colors[round(map(hash(distances[N]), 0, width/8, 0, 4))%COLS][2]+noise(distances[N])*20;
         
         pixels[index] = color(r,g,b);
       }
    }
  
  updatePixels();
  }
}
