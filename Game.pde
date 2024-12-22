class Game {

  private int level; // The current level
  private float rectX, rectY, rectWidth, rectHeight; // Rectangle properties

  Game(int level) {
    this.level = level;
    rectX = width / 2;
    rectY = height / 2;
    rectWidth = 100;
    rectHeight = 100;
  }

  public void drawGame() {
    background(50, 150, 50); // Game background
    fill(255);
    textSize(24);
    text("Game is running! Level: " + level, width / 2, height / 2 - 150);

    // Draw a rectangle as part of the game
    rectMode(CENTER);
    fill(255, 0, 0);
    rect(rectX, rectY, rectWidth, rectHeight);

    // Placeholder for more game logic
  }

  private int getLevel(){
    return this.level;
  }

  public void nextLevel(){
    this.level++;
  }

  // Add other game logic methods if needed
}
