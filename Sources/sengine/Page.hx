package sengine;

import kha.input.Keyboard;
import kha.input.KeyCode;
import kha.graphics2.Graphics;
import kha.Color;

class Page {
	public var backgroundColor = Color.White;
	public var game:Game; // reference to the game object, null until its made the currentPage

	private var children:Array<Object> = [];

	public function new() {}

	public function render(graphics:Graphics) { // i want to find a better way to do this, tedious and can cause errors easily if i forget to
	}
    public function _render(graphics:Graphics) {
        for (obj in children) {
			obj.render(graphics); //children of a page are rendered first
		}
        this.render(graphics);
    }

	public function init() {} // for doing kha things that dont work in the constructor for whatever reason

	public function update() {}

	public function add(obj:Object) {
		obj.parent = this;
		children.push(obj);
	}

	// For setting keyboard events
	public function onKeyDown(key:KeyCode) {}

	public function onKeyUp(key:KeyCode) {}

	public function onKeyPress(key:String) {}
}
