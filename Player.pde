class Player {
  float x, y;
  float speed = 3;
  int resources = 0;
  int playerDamage = 5; 

  boolean up, down, left, right; // Declare these variables

  Player(float x, float y) {
    this.x = x;
    this.y = y;
    up = false;
    down = false;
    left = false;
    right = false;
  }

  void move() {
    if (up) y -= speed;
    if (down) y += speed;
    if (left) x -= speed;
    if (right) x += speed;

    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }

  void display() {
    fill(0, 0, 255);
    ellipse(x, y, 20, 20);
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

  void displayResources(int x, int y){
    fill(0);
    text("Coins: " + this.resources, x-x*0.1, y-y*0.05);
  }

  void addResources(int resources){
    this.resources += resources;
  }
}

ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

class Projectile {
  float x, y, angle, speed = 5;
  int damage = 20;

  Projectile(float x, float y, float angle) {
    this.x = x;
    this.y = y;
    this.angle = angle;
  }

  void move() {
    x += cos(angle) * speed;
    y += sin(angle) * speed;
  }

  void display() {
    fill(255, 255, 0);
    ellipse(x, y, 10, 10);
  }
}

void mousePressed() {
  if (currentState == GameState.GAME) {
    float angle = atan2(mouseY - player.y, mouseX - player.x);
    projectiles.add(new Projectile(player.x, player.y, angle));
  }
}