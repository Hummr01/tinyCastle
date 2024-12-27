class Base{
    int health = 100;


    void drawBase(float x, float y, float size) {
        // Draw the outer boundary (optional)
        fill(100, 100, 100, 150);
        ellipse(x, y, size * 1.5, size * 1.5);

        // Draw the core
        fill(255);
        ellipse(x, y, size, size);

        // Add decorative structures
        fill(200, 50, 50);
        float offset = size * 0.6;
        ellipse(x - offset, y, size * 0.3, size * 0.3); // Left turret
        ellipse(x + offset, y, size * 0.3, size * 0.3); // Right turret
        ellipse(x, y - offset, size * 0.3, size * 0.3); // Top turret
        ellipse(x, y + offset, size * 0.3, size * 0.3); // Bottom turret
    }
}