void worley3d()
{
  loadPixels();
  for(int y = 0; y < height; y++)
  {
     for(int x = 0; x < width; x++)
     {
       int index = y * width + x;
       float[] distances = new float[POINTS_NO];
       for(int i = 0; i < POINTS_NO; i++)
       {
         Mover m = movers[i];
         float d = dist(x, y, z, m.location.x, m.location.y, m.location.z);
         distances[i] = d;
       }
       
       distances = sort(distances);
       float[] colorFar = new float[]{35, 25, 66};
       float[] colorClose = new float[]{153, 141, 200};
       float r = map(distances[N], 0, width/4, colorClose[0], colorFar[0]);
       float g = map(distances[N], 0, width/4, colorClose[1], colorFar[1]);
       float b = map(distances[N], 0, width/4, colorClose[2], colorFar[2]);
       
       pixels[index] = color(r, g, b);
     }
  }
  
  updatePixels();
  
  z++;
  z %= height;
}
