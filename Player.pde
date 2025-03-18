class Player {
  float x, y;
  float speed = 3;
  int resources = 50;
  int playerDamage = 5; 
  ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  boolean up, down, left, right,place;

  Player(float x, float y) {
    this.x = x;
    this.y = y;
    up = false;
    down = false;
    left = false;
    right = false;
    place = false;
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
  placeBuilding();

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
    if ((key == 'e' || key == 'e') && !waveManager.waveInProgress) place = true;
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

  void removeResources(int resources){
    this.resources -= 50;
  }

  // When mouse is pressed, projectiles are created
  void mousePressed() {
        float angle = atan2(mouseY - y, mouseX - x);
        Projectile projectile = new Projectile(x, y, angle, this);  // Pass current player to projectile
        projectiles.add(projectile);  // Add to the player's projectiles list
    }
    
  void placeBuilding(){
    if(!waveManager.waveInProgress && this.resources >= 50 && place){
      towers.add(new Tower(x,y));
      removeResources(50);
      this.place = false;
    }
  }

  }







