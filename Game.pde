// Global variables
Player player;
Base base;
boolean up, down, left, right;
private GameState currentState = GameState.MENU;

enum GameState{
  MENU, GAME, END
}

void setup() {
  size(800, 800);
  player = new Player(width/2, height/2);
  base = new Base();
}

void draw() {
  switch (currentState) {
    case MENU :
      drawMenu();
      break;
    case GAME:
      
      break;
    case END:
      drawEnd();
      break;
  }
  
}

private void drawMenu() {
  // Draw Game Title
  fill(0);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("My Game Title", width / 2, height / 4);

  // Draw Button
  float buttonX = width / 2 - 100;
  float buttonY = height / 2;
  float buttonWidth = 200;
  float buttonHeight = 50;

  // Button Background
  fill(100, 150, 200);
  rect(buttonX, buttonY, buttonWidth, buttonHeight, 10);

  // Button Text
  fill(255);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Start Game", buttonX + buttonWidth / 2, buttonY + buttonHeight / 2);

  // Check if the button is clicked
  if (mousePressed && 
      mouseX > buttonX && mouseX < buttonX + buttonWidth && 
      mouseY > buttonY && mouseY < buttonY + buttonHeight) {
    currentState = GameState.GAME;
  }
}

private void drawEnd(){
  // Draw Game Title
  fill(0);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("My Game Title", width / 2, height / 4);

  // Draw Button
  float buttonX = width / 2 - 100;
  float buttonY = height / 2;
  float buttonWidth = 200;
  float buttonHeight = 50;

  // Button Background
  fill(100, 150, 200);
  rect(buttonX, buttonY, buttonWidth, buttonHeight, 10);

  // Button Text
  fill(255);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("End Game", buttonX + buttonWidth / 2, buttonY + buttonHeight / 2);

  // Check if the button is clicked
  if (mousePressed && 
      mouseX > buttonX && mouseX < buttonX + buttonWidth && 
      mouseY > buttonY && mouseY < buttonY + buttonHeight) {
    currentState = GameState.GAME;
  }
}

private void drawGame(){
  background(200);
  player.move();
  player.display();
  base.drawBase(width/2, height/2, 100);

}



