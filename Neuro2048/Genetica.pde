void NextGeneration(){
    MaxScore = 0;
    Gen++;
    calculateFitness();
    sort(BestN);
    println("Entrenando...");
    for (int a = 0 ; a < 5 ; a++){
      for(Game g : saved){
        for(Game p : saved){
          if (p.Score == BestN[Cant_Map - a - 1]){
            p.brain.LearningRate = abs(p.brain.LearningRate)/2;
            print("E-/");
            for (int b = 0; b < p.history.size(); b++ ){
              p.brain.train(p.historym.get(b),one_hot_vector(p.history.get(b),4));
            }
            p.brain.LearningRate = -abs(p.brain.LearningRate)*2;
            for (int h = 0 ; h < 5 ; h++){
              if (g.Score == BestN[h]){
                print("C-/");
                for (int t = 0; t < g.history.size(); t++ ){
                  
                  p.brain.train(g.historym.get(t),one_hot_vector(g.history.get(t),4));
                }
              }
            }
          }
        }
      }
      println(a,":",BestN[Cant_Map - a - 1]); 
    }

    for(int a =0 ; a < Cant_Map ;a ++){
      players.add(pickOne());
    }
    saved.clear();
}


Game pickOne(){
    int index = 0; 
    float r  = random(1);
    while(r > 0){
      if (saved.get(index).Score >= BestN[saved.size() - 5 - 1]){
        r -= saved.get(index).fitness;
        //println("entra",saved.get(index).Score);
      }
      index++;
    }
    index--;
    Game a = saved.get(index);
    Game child = new Game(players.size()%Bord*Lado,players.size()/Bord*Lado,Lado,Lado,a.brain);
    child.mutate();
    return child;
}


void calculateFitness(){
  BestN = new float[Cant_Map];
  float sum = 0;
  int count_ = 0;
  for(Game ve : saved){
    BestN[count_++] = ve.Score;
  }
  sort(BestN);
  for(Game ve : saved){
    if (ve.Score >= BestN[saved.size() - 1 - 5])
    sum += ve.Score;
  }

  println("Promedio:",sum/saved.size());
  for(Game ve : saved){
    ve.fitness = ve.Score/sum;
    //println(ve.fitness);
  }
}
