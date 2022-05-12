
class Game{
  //Variables
  NeuralNetwork brain;
  PVector pos = new PVector();
  PVector Apos = new PVector();
  PVector Npos = new PVector();
  ArrayList<Integer> history = new ArrayList<Integer> ();
  ArrayList<float[]> historym = new ArrayList<float[]>();
  float Dist_x = 0;
  float Dist_y = 0;
  float fitness = 0; 
  int turn = 0;
  float Rect_Size = (Dist_x*.8)/4;
  float Spect_Size = (Dist_y*.2)/5;
  ArrayList <tile> tiles = new ArrayList<tile>();
  ArrayList <PVector> emptyPos = new ArrayList <PVector>();
  boolean loose = false;
  boolean Game_over = false;
  int Dim_g = 4;
  boolean tileMoved = false;
  boolean MovingTheTiles;
  int Score = 0;
  //Funciones
  //---------------------------------------------------------------------------------------//
    Game(float x, float y, float wd, float hg){
      brain = new NeuralNetwork(16,28,4);
      Dist_x = wd;
      Dist_y = hg;
      pos = new PVector(x,y);
      Apos = pos.copy();
      Npos = pos.copy();
      fillEmpty();
      addNewTile();
      addNewTile();
      Rect_Size = (Dist_x*.8)/4;
      Spect_Size = (Dist_y*.2)/5;
    }
    
    Game(float x, float y, float wd, float hg, NeuralNetwork b){
      brain = b.copy();
      Dist_x = wd;
      Dist_y = hg;
      pos = new PVector(x,y);
      Apos = pos.copy();
      Npos = pos.copy();
      fillEmpty();
      addNewTile();
      addNewTile();
      Rect_Size = (Dist_x*.8)/4;
      Spect_Size = (Dist_y*.2)/5;
    }
    //---------------------------------------------------------------------------------------//
    void fillEmpty(){
    
      for (int a = 0 ;a < Dim_g; a++){
        for (int b = 0; b < Dim_g; b++){
          emptyPos.add(new PVector(a,b));       
        }
      }
    
    }
    
    void setEmpty(){
      emptyPos.clear();
      for (int a = 0 ;a < Dim_g; a++){
        for (int b = 0; b < Dim_g; b++){
          if (getValue(b,a) == 0){ 
            emptyPos.add(new PVector(b,a));
          }
        }
      }
    
    }
    //---------------------------------------------------------------------------------------//

    //-----------------------------------------------------------------------------//

