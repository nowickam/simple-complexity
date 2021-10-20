int POINTS_NO = 5;
float[][] points = new float[POINTS_NO][2];
int N = 0;

void makeTrail()
{
  int trail[][];

    loadPixels();
    for(int i=0;i<POINTS_NO;i++)
    {
      points[i][0] = random(width);
      points[i][1] = random(height);
    }

    trail = new int[width][height];
    loadPixels();
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
         
         float[] colorFar = new float[]{116, 223, 184};
         float[] colorClose = new float[]{69, 185, 146};
         float r = map(distances[N], 0, width/8, colorClose[0], colorFar[0]);
         float g = map(distances[N], 0, width/8, colorClose[1], colorFar[1]);
         float b = map(distances[N], 0, width/8, colorClose[2], colorFar[2]);
         
         pixels[index] = color(r,g,b);
      }
    }
    updatePixels();
  }
