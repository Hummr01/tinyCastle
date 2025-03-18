class Projectile {
  float x, y, angle, speed = 5;
  int damage = 20;
  Player player;  // Reference to the player who fired the projectile
  boolean isTower = false; 

  // Modified constructor to accept a Player reference
  Projectile(float x, float y, float angle, Player player) {
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.player = player;  // Store reference to the player
  }
  
  Projectile(float x, float y, float angle, int damage){
    this.x = x;
    this.y = y; 
    this.angle = angle; 
    this.damage = damage; 
    this.isTower = true;
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

void update(Tower tower){
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
            tower.projectiles.remove(this);  // Remove the projectile from the player's list

            // If the enemy is destroyed, award resources and remove the enemy
            if (enemy.destroyed) {
                resources.add(new Resource(enemy.x, enemy.y, enemy.resources));
                enemies.remove(j);  // Remove the enemy from the list
            }
            break;  // Exit loop after first collision
        }
    }

    // Adjust out-of-bounds check considering projectile size
    float radius = 5;  // Half of the projectile's diameter (10px)
    if (x - radius < 0 || x + radius > width || y - radius < 0 || y + radius > height) {
        tower.projectiles.remove(this);  // Remove this projectile from the player's list
    }

}

}