package sengine;

import kha.input.KeyCode;
import kha.graphics2.Graphics;
import kha.Color;


class Page {
    public var backgroundColor = Color.White;
    private var children: Array<Object> = [];

    public function new() {}
    public function render(graphics: Graphics) {
        for (obj in children) {
            obj.render(graphics);
        }
    }
    public function update() {}
    public function add(obj: Object) {
		children.push(obj);
	}

    public function onKeyDown(key: KeyCode) {}
    public function onKeyUp(key: KeyCode) {}
    public function onKeyPress(key: String) {}
}