class Tower {
    float x, y;
    float range;
    int damage;
    int fireRate; // Frames between shots
    int lastFireTime;
    int level;
    ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

    Tower(float x, float y) {
        this.x = x;
        this.y = y;
        this.range = 150;
        this.damage = 20;
        this.fireRate = 60; // 1 shot per second
        this.lastFireTime = 0;
        this.level = 1;
    }

    void display() {
        fill(100);
        ellipse(x, y, 30, 30);
        noFill();
        stroke(255, 0, 0, 50); // Visual range indicator
        ellipse(x, y, range * 2, range * 2);
        stroke(0);
    }

    void update(ArrayList<Enemy> enemies) {
        // Find the closest enemy within range
        Enemy target = findTarget(enemies);

        if (target != null && frameCount - lastFireTime >= fireRate) {
            fire(target);
            lastFireTime = frameCount;
        }
         // Update and display all projectiles in reverse order
        for (int i = projectiles.size() - 1; i >= 0; i--) {
            Projectile projectile = projectiles.get(i);
            projectile.update(this);

            // If the projectile is out of bounds or destroyed, it will be removed in the update method
            if (projectile.x < 0 || projectile.x > width || projectile.y < 0 || projectile.y > height) {
                projectiles.remove(i);  // Safely remove the projectile from the list
            }
        }
    }

    Enemy findTarget(ArrayList<Enemy> enemies) {
        Enemy closestEnemy = null;
        float closestDistance = Float.MAX_VALUE;

        for (Enemy enemy : enemies) {
            float distance = dist(x, y, enemy.x, enemy.y);
            if (distance <= range && distance < closestDistance) {
                closestEnemy = enemy;
                closestDistance = distance;
            }
        }
        return closestEnemy;
    }

    void fire(Enemy target) {
        float angle = atan2(target.y - y, target.x - x);
        this.projectiles.add(new Projectile(x, y, angle,this.damage)); 
    }

    void upgrade() {
        level++;
        range *= 1.2;
        damage += 10;
        fireRate = max(10, fireRate - 5); // Increase fire rate
    }
}