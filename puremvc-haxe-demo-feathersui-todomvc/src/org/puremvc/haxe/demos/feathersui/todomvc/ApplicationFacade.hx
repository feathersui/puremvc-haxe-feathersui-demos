/*
	PureMVC Haxe Demo - Feathers UI TodoMVC
	Copyright (c) 2022 Bowler Hat LLC
 */

package org.puremvc.haxe.demos.feathersui.todomvc;

import org.puremvc.haxe.demos.feathersui.todomvc.controller.ApplicationStartupCommand;
import org.puremvc.haxe.patterns.facade.Facade;

/**
	A concrete `Facade` for the `TodoMVC` application.

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
		registerCommand(STARTUP, ApplicationStartupCommand);
	}

	/**
		Start the application
	**/
	public function startup(app:TodoMVC):Void {
		sendNotification(STARTUP, app);
	}
}
