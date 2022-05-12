class tile{
  
  PVector pos = new PVector();
  PVector Ppos = new PVector();
  int value = 2;
  int LogValue= 0;
  int order = 0;
  color colour;
  boolean AlreadyIncreased = false;
  boolean Death = false;
  boolean moving = false;
    tile(float x_, float y_){
      if (random(1)<0.1){
        value = 4;
      }else {
        value = 2;
      }
      Ppos = new PVector(x_,y_);
      pos = new PVector(x_,y_);
      setColor();
    }
    
    void moveTo(PVector move){
      pos = new PVector(move.x,move.y);
    }
    
    void setColor(){
    switch(value) {
      case 2:
        colour = color(238, 228, 218);
        break;
      case 4:
        colour = color(237, 224, 200);
        break;       
      case 8:
        colour = color(242, 177, 121);
        break;
      case 16:
        colour = color(2345, 149, 99);
        break;
      case 32:
        colour = color(246, 124, 95);
        break;
      case 64:
        colour = color(246, 94, 59);
        break;
      case 128:
        colour = color(237, 207, 114);
        break;
      case 256:
        colour = color(237,204,97);
        break;
      case 512:
        colour = color(237,200,80);
        break;
      case 1024:
        colour = color(237,197,63);
        break;
      case 2048:
        colour = color(237,197,1);
        break;
      case 4096:
        colour = color(94,218,146);
        break;
        
    }
    
    }
}
