package sengine;

import kha.input.Mouse;
import kha.input.Keyboard;
import kha.Color;
import kha.Window;
import kha.Assets;
import kha.System;
import kha.Framebuffer;
import kha.Scheduler;

class Game {
	public var title:String;
	public var width:Int;
	public var height:Int;
	public var paused:Bool = false; // take a look at this later, not sure this is how pause function is implemented
	public var fps:Int;
	public var deltaTime:Float;
	public var keyboard:Keyboard;
	public var mouse:Mouse;

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
	}

	private function _update() {
		deltaTime = Scheduler.time() - currentTime;
		currentPage.update();
		currentTime = Scheduler.time();
	}

	private function _render(frames:Array<Framebuffer>) {
		final g2 = frames[0].g2;
		g2.begin(!paused, currentPage.backgroundColor);
		currentPage.render(g2);
		g2.end();
	}

	public function init() {
		System.start({title: this.title, width: this.width, height: this.height}, function(window) {
			if (loadAll) {
				Assets.loadEverything(function() {
					addTasks();
				});
			} else {
				addTasks();
			}
		});
		this.keyboard = Keyboard.get();
		this.mouse = Mouse.get();
	}

	private function addTasks() {
		Scheduler.addTimeTask(function() {
			_update();
		}, 0, 1 / fps);
		System.notifyOnFrames(function(frames) {
			_render(frames);
		});
	}

	public function setCurrentPage(p: Page) {
		this.keyboard.remove(p.onKeyDown, p.onKeyUp, p.onKeyPress); //reset keyboard events for each page
		this.currentPage = p;
	}
	public function getCurrentPage(p: Page) {
		return this.currentPage;
	}
}
