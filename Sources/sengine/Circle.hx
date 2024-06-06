package sengine;

using kha.graphics2.GraphicsExtension;
import kha.graphics2.Graphics;

class Circle extends Object{
    public var fill: Bool;

    public function new(x: Int, y: Int, width: Int, height: Int, fill: Bool = true) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.fill = fill;
    }
    override public function render(graphics: Graphics) {
        super.render(graphics);
        
        if (fill) {
            graphics.fillCircle(x, y, width/2); //will be changed later
        } else {
            graphics.drawCircle(x, y, width/2);
        }
    }
}