/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton;

import org.puremvc.haxe.demos.feathersui.appskeleton.controller.ApplicationStartupCommand;
import org.puremvc.haxe.patterns.facade.Facade;

/**
	A concrete `Facade` for the `AppSkeleton` application.

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
	// application
	public static final STARTUP = "startup";
	public static final SHUTDOWN = "shutdown";

	// command
	public static final COMMAND_STARTUP_MONITOR = "StartupMonitorCommand";

	// view
	public static final VIEW_SPLASH_SCREEN = "viewSplashScreen";
	public static final VIEW_MAIN_SCREEN = "viewMainScreen";

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
	public function startup(app:AppSkeleton):Void {
		sendNotification(STARTUP, app);
	}
}
