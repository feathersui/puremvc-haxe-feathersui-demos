/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.cafetownsend.view;

import org.puremvc.haxe.demos.feathersui.cafetownsend.model.EmployeeProxy;
import org.puremvc.haxe.demos.feathersui.cafetownsend.model.UserProxy;
import org.puremvc.haxe.interfaces.IMediator;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.mediator.Mediator;

/**
	A Mediator for interacting with the top level Application.

	In addition to the ordinary responsibilities of a mediator
	the MXML application (in this case) built all the view components
	and so has a direct reference to them internally. Therefore
	we create and register the mediators for each view component
	with an associated mediator here.

	Then, ongoing responsibilities are: 

	- listening for events from the viewComponent (the application)
	sending notifications on behalf of or as a result of these 
	events or other notifications.
	- direct manipulating of the viewComponent by method invocation
	or property setting
**/
class ApplicationMediator extends Mediator implements IMediator {
	// Canonical name of the Mediator
	public static final NAME = "ApplicationMediator";

	/**
		Constructor. 

		On `applicationComplete` in the `Application`,
		the `ApplicationFacade` is initialized and the 
		`ApplicationMediator` is created and registered.

		The `ApplicationMediator` constructor also registers the 
		Mediators for the view components created by the application.

		@param object the viewComponent (the CafeTownsend instance in this case)
	**/
	public function new(viewComponent:CafeTownsend) {
		// pass the viewComponent to the superclass where
		// it will be stored in the inherited viewComponent property
		super(NAME, viewComponent);

		// retrieve and cache a reference to frequently accessed proxys
		employeeProxy = cast(facade.retrieveProxy(EmployeeProxy.NAME), EmployeeProxy);
		userProxy = cast(facade.retrieveProxy(UserProxy.NAME), UserProxy);
	}

	override public function onRegister():Void {
		// Create and register Mediators for the Employee
		// components that were instantiated by the mxml application
		facade.registerMediator(new EmployeeDetailMediator(app.employeeDetail));
		facade.registerMediator(new EmployeeListMediator(app.employeeList));
		facade.registerMediator(new EmployeeLoginMediator(app.employeeLogin));
	}

	/**
		List all notifications this Mediator is interested in.

		Automatically called by the framework when the mediator
		is registered with the view.

		@return Array the list of Notification names
	**/
	override public function listNotificationInterests():Array<String> {
		return [
			ApplicationFacade.VIEW_EMPLOYEE_LOGIN,
			ApplicationFacade.VIEW_EMPLOYEE_LIST,
			ApplicationFacade.VIEW_EMPLOYEE_DETAIL,
			ApplicationFacade.APP_LOGOUT,
			ApplicationFacade.UPDATE_EMPLOYEE
		];
	}

	/**
		Handle all notifications this Mediator is interested in.

		Called by the framework when a notification is sent that
		this mediator expressed an interest in when registered
		(see `listNotificationInterests`).

		@param INotification a notification 
	**/
	override public function handleNotification(note:INotification):Void {
		switch (note.getName()) {
			case ApplicationFacade.VIEW_EMPLOYEE_LOGIN:
				app.navigator.popToRootItemAndReplace(CafeTownsend.SCREEN_ID_EMPLOYEE_LOGIN);

			case ApplicationFacade.VIEW_EMPLOYEE_LIST:
				employeeProxy.employee = null;
				app.navigator.popToRootItemAndReplace(CafeTownsend.SCREEN_ID_EMPLOYEE_LIST);

			case ApplicationFacade.VIEW_EMPLOYEE_DETAIL:
				app.navigator.popToRootItemAndReplace(CafeTownsend.SCREEN_ID_EMPLOYEE_DETAIL);

			case ApplicationFacade.APP_LOGOUT:
				app.navigator.popToRootItemAndReplace(CafeTownsend.SCREEN_ID_EMPLOYEE_LOGIN);

			case ApplicationFacade.UPDATE_EMPLOYEE:
				app.navigator.popToRootItemAndReplace(CafeTownsend.SCREEN_ID_EMPLOYEE_DETAIL);
		}
	}

	/**
		Cast the viewComponent to its actual type.

		This is a useful idiom for mediators. The
		PureMVC Mediator class defines a viewComponent
		property of type Object.

		Here, we cast the generic viewComponent to 
		its actual type in a protected mode. This 
		retains encapsulation, while allowing the instance
		(and subclassed instance) access to a 
		strongly typed reference with a meaningful
		name.

		@return app the viewComponent cast to CafeTownsend
	**/
	private var app(get, never):CafeTownsend;

	private function get_app():CafeTownsend {
		return cast(viewComponent, CafeTownsend);
	}

	// Cached references to needed proxies
	private var employeeProxy:EmployeeProxy;
	private var userProxy:UserProxy;
}
