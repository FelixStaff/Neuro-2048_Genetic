ArrayList<Game> players = new ArrayList<Game>();
ArrayList<Game> saved = new ArrayList<Game>();
float []BestN;
Game p;
int Gen = 0;
int MaxScore = 0;
int Cant_Map = 49;
int Bord = ceil(sqrt(Cant_Map));
int Lado = 0;
StopWatchTimer Pausa = new StopWatchTimer();
void setup(){
  size(800,800);
  textAlign(CENTER);
  Lado = width/Bord;
  p = new Game(30,30,100,100);
  for (int a = 0; a < Cant_Map; a++){
    players.add(new Game(a%Bord*Lado,a/Bord*Lado,Lado,Lado));
  }
  Pausa.start();
}


void draw(){
  background(120);
  
  if (Pausa.getElapsedTime() > 100){
    for (int a = 0; a < players.size(); a++){
      Pausa.start();
      players.get(a).CalMove();
    }
  }
  for (int a = players.size()-1; a >= 0; a--){
    players.get(a).moveDraw();
    players.get(a).Show();
    if (players.get(a).Game_over == true){
      MaxScore = max(MaxScore,players.get(a).Score);
      saved.add(players.get(a));
      Game tem = players.remove(a);
      /*for (int h = 0; h < tem.history.size(); h++){
        println("move:",tem.history.get(h));
      }*/
    }
  }
  if (players.size() == 0){
    println(MaxScore);
    NextGeneration();
  }

  //p.moveDraw();
  //p.Show();
  //p.pos = new PVector(mouseX,mouseY);
}

/*void keyPressed(){
  if(key == CODED){
      if(keyCode == UP){
          print("up\n");
          for (int a = 0; a < Cant_Map; a++){
            players.get(a).move(0);
          }
          p.move(0);
          
      }
      if(keyCode == DOWN){
          print("down\n");
          for (int a = 0; a < Cant_Map; a++){
            players.get(a).move(2);
          }  
          p.move(2);
      }
      if(keyCode == LEFT){
          for (int a = 0; a < Cant_Map; a++){
            players.get(a).move(3);
          }
          p.move(3);
      }
      if(keyCode == RIGHT){
        for (int a = 0; a < Cant_Map; a++){
            players.get(a).move(1);
          }
        p.move(1);
      }
  }
}*/
