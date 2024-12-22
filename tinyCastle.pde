int gameState = 0;
Game game; // Declare the Game object

void setup() {
    size(400, 400);
    textAlign(CENTER, CENTER); // Align text properly
    game = new Game(1); // Initialize the game object
}

void draw() {
    switch (gameState) {
        case 0:
            drawMenu();
            break;
        case 1:
            game.drawGame(); // Use the Game class's drawGame method
            break;
        case 2:
            drawEnd();
            break;
    }
}

// Check if the mouse is within a rectangle
boolean imRechteck(int px, int py, int rx, int ry, int rw, int rh) {
    return (px > rx && px < rx + rw && py > ry && py < ry + rh);
}

void mousePressed() {
    if (gameState == 0 && imRechteck(mouseX, mouseY, width / 2 - 100, height / 2 - 50, 200, 100)) {
        gameState = 1; // Start the game
    }
}

void drawMenu() {
    background(0);
    fill(255);
    textSize(32);
    text("Menu", width / 2, height / 2 - 200);

    // Button logic
    if (imRechteck(mouseX, mouseY, width / 2 - 100, height / 2 - 50, 200, 100)) {
        fill(255, 0, 0); // Highlight button when hovered
    } else {
        fill(255);
    }
    rect(width / 2 - 100, height / 2 - 50, 200, 100); // Draw button

    fill(0);
    textSize(24);
    text("Start", width / 2, height / 2); // Draw button text
}

void drawEnd() {
    background(150, 50, 50);
    fill(255);
    textSize(24);
    text("Game Over", width / 2, height / 2);
    // TODO:EndScreen logic
}