    //---------------------------------------------------------------------------------------//
    void move(int TypeMove){
      turn++;
      tileMoved = false;
      for (int a = 0; a<tiles.size();a++){
        tiles.get(a).AlreadyIncreased = false;
      }
      ArrayList<PVector> sortOrder = new ArrayList<PVector>();
      PVector moveDir = new PVector(0,0);
      
      if (TypeMove == 0){ //arriba
        moveDir = new PVector(0,-1);
      }
      if (TypeMove == 1){ //derecha
        moveDir = new PVector(1,0);
      }
      if (TypeMove == 2){ //abajo
        moveDir = new PVector(0,1);
      }
      if (TypeMove == 3){ //izquierda
        moveDir = new PVector(-1,0);
      }
      for (int a = 0; a<Dim_g; a++){
        for (int b = 0; b<Dim_g; b++){
          PVector temp = new PVector(0,0);
          if (TypeMove == 0){
            temp.x = b;
            temp.y = a;
          }
          if (TypeMove == 1){
            temp.x = Dim_g - 1 - a;
            temp.y = b;
            
          }
          if (TypeMove == 2){
            temp.x = b;
            temp.y = Dim_g - 1 - a;
          }
          if (TypeMove == 3){
            temp.x = a;
            temp.y = b;
          }
          sortOrder.add(temp);
        }
      }
      if(loose == true && tiles.size() == 16)Game_over = true;
      if(loose != true )loose = true; 
      for (int j = 0; j < sortOrder.size(); j++){
        for(int a = 0; a < tiles.size(); a++){
          if (tiles.get(a).pos.x == sortOrder.get(j).x && tiles.get(a).pos.y  == sortOrder.get(j).y) {
            tiles.get(a).order = j;
            PVector moveTo = new PVector(tiles.get(a).pos.x + moveDir.x, tiles.get(a).pos.y + moveDir.y);
            Apos = Npos.copy();
            Npos = moveTo.copy();
            int valueOfMoveTo = getValue(floor(moveTo.x),floor(moveTo.y));
            while(valueOfMoveTo == 0){
              loose = false;
              //tiles.get(a).pos = new PVector(moveTo.x,moveTo.y);
              
              tiles.get(a).moveTo(moveTo);
              moveTo = new PVector(tiles.get(a).pos.x + moveDir.x, tiles.get(a).pos.y + moveDir.y);
              valueOfMoveTo = getValue(floor(moveTo.x),floor(moveTo.y));
              tileMoved = true;
            }
            
            if (valueOfMoveTo == tiles.get(a).value){
                getTile(floor(moveTo.x),floor(moveTo.y)).value*=2;
                getTile(floor(moveTo.x),floor(moveTo.y)).setColor();
                float Addfit = getTile(floor(moveTo.x),floor(moveTo.y)).value;
                Score += sqrt(Addfit*(log(Addfit)/log(2))*pow(turn,3)*sqrt(turn)/100);
                PVector tempd = getTile(floor(moveTo.x),floor(moveTo.y)).pos;
                sortOrder.add(new PVector(tempd.x,tempd.y));
                tiles.remove(a);
            }
          }
        }
      }
      for (int j = 0; j < sortOrder.size(); j++){
        //println(sortOrder.get(j).x + sortOrder.get(j).y*Dim_g );
      }
      setEmpty();
      addNewTile();
      addNewTile();
    }
    //---------------------------------------------------------------------------------------//
    void Show(){
      fill(255);
      stroke(0);
      strokeWeight(2);
      rect(pos.x,pos.y,Dist_y,Dist_x);
      strokeWeight(1);
      for(int a = 0 ; a < Dim_g; a++){
        line(pos.x+a*(Dist_x/4),pos.y,pos.x+a*(Dist_x/4),pos.y+Dist_y);
        line(pos.x,pos.y+a*(Dist_y/4),pos.x+Dist_x,pos.y+a*(Dist_y/4));
      }
      noStroke();
      for(int a = 0; a<tiles.size(); a++){
            fill(tiles.get(a).colour);
            rect(pos.x + Spect_Size*(1+tiles.get(a).Ppos.x) + tiles.get(a).Ppos.x*Rect_Size,pos.y + Spect_Size*(1+tiles.get(a).Ppos.y) + tiles.get(a).Ppos.y*Rect_Size,Rect_Size,Rect_Size);
            fill(0);
            text(round(tiles.get(a).value),pos.x + Spect_Size*(1+tiles.get(a).Ppos.x) + (tiles.get(a).Ppos.x+.5)*Rect_Size,pos.y + Spect_Size*(1+tiles.get(a).Ppos.y) + (tiles.get(a).Ppos.y+.8)*Rect_Size-3);
            //text(tiles.get(a).order,pos.x + Spect_Size*(1+tiles.get(a).pos.x) + (tiles.get(a).pos.x+.5)*Rect_Size,pos.y + Spect_Size*(1+tiles.get(a).pos.y) + (tiles.get(a).pos.y+.8)*Rect_Size+3);
      }
      text(Score,pos.x+Dist_x/2,pos.y+Dist_y/2);
    }
    //---------------------------------------------------------------------------------------//
    void addNewTile(){
      if (emptyPos.size() != 0){
        PVector temp = emptyPos.remove(floor(random(emptyPos.size())));
        tiles.add(new tile(temp.x, temp.y));
      }
    }
    //---------------------------------------------------------------------------------------//
    void CalMove(){
      float Guess [];
      float Feed [] = new float [16];
      for (int a = 0; a<Dim_g; a++){
        for (int b = 0; b<Dim_g; b++){
          if (getValue(b,a) != 0)
            Feed[b+a*4] = sqrt(log(getValue(b,a))/(2*log(2)));
          else 
            Feed[b+a*4] = 0;
          //println(Feed[b+a*4]);
        }
      }
      Guess = brain.feedForward(Feed);
      history.add(may(Guess));
      historym.add(Feed);
      move(may(Guess));
    }
    //---------------------------------------------------------------------------------------//
    int getValue(int x, int y){
      if (x > 3 || x < 0 || y < 0 || y > 3)
      return -1;
      for(int a =0 ;a<tiles.size();a++){
        if (tiles.get(a).pos.x == x && tiles.get(a).pos.y == y)
          return tiles.get(a).value;
      }
      
      return 0;
    
    }
    tile getTile(int x, int y){
      if (x > 3 || x < 0 || y < 0 || y > 3)
      return new tile(0,0);
      for(int a =0 ;a<tiles.size();a++){
        if (tiles.get(a).pos.x == x && tiles.get(a).pos.y == y)
          return tiles.get(a);
      }
      
      return null;
    
    }
    //--------------------------------------------------------------------------------------//
    void moveDraw(){
      for(int a = 0; a<tiles.size();a++){
        PVector MoveDir = PVector.sub(tiles.get(a).pos,tiles.get(a).Ppos);
        MoveDir.normalize();
        MoveDir.mult(.5);
        tiles.get(a).Ppos.add(MoveDir);
      }

    }
    //--------------------------------------------------------------------------------------//
    void mutate(){
      brain.mutate(.15);
    }
}
