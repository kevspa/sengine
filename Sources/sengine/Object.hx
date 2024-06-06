package sengine;

import kha.Color;
import kha.graphics2.Graphics;

class Object { //add rotation at some point
    public var x: Float;
    public var y: Float;
    public var width: Int;
    public var height: Int;
    public var rotation: Int;
    public var color: Color;
    
    public function render(graphics: Graphics) {
        graphics.color = this.color;
    }
}