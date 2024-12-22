int gameState = 0;

void setup() {
    size(400, 400);
}   

void draw(){
  switch(gameState){
  case 0:
    drawMenu();
    break;
  case 1:
    drawGame();
    break;
  case 2:
    drawEnd();
    break;
  }
}

void drawMenu(){
    //TODO
}

void drawGame(){
    //TODO
}

void drawEnd(){
    //TODO
}
