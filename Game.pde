// Global variables
Player player;
Base base;
private GameState currentState = GameState.MENU;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

enum GameState {
  MENU, GAME, END
}

void setup() {
  size(800, 800);
  player = new Player(width / 2, height / 2 + 80);
  base = new Base(3);
  // Create some initial enemies
  for (int i = 1; i < 5; i++) {
    float randomX = random(width);
    float randomY = random(height);
    enemies.add(new Enemy(0, randomX, randomY));
  }
}

void draw() {
  switch (currentState) {
    case MENU:
      drawMenu();
      break;
    case GAME:
      drawGame();
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

  if (mouseX > buttonX && mouseX < buttonX + buttonWidth &&
      mouseY > buttonY && mouseY < buttonY + buttonHeight) {
    fill(255, 0, 0);
    rect(buttonX, buttonY, buttonWidth, buttonHeight, 10);

    // Button Text
    fill(255);
    textSize(24);
    textAlign(CENTER, CENTER);
    text("Start Game", buttonX + buttonWidth / 2, buttonY + buttonHeight / 2);
  }
  // Check if the button is clicked
  if (mousePressed &&
      mouseX > buttonX && mouseX < buttonX + buttonWidth &&
      mouseY > buttonY && mouseY < buttonY + buttonHeight) {
    currentState = GameState.GAME;
  }
}

private void drawEnd() {
  // Draw Game Title
  fill(0);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("Game Over", width / 2, height / 4);
  
}

private void drawGame() {
  background(200);
  player.move();
  player.display();
  base.drawBase();
   // Move and display enemies
  for (int i = enemies.size() - 1; i >= 0; i--) { //Iterate backwards to safely remove enemies
    Enemy enemy = enemies.get(i);
    enemy.move();
    enemy.display();

    // Enemies Hit Base 
      if (dist(enemy.x, enemy.y, width / 2, height / 2) < enemy.size/2) {
      base.takeDamage(enemy.damage);
        if(base.destroyed){
          currentState = GameState.END; 
      }
    }
}
}

void keyPressed() {
  player.keyPressed(); // Call the player's keyPressed method
}

void keyReleased() {
  player.keyReleased(); // Call the player's keyReleased method
}