class Resource {
float x, y;

  Resource(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    fill(0, 255, 0);
    ellipse(x, y, 10, 10);
  }
}

class Enemy {
  float x, y;
  float speed = 1;

  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void move() {
    // Move toward the base
  }

  void display() {
    fill(255, 0, 0);
    ellipse(x, y, 15, 15);
  }

}
