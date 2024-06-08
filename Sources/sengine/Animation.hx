package sengine;

import sengine.Game;

class Animation extends Image {
	public var frameWidth:Int;
	public var frameHeight:Int;
	public var frameCount:Int;
	public var currentFrame:Int = 1;
	public var fps:Int = 10;

	private var frameGroups:Map<String, Array<Int>>; // separate _frames into different groups for different actions(idle, movement, etc.)
	private var id:Null<Int>;

	public function new(img:kha.Image, x:Float, y:Float, width:Int = null, height:Int = null, frameCount:Int) {
		super(img, x, y, width, height);
		this.frameCount = frameCount;
		this.frameWidth = Math.round(img.width / frameCount);
		this.frameHeight = img.height;
		this.frameGroups = new Map<String, Array<Int>>();
	}

	override public function render(graphics:Graphics) {
		if (this.width != null && this.height != null) {
			graphics.drawScaledSubImage(this.image, (this.currentFrame - 1) * this.frameWidth, 0, this.frameWidth, this.frameHeight, this.x, this.y,
				this.width, this.height);
		} else {
			graphics.drawSubImage(this.image, this.x, this.y, (this.currentFrame - 1) * this.frameWidth, 0, this.frameWidth, this.frameHeight);
		}
	}

	// returns false if anim couldnt begin, true if it could
	public function begin(group:String, fps:Int = 10, loop:Bool = true):Bool {
		if (this.id != null) {
			return false;
			trace("stop the current animation before beginning another one");
		}
		this.currentFrame = frameGroups[group][0];
		this.id = Scheduler.addBreakableTimeTask(function() {
			var frames = frameGroups[group];
			var currentIndex = frames.indexOf(this.currentFrame);
			if (currentIndex >= frames.length - 1) { // if currentFrame is outside of group bounds
				this.currentFrame = frames[0];
				if (!loop) { // stop changing frame if loop not wanted
					return false;
				}
			} else {
				this.currentFrame = frames[currentIndex + 1];
			}
			return true;
		}, 0, 1 / fps);
		return true;
	}

	public function pause(pause:Bool = true) {
		try {
			Scheduler.pauseTimeTask(this.id, pause);
		} catch (e) {
			trace("Animation paused before beginning:\n\t" + e);
		}
	}

	public function stop() {
		try {
			Scheduler.removeTimeTask(this.id);
			this.id = null;
		} catch (e) {
			trace("Animation stopped before beginning:\n\t" + e);
		}
	}

	/*
		returns false if group couldnt be added due to out of bounds, true if group was added
		frames begin at index 1, not 0 like arrays
	 */
	public function addFrameGroup(id:String, _frames:Array<Int>):Bool {
		for (frame in _frames) {
			if (frame > frameCount) {
				return false;
			}
		}
		frameGroups[id] = _frames;
		return true;
	}
}
