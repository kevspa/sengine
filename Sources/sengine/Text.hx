package sengine;

import kha.graphics2.Graphics;
import kha.Font;

class Text extends Object {
    public var content: String;
    public var font: Font;
    public var pointSize: Int;
    public function new(content: String, x:Int, y: Int, pointSize: Int = 18) {
        this.content = content;
        this.x = x;
        this.y = y;
        this.pointSize = pointSize;
    }
    override public function render(graphics: Graphics) {
        graphics.font = this.font;
        graphics.fontSize = this.pointSize;
        graphics.drawString(this.content, this.x, this.y);
    }
}