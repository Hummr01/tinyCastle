class Player {
  float x, y;
  float speed = 3;
  int resources = 0;
  int playerDamage = 5; 
  ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  boolean up, down, left, right;

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
  
  void update() {
  move();

  // Update and display all projectiles in reverse order
  for (int i = projectiles.size() - 1; i >= 0; i--) {
    Projectile projectile = projectiles.get(i);
    projectile.update();  // Call the update for each projectile

    // If the projectile is out of bounds or destroyed, it will be removed in the update method
    if (projectile.x < 0 || projectile.x > width || projectile.y < 0 || projectile.y > height) {
      projectiles.remove(i);  // Safely remove the projectile from the list
    }
  }

  display();
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

  // When mouse is pressed, projectiles are created
  void mousePressed() {
    println("Pressed");
    if (currentState == GameState.GAME) {
      float angle = atan2(mouseY - y, mouseX - x);
      Projectile projectile = new Projectile(x, y, angle, this);  // Pass current player to projectile
      projectiles.add(projectile);  // Add to the player's projectiles list
    }
  }
}

class Projectile {
  float x, y, angle, speed = 5;
  int damage = 20;
  Player player;  // Reference to the player who fired the projectile

  // Modified constructor to accept a Player reference
  Projectile(float x, float y, float angle, Player player) {
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.player = player;  // Store reference to the player
  }

  void move() {
    x += cos(angle) * speed;
    y += sin(angle) * speed;
  }

  void display() {
    fill(255, 255, 0);
    ellipse(x, y, 10, 10);
  }

void update() {
    // Move the projectile based on its angle and speed
    move();

    // Display the projectile
    display();

    // Check for collisions with enemies
    for (int j = enemies.size() - 1; j >= 0; j--) {
        Enemy enemy = enemies.get(j);
        // Check if the projectile collides with an enemy
        if (dist(x, y, enemy.x, enemy.y) < 15) { // Collision check
            enemy.takeDamage(damage);  // Apply damage to the enemy
            player.projectiles.remove(this);  // Remove the projectile from the player's list

            // If the enemy is destroyed, award resources and remove the enemy
            if (enemy.destroyed) {
                player.addResources(enemy.resources);  // Award resources to the player
                enemies.remove(j);  // Remove the enemy from the list
            }
            break;  // Exit loop after first collision
        }
    }

    // Adjust out-of-bounds check considering projectile size
    float radius = 5;  // Half of the projectile's diameter (10px)
    if (x - radius < 0 || x + radius > width || y - radius < 0 || y + radius > height) {
        player.projectiles.remove(this);  // Remove this projectile from the player's list
    }
}

}





