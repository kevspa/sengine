package sengine;

import haxe.ds.Either;
import kha.Color;
import kha.graphics2.Graphics;

class Object { //add rotation at some point
    public var x: Float;
    public var y: Float;
    public var rotation: Int;
    public var color: Color;
    public var parent: Page; //page that the object belongs to, eventually make nesting objects possible (so parents can be objects too)
    public function render(graphics: Graphics) {
        graphics.color = this.color;
    }
}