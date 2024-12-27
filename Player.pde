class Player {
  float x, y;
  float speed = 3;

  Player(float x, float y) {
    this.x = x;
    this.y = y;
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
}

