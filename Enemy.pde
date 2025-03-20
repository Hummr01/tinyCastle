class Enemy{
    float x,y;
    int level = 0;
    int health = 20;
    int damage = 1;
    float speed; 
    int size = 10;
    boolean destroyed = false;
    int resources; 
    color c = color(255, 0, 0);
    

    Enemy(int level) {
        this.x = x;
        this.y = y;
        switch (level) 
        {
        case 1:
            this.health = 30; 
            this.damage = 8; 
            this.speed = 1.5; 
            this.size = 25;
            this.resources = (int) random(3,9);
            this.c = color(255, 0, 255);
            break;
        case 2:
            this.health = 40;
            this.damage = 15;
            this.speed = 1.9;
            this.size = 30; 
            this.resources = (int) random(8, 13);
            this.c = color(0);
            break;
            
        default:
            this.resources = (int)random(1, 5);
            this.speed = 1; 
            break;
        }
        int edge = int(random(4)); // 0: top, 1: bottom, 2: left, 3: right

        switch (edge) {
            case 0: // Top edge
                x = random(width);
                y -= this.size;
                break;
            case 1: // Bottom edge
                x = random(width);
                y = height + this.size; 
                break;
            case 2: // Left edge
                x -= this.size; 
                y = random(height);
                break;
            case 3: // Right edge
                x = width + this.size; 
                y = random(height);
                break;
        }
        x += random(-20,20);
        y += random(-20,20);
    }

    void move(){
        //Move Enemy towards base 
        float dx = width / 2 - x;
        float dy = height / 2 - y;
        float distance = sqrt(dx * dx + dy * dy);

        if (distance != 0) {
            x += (dx / distance) * speed;
            y += (dy / distance) * speed;
        }
    }

    void display(){
        fill(c);
        ellipse(this.x, this.y, this.size, this.size);
    }
    
    void takeDamage(int damage){
        this.health -= damage;
        if(this.health <= 0){
            this.destroyed = true;
        }
        
    }

}