package sengine;

import kha.graphics2.Graphics;
import kha.Font;

class Text extends Object {
	public var content:String;
	public var font:Font;
	public var pointSize:Int;

	public function new(content:String, x:Float, y:Float, font:Font, pointSize:Int = 18) {
		this.content = content;
		this.x = x;
		this.y = y;
		this.font = font;
		this.pointSize = pointSize;
	}

	override public function render(graphics:Graphics) {
		graphics.font = this.font;
		graphics.fontSize = this.pointSize;
		graphics.drawString(this.content, this.x, this.y);
	}
	public function centerHorizontally(p: Page = null ) {
		if (p == null) {
            p = this.parent;
        }
        this.x = (p.game.width / 2) - (this.getWidth()/2);
    }
	public function centerVertically(p: Page = null) {
		if (p == null) { //not really necessary, ill keep it for now though
            p = this.parent;
        }
        this.y = (p.game.height / 2) - (this.getHeight()/2);
    }
	public function getHeight(): Float {
		return this.font.height(this.pointSize);
	}
	public function getWidth(): Float {
		return this.font.width(this.pointSize, this.content);
	}
}
