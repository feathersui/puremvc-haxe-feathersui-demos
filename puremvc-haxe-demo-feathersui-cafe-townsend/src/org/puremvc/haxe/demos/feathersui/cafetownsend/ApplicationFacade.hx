/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.cafetownsend;

import org.puremvc.haxe.demos.feathersui.cafetownsend.controller.ApplicationStartupCommand;
import org.puremvc.haxe.patterns.facade.Facade;

/**
	A concrete `Facade` for the `CafeTownsend` application.

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
	public static final SHUTDOWN = "shutdown";
	public static final APP_LOGOUT = "appLogout";
	public static final APP_LOGIN = "appLogin";
	public static final LOAD_EMPLOYEES_SUCCESS = "loadEmployeesSuccess";
	public static final LOAD_EMPLOYEES_FAILED = "loadEmployeesFailed";
	public static final VIEW_EMPLOYEE_LOGIN = "viewEmployeeLogin";
	public static final VIEW_EMPLOYEE_LIST = "viewEmployeeList";
	public static final VIEW_EMPLOYEE_DETAIL = "viewEmployeeDetail";
	public static final ADD_EMPLOYEE = "addEmployee";
	public static final UPDATE_EMPLOYEE = "updateEmployee";
	public static final SAVE_EMPLOYEE = "saveEmployee";
	public static final DELETE_EMPLOYEE = "deleteEmployee";

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
	public function startup(app:CafeTownsend):Void {
		sendNotification(STARTUP, app);
	}
}
