abstract class Simulation
{
  AgentCollection[] ac;
  int evDir;
  color[] background;
}

class Simulation1 extends Simulation
{
  Simulation1(boolean makeTrail)
  {
    background = new color[(height-1)*width+width];
    if(makeTrail)
    {       
       background = makeTrail();
    }
    else
    {
      color bColor = color(rB_COL, gB_COL, bB_COL);
      Arrays.fill(background, bColor);
    }
    
    ac = new AgentCollection[2];
    ac[0] = new AgentCollection(AG_NUM,0, 94, 52, 'r', 'r', background);
    ac[1] = new AgentCollection(AG_NUM,255, 255, 255, 'r', 'r', background);

  }
}

class Simulation2 extends Simulation
{
  Simulation2(boolean makeTrail)
  {
    ac = new AgentCollection[5];
    ac[0] = new AgentCollection(AG_NUM, 69, 185, 148, 'c', 'r', background);
    ac[1] = new AgentCollection(AG_NUM, 116, 223, 184, 'r', 'c', background);
    ac[2] = new AgentCollection(AG_NUM, 17, 72, 51, 'c', 'r', background);
    ac[3] = new AgentCollection(AG_NUM, 38, 131, 92, 'r', 'c', background);
    ac[4] = new AgentCollection(AG_NUM, 8, 92, 60, 'c', 'r', background);

  }
}
