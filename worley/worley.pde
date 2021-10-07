Mover[] movers;
int POINTS_NO = 15;
int N = 0;
float z;

void setup()
{
  size(400, 400);
  movers = new Mover[POINTS_NO];
  for(int i = 0; i < POINTS_NO; i++)
  {
    movers[i] = new Mover();
  }
}

void draw()
{
  worley2d();
  //for(int i = 0; i < POINTS_NO; i++)
  //{
  //  movers[i].move();
  //}
}
