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


