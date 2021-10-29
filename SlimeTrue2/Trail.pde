int POINTS_NO = 3;
float[][] points = new float[POINTS_NO][2];
int N = 0;

color[] makeTrail()
{
  color trail[];

    loadPixels();
    
    for(int i=0;i<POINTS_NO;i++)
    {
      points[i][0] = random(width);
      points[i][1] = random(height);
    }

    trail = new color[(height-1)*width+width];
    
    for(int y = 0; y < height; y++)
    {
       for(int x = 0; x < width; x++)
       {
         int index = y * width + x;
         float[] distances = new float[POINTS_NO];
         for(int i = 0; i < POINTS_NO; i++)
         {
           float d = dist(points[i][0], points[i][1], x, y);
           distances[i] = d;
         }
         
         distances = sort(distances);
         
         float[] colorClose = new float[]{8, 92, 60};
         float[] colorFar = new float[]{38, 131, 92};
         float r = map(distances[N], 0, width/13, colorClose[0], colorFar[0]);
         float g = map(distances[N], 0, width/13, colorClose[1], colorFar[1]);
         float b = map(distances[N], 0, width/13, colorClose[2], colorFar[2]);
         
         pixels[index] = color(r,g,b);
         trail[index] = color(r,g,b);
      }
    }
    updatePixels();
    return trail;
  }
