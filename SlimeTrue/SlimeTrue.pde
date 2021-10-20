import processing.pdf.*;

int AG_NUM = 200;
int rB_COL, gB_COL, bB_COL;
int COL = 0;
float EV_DIV = 250;
float EV = (COL-rB_COL)/EV_DIV;
float DIFF = 0.75;

Simulation sim;

void setup()
{
  size(600, 600, P2D);

  rB_COL = 116;
  gB_COL = 223;
  bB_COL = 184;
  background(rB_COL, gB_COL, bB_COL);

  sim = new Simulation1();
}

void draw()
{

  loadPixels();

  for (int i=0; i<10; i++)
  {
    for (var ac : sim.ac)
    {
      ac.move();
    }

    for (var ac : sim.ac)
    {
      ac.turn();
    }

    for (var ac : sim.ac)
    {
      ac.diffuseAndEvaporate();
    }
  }
  updatePixels();
}

void mousePressed()
{
  saveFrame("./img.tif");
}
