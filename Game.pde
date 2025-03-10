// Global variables
Player player;
Base base;
private GameState currentState = GameState.MENU;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

int waveTimer = 0;
int waveNumber = 1;
int enemiesInWave = 5;
int enemiesSpawnedInWave = 0;
int waveInterval = 300;
int spawnInterval = 30;
boolean waveInProgress = false;
int waveDuration = 30 * 60; // 30 seconds * 60 frames
int initialDelay = 10 * 60; // 10 seconds * 60 frames
int waveStartTime = frameCount - initialDelay; // Correct initialization
// Wave setup

enum GameState {
  MENU, GAME, END
}

void startWave() {
    waveNumber++;
    enemiesInWave = waveNumber * 3 + 2;
    enemiesSpawnedInWave = 0;
    waveTimer = 0;
    waveInProgress = true;
    spawnInterval = 30;
    waveStartTime = frameCount;
}

void endWave() {
    waveInProgress = false;
    waveTimer = 0;
    spawnInterval = 30;
}

void setup() {
  size(800, 800);
  player = new Player(width / 2, height / 2 + 80);
  base = new Base(3);
  
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
  background(255);
  player.displayResources(width, height);
  player.move();
  player.display();
  base.drawBase();

  // Projectile movement and display
  for (int i = projectiles.size() - 1; i >= 0; i--) {
    Projectile projectile = projectiles.get(i);
    projectile.move();
    projectile.display();

    // Projectile collision with enemies
    for (int j = enemies.size() - 1; j >= 0; j--) {
      Enemy enemy = enemies.get(j);
      if (dist(projectile.x, projectile.y, enemy.x, enemy.y) < 15) { // Collision check
        enemy.takeDamage(projectile.damage);
        projectiles.remove(i);
        if(enemy.destroyed){
          player.addResources(enemy.resources);
          enemies.remove(j);
        }
        break;
      }
    }
    if (projectile.x < 0 || projectile.x > width || projectile.y < 0 || projectile.y > height){
      projectiles.remove(i);
    }
  }
   // Wave management
    if (!waveInProgress) {
        if (frameCount - waveStartTime >= initialDelay && waveNumber == 1) {
            startWave();
        } else if (frameCount - waveStartTime >= (waveNumber-1) * waveDuration + initialDelay) {
            startWave();
        }
    } else {
        waveTimer++;
        if (waveTimer >= spawnInterval && enemiesSpawnedInWave < enemiesInWave) {
            spawnEnemy();
            enemiesSpawnedInWave++;
            waveTimer = 0;
        }

        if (frameCount - waveStartTime >= waveNumber * waveDuration + initialDelay || (enemiesSpawnedInWave >= enemiesInWave && enemies.size() == 0)) { //wave ends after time or enemies are destroyed.
            endWave();
        }
    }
    processEnemies();
    displayWaveTimer();
    
}

void displayWaveTimer() {
    fill(0);
    textSize(20);
    textAlign(RIGHT, TOP);

    if (!waveInProgress) {
        int remainingFrames = (waveStartTime + initialDelay) - frameCount;
        if(waveNumber > 1){
            remainingFrames = (waveStartTime + waveDuration + initialDelay) - frameCount;
        }
        int remainingSeconds = remainingFrames / 60;
        if(remainingSeconds < 0 ){
            remainingSeconds = 0;
        }
        text("Next Wave: " + remainingSeconds + "s", width - 10, 10);
    } else {
        int remainingFrames = (waveStartTime + waveDuration) - frameCount;
        int remainingSeconds = remainingFrames / 60;
        if(remainingSeconds < 0){
            remainingSeconds = 0;
        }
        text("Wave " + waveNumber + " - " + remainingSeconds + "s", width - 10, 10);
    }
}

void spawnEnemy() {
    int enemyLevel = 0; // Default level

    // Determine enemy level based on your game logic (e.g., wave number)
    if (waveNumber > 5) {
        enemyLevel = 1; // Level 1 enemies after wave 5
    }

    enemies.add(new Enemy(enemyLevel)); // Create and add a new enemy
}

void processEnemies() {
    // Move and display all enemies
    for (int i = enemies.size() - 1; i >= 0; i--) {
        Enemy enemy = enemies.get(i);
        enemy.move();
        enemy.display();

        // Enemies Hit Base
        if (dist(enemy.x, enemy.y, width / 2, height / 2) < enemy.size / 2) {
            base.takeDamage(enemy.damage);
            if (base.destroyed) {
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