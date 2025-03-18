WaveManager waveManager;
ArrayList<Enemy> enemies;
ArrayList<Tower> towers;
ArrayList<Resource> resources; 
Player player;
Base base;
enum GameState { MENU, GAME, END };
GameState currentState = currentState = GameState.MENU;
boolean mouseIsPressed = false;



void setup() {
    size(800, 600);
    player = new Player(width/2, height/2+40);
    base = new Base(1);
    waveManager = new WaveManager();
    enemies = new ArrayList<>();
    towers = new ArrayList<Tower>();
    resources = new ArrayList<Resource>();
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
      drawEnd();
      break;
    case GAME:
      player.update();
      base.update();
      waveManager.update();
      displayTowers();
      processEnemies();
      displayResources();
      displayWaveTimer();
      drawDropedResources();
      break;
    case END:
      drawEnd();
      break;
  }
}

private void displayTowers(){
  for (int i = towers.size()-1; i >= 0; i--) {
    Tower tower = towers.get(i);
    tower.display();
    tower.update(enemies);
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
  rectMode(CORNER);
  // Draw Game Title
  fill(0);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("Game Over", width / 2, height / 4);
  text("Reached Wave: " + waveManager.getWaveNumber(), width/2, height- height/4);

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
  text("Start New Game", buttonX + buttonWidth / 2, buttonY + buttonHeight / 2);

  if (mouseX > buttonX && mouseX < buttonX + buttonWidth &&
      mouseY > buttonY && mouseY < buttonY + buttonHeight) {
    fill(255, 0, 0);
    rect(buttonX, buttonY, buttonWidth, buttonHeight, 10);

    // Button Text
    fill(255);
    textSize(24);
    textAlign(CENTER, CENTER);
    text("Start New Game", buttonX + buttonWidth / 2, buttonY + buttonHeight / 2);
  }
  // Check if the button is clicked
  if (mousePressed &&
      mouseX > buttonX && mouseX < buttonX + buttonWidth &&
      mouseY > buttonY && mouseY < buttonY + buttonHeight) {
    restartGame();
    currentState = GameState.GAME;
  }
}

void drawDropedResources(){ 
  for (int i = resources.size() - 1; i >= 0; i--) {
        Resource resource = resources.get(i);
        resource.update();
        if (resource.value == 0) {
            resources.remove(i);
        }
    }
}

void keyPressed() {
    player.keyPressed();
}

void keyReleased() {
    player.keyReleased();
}

void mousePressed(){
  mouseIsPressed = true;
 
}

void mouseReleased() {
   if(currentState == GameState.GAME) {
    if (!waveManager.waveInProgress) {
      if(mouseIsPressed){
            // Check for tower clicks (upgrades)
            for (Tower tower : towers) {
                if (dist(mouseX, mouseY, tower.x, tower.y) < tower.size && player.resources >= 50) { // Example cost
                    tower.upgrade();
                    player.resources -= 30;
                    break; 
                }
            }
      }

    } else{
        player.mousePressed();
    }  
  }
  mouseIsPressed = false;
}

void restartGame(){
    player = new Player(width/2, height/2+40);
    base = new Base(1);
    waveManager = new WaveManager();
    enemies = new ArrayList<>();
    towers = new ArrayList<Tower>();
    resources = new ArrayList<Resource>();
}