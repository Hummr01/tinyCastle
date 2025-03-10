class Enemy{
    float x,y;
    int level = 0;
    int health = 20;
    int damage = 1;
    float speed; 
    int size = 10;

    Enemy(int level, float x, float y) {
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
            this.speed = 1; 
            break;
        }
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
}