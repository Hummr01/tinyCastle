class Base{
    int currentHealth = 100;
    int maxHealth = 100;
    int level = 0; 
    boolean destroyed = false;

    Base(int level){
        this.level = level;
        if(level == 1){
            this.maxHealth = 100;
        }if(level == 2){
            this.maxHealth = 150;
            heal();
        }if(level == 3){
            this.maxHealth = 250;
            heal();
        }
    }
    void drawBase() {
        fill(0);
        rectMode(CENTER);
        rect(width /2 , height/2, 40, 40);
        displayHealthBar(this.currentHealth, this.maxHealth, width/2, height/2-40);
        }
    

   void displayHealthBar(int currentHealth, int maxHealth, int x, int y, int barWidth, int barHeight, color fillColor, color emptyColor) {
        if (maxHealth <= 0) {
            println("Max health must be greater than 0.");
            return;
        }

        if (currentHealth < 0) {
            currentHealth = 0;
        }

        if (currentHealth > maxHealth) {
            currentHealth = maxHealth;
        }

        int fillWidth = (int) (barWidth * ((float) currentHealth / maxHealth));

        // Draw the empty part of the bar
        fill(emptyColor);
        rect(x, y, barWidth, barHeight);

        // Draw the filled part of the bar
        fill(fillColor);
        rect(x, y, fillWidth, barHeight);

        // Optional: Draw a border
        stroke(0); // Black border
        noFill();
        rect(x, y, barWidth, barHeight);
}

void displayHealthBar(int currentHealth, int maxHealth, int x, int y){
  displayHealthBar(currentHealth, maxHealth, x, y, 40, 10, color(0, 255, 0), color(255, 0, 0)); // default green and red bar.
}

void heal(){
    this.currentHealth = this.maxHealth;
}

void heal(int healAmount){
    if(this.currentHealth+healAmount > this.maxHealth){
        this.currentHealth = this.maxHealth;
    } else{
        this.currentHealth += healAmount;
    }
}

void takeDamage(int damage){
    this.currentHealth -= damage;
    if(this.currentHealth <= 0 ){
        this.destroyed = true;
    }
}

void update(){
    drawBase();
}
}