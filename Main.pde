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

boolean imRechteck(int px, int py, int rx, int ry, int rw, int rh){
  return (px>rx && px < rx+rw && py > ry && py < ry +rh);
}

void drawMenu(){
    background(0);
    fill(255);
    text("Menu", width/2, height/2-200);
    fill(255,0,0);
    if(imRechteck(mouseX, mouseY, width/2-100, height/2-50, 200,100)){
        fill(255,0,0);
    } else {
        fill(255);
    }
    rect(width/2-100, height/2-50,200,100);
    fill(0);
    text("Start",width/2,height/2);
}

void drawGame(){
    //TODO
}

void drawEnd(){
    //TODO
}
