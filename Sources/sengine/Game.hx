package sengine;

import kha.input.Mouse;
import kha.input.Keyboard;
import kha.Framebuffer;
import kha.Scheduler;

//just doing alias until i figure out a better way to interface with kha classes
typedef System = kha.System;
typedef Assets = kha.Assets;
typedef Font = kha.Font;
typedef Color = kha.Color;
typedef Graphics = kha.graphics2.Graphics;
typedef Window = kha.Window;
typedef KeyCode = kha.input.KeyCode;

class Game {
	public var title:String;
	public var width:Int; // look into how to make event function to update width/height in real time
	public var height:Int;
	public var paused:Bool = false; // take a look at this later, not sure this is how pause function is implemented
	public var fps:Int;
	public var deltaTime:Float;
	public var keyboard:Keyboard; // reference variable
	public var mouse:Mouse; // reference variable

	private var currentTime:Float;
	private var loadAll:Bool;
	private var currentPage:Page;

	public function new(title:String, width:Int = 1024, height:Int = 768, loadAllAssets:Bool = true, fps = 60) {
		this.title = title;
		this.width = width;
		this.height = height;
		this.loadAll = loadAllAssets;
		this.fps = fps;
		this.currentPage = new Page();
		this.currentPage.game = this;
	}

	// Update the currentPage, update the deltaTime
	private function _update() {
		deltaTime = Scheduler.time() - currentTime;
		currentPage.update();
		currentTime = Scheduler.time();
	}

	// Render the currentPage
	private function _render(frames:Array<Framebuffer>) {
		final g2 = frames[0].g2;
		g2.begin(!paused, currentPage.backgroundColor);
		currentPage.render(g2);
		g2.end();
	}

	// Start the window/game, possibly load all assets if desired, add tasks
	public function init() {
		System.start({title: this.title, width: this.width, height: this.height}, function(window) {
			if (loadAll) {
				Assets.loadEverything(function() {
					trace("LOADED EVERYTHING");
					addTasks();
				});
			} else {
				addTasks();
			}
		});
		this.keyboard = Keyboard.get();
		this.mouse = Mouse.get();
	}

	// Convenience function to add timed _update() and _render(), and add a notify function to appropriately change width and height of game
	private function addTasks() {
		Scheduler.addTimeTask(function() {
			_update();
		}, 0, 1 / fps);
		System.notifyOnFrames(function(frames) {
			_render(frames);
		});
		Window.get(0).notifyOnResize(function(w, h) { // need to test, hopefully keeps the game width/height updated
			this.width = w;
			this.height = h;
		});
	}

	// Sets the currentPage variable, sets the `game` reference in the page, removes keyboard events
	public function setCurrentPage(p:Page) {
		p.game = this;
		this.keyboard.remove(this.currentPage.onKeyDown, this.currentPage.onKeyUp, this.currentPage.onKeyPress); // reset keyboard events for each page
		p.init();
		this.currentPage = p;
	}

	// Returns the currentPage variable
	public function getCurrentPage():Page {
		return this.currentPage;
	}
}
