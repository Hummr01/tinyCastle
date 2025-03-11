WaveManager waveManager;
ArrayList<Enemy> enemies;
Player player;
Base base;
enum GameState { MENU, GAME, END };
GameState currentState = currentState = GameState.MENU;


void setup() {
    size(800, 600);
    player = new Player(width/2, height/2+40);
    base = new Base(1);
    waveManager = new WaveManager();
    enemies = new ArrayList<>();
}

void draw() {
    background(255);
    update(currentState);
 
}

void displayWaveTimer() {
    fill(0);
    textSize(20);
    textAlign(RIGHT, TOP);
    int remainingSeconds = waveManager.getRemainingTime();
    text(waveManager.getWaveStatus() + " " + remainingSeconds + "s", width - 10, 10);
}

void processEnemies() {
    for (int i = enemies.size() - 1; i >= 0; i--) {
        Enemy enemy = enemies.get(i);
        enemy.move();
        enemy.display();
        
        if (dist(enemy.x, enemy.y, width / 2, height / 2) < enemy.size / 2) {
            base.takeDamage(enemy.damage);
            if (base.destroyed) {
                currentState = GameState.END;
            }
        }
    }
}

void update(GameState currentState) {
   switch (currentState) {
    case MENU:
      drawMenu();
      break;
    case GAME:
      player.update();
      base.update();
      waveManager.update();
      processEnemies();
      displayResources();
      displayWaveTimer();
      break;
    case END:
      drawEnd();
      break;
  }
}

private void displayResources(){
  fill(0);
  textAlign(RIGHT, BOTTOM);
  text("Ressources: " + player.resources, width-10, height-10);
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
  text("Reached Wave: " + waveManager.getWaveNumber(), width/2, height- height/4);
  
}
void keyPressed() {
    player.keyPressed();
}

void keyReleased() {
    player.keyReleased();
}

void mousePressed(){
  player.mousePressed();
}
