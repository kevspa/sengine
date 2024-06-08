package sengine;

class Shape extends Object {
	public var width:Int;
	public var height:Int;

	public function centerHorizontally(p:Page = null) {
		if (p == null) {
			p = this.parent;
		}
		this.x = (p.game.width / 2) - (this.width / 2);
	}

	public function centerVertically(p:Page = null) {
		if (p == null) {
			p = this.parent;
		}
		this.y = (p.game.height / 2) - (this.height / 2);
	}
}
