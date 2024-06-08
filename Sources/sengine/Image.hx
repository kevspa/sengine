package sengine;

import sengine.Game;
import sengine.Game;
import sengine.Object;

class Image extends Object {
	public var image:kha.Image;
	public var width:Null<Int>;
	public var height:Null<Int>;

	public function new(img:kha.Image, x:Float, y:Float, width:Int = null, height:Int = null) {
		this.image = img;
		this.width = width;
		this.height = height;
	}

	override public function render(graphics:Graphics) {
        if (this.width != null && this.height != null) {
            graphics.drawScaledImage(this.image, this.x, this.y, this.width, this.height);
        } else {
            graphics.drawImage(this.image, this.x, this.y);
        }
	}
}
