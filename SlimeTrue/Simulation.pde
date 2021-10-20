abstract class Simulation
{
  AgentCollection[] ac;
  int evDir;
}

class Simulation1 extends Simulation
{
  Simulation1()
  {
    ac = new AgentCollection[1];
    ac[0] = new AgentCollection(AG_NUM, 255, 255, 255, 'r', 'r');
    
    makeTrail();
  }
}

class Simulation2 extends Simulation
{
  Simulation2()
  {
    ac = new AgentCollection[5];
    ac[0] = new AgentCollection(AG_NUM, 69, 185, 148, 'c', 'r');
    ac[1] = new AgentCollection(AG_NUM, 116, 223, 184, 'r', 'c');
    ac[2] = new AgentCollection(AG_NUM, 17, 72, 51, 'c', 'r');
    ac[3] = new AgentCollection(AG_NUM, 38, 131, 92, 'r', 'c');
    ac[4] = new AgentCollection(AG_NUM, 8, 92, 60, 'c', 'r');

  }
}
