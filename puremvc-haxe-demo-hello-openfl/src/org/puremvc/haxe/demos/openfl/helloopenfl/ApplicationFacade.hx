/*
	PureMVC Haxe Demo - Hello OpenFL
	Copyright (c) 2022 Bowler Hat LLC
	PureMVC AS3 / Flash Demo - HelloFlash
	By Cliff Hall <clifford.hall@puremvc.org>
	Copyright(c) 2007-08, Some rights reserved.
 */

package org.puremvc.haxe.demos.openfl.helloopenfl;

import openfl.display.Stage;
import org.puremvc.haxe.demos.openfl.helloopenfl.controller.StartupCommand;
import org.puremvc.haxe.patterns.facade.Facade;

/**
	A concrete `Facade` for the `HelloOpenFL` application.

	The main job of the `ApplicationFacade` is to act as a single 
	place for mediators, proxies and commands to access and communicate
	with each other without having to interact with the Model, View, and
	Controller classes directly. All this capability it inherits from 
	the PureMVC Facade class.

	This concrete Facade subclass is also a central place to define 
	notification constants which will be shared among commands, proxies and
	mediators, as well as initializing the controller with Command to 
	Notification mappings.
**/
class ApplicationFacade extends Facade {
	// Notification name constants
	public static final STARTUP = "startup";
	public static final STAGE_ADD_SPRITE = "stageAddSprite";
	public static final SPRITE_SCALE = "spriteScale";
	public static final SPRITE_DROP = "spriteDrop";

	public function new() {
		super();
	}

	/**
		Singleton ApplicationFacade Factory Method
	**/
	public static function getInstance():ApplicationFacade {
		if (Facade.instance == null) {
			Facade.instance = new ApplicationFacade();
		}
		return cast(Facade.instance, ApplicationFacade);
	}

	/**
		Register Commands with the Controller 
	**/
	override private function initializeController():Void {
		super.initializeController();
		registerCommand(STARTUP, StartupCommand);
	}

	/**
		Start the application
	**/
	public function startup(stage:Stage):Void {
		sendNotification(STARTUP, stage);
	}
}
