package sengine;

import sengine.Game;

class Animation extends Image {
	public var frameWidth:Int;
	public var frameHeight:Int;
	public var frameCount:Int;
	public var currentFrame:Int = 1;
	public var running:Bool = true;
	public var frameLength:Int = 20; // how many frames shall the anim frame last? weird implementation, probably gonna change later
	private var framesLasted:Int = 0; // for the above variable, really dumb implementation for now
    //TODO make a more efficient animation system(look at render function + above two variables)

	public function new(img:kha.Image, x:Float, y:Float, width:Int = null, height:Int = null, frameCount:Int) {
		super(img, x, y, width, height);
		this.frameCount = frameCount;
		this.frameWidth = Math.round(img.width/frameCount);
		this.frameHeight = img.height;
	}

	override public function render(graphics:Graphics) {
		if (currentFrame > frameCount) {
			currentFrame = 1;
		}
		if (this.width != null && this.height != null) {
			graphics.drawScaledSubImage(this.image, (this.currentFrame - 1) * this.frameWidth, 0, this.frameWidth, this.frameHeight, this.x, this.y,
				this.width, this.height);
		} else {
			graphics.drawSubImage(this.image, this.x, this.y, (this.currentFrame - 1) * this.frameWidth, 0, this.frameWidth, this.frameHeight);
		}
		if (framesLasted >= frameLength) {
			if (running) {
				currentFrame += 1;
				framesLasted = 0;
			} else {
				framesLasted = 0; // to reset
			}
		}
        framesLasted += 1;
	}
}