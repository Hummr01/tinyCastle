// Global variables
Player player;
Base base;
boolean up, down, left, right;

void setup() {
  size(800, 800);
  player = new Player(width/2, height/2);
  base = new Base();
}

void draw() {
  background(200);
  player.move();
  player.display();
  base.drawBase(width/2, height/2, 100);
}

void keyPressed() {
  if (key == 'w' || key == 'W') up = true;
  if (key == 's' || key == 'S') down = true;
  if (key == 'a' || key == 'A') left = true;
  if (key == 'd' || key == 'D') right = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') up = false;
  if (key == 's' || key == 'S') down = false;
  if (key == 'a' || key == 'A') left = false;
  if (key == 'd' || key == 'D') right = false;
}
