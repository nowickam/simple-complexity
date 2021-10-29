int AG_NUM = 25000;
int rB_COL, gB_COL, bB_COL;
int COL = 0;
float EV_DIV = 250;
float EV = (COL-rB_COL)/EV_DIV;
float DIFF = 0.1;

Simulation sim;

boolean first;
int time;

void setup()
{
  size(7016,9933,P2D);

  rB_COL = 255;
  gB_COL = 255;
  bB_COL = 255;
  background(rB_COL, gB_COL, bB_COL);
  
  first = true;
  // sim = new Simulation1();
  time = 0;
  
  loadPixels();
  
  while(true)
  {
    if(first || time > 20)
  {
     sim = new Simulation1(true);
     first = false;
     time = 0;
  }
  
  for(int t = 0; t <20; t++)
  {
    
  for (int i=0; i<1; i++)
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
  
  time++;
  saveImg(1);
  println(time);
  }
}

void draw()
{
  if(first || time > 20)
  {
     sim = new Simulation1(true);
     first = false;
     time = 0;
     saveImg(1);
  }
  
  for(int t = 0; t <200; t++)
  {
    
  for (int i=0; i<1; i++)
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
  
  time++;
  saveImg(1);
  println(time);
}

void saveImg(int n)
{
  save("./out2/slime"+hour()+""+minute()+""+second()+n+".tif");
}

void mousePressed()
{
  saveFrame("./img.tif");
}
