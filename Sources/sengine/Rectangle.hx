package sengine;

import kha.graphics2.Graphics;

class Rectangle extends Shape {
    public var fill: Bool;

    public function new(x: Float, y: Float, width: Int, height: Int, fill: Bool = true) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.fill = fill;
    }
    override public function render(graphics: Graphics) {
        super.render(graphics);
        if (fill) {
            graphics.fillRect(x, y, width, height);
        } else {
            graphics.drawRect(x, y, width, height);
        }
    }
}