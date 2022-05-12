int may(float guess[]){
  float answer = 0;
  int pos = 0;
  for(int a = 0;a<guess.length;a++){
    if(guess[a] > answer){
      answer = guess[a];
      pos = a;
    }
  }
  return pos;
}

float [] one_hot_vector (int value, int vector_size){
  float []one_hot = new float [vector_size];
  
  for (int a = 0; a<vector_size; a++){
    if (a == value) one_hot[a] = 1;
    else one_hot[a] = 0;
  }
  return one_hot;
}
