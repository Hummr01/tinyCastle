class Enemy{
    float x,y;
    int level = 0;
    int health = 20;
    int damage = 1;
    float speed; 
    int size = 10;
    boolean destroyed = false;
    int resources; 
    

    Enemy(int level) {
        this.x = x;
        this.y = y;
        switch (level) 
        {
        case 1:
            this.health = 40; 
            this.damage = 20; 
            this.speed = 1.5; 
            int size = 15;
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
        fill(255,0,0);
        ellipse(this.x, this.y, this.size, this.size);
    }
    
    void takeDamage(int damage){
        this.health -= damage;
        if(this.health <= 0){
            this.destroyed = true;
        }
        
    }

}