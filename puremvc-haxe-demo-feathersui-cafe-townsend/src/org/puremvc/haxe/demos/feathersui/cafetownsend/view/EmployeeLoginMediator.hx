/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.cafetownsend.view;

import feathers.controls.Alert;
import openfl.events.Event;
import org.puremvc.haxe.demos.feathersui.cafetownsend.model.UserProxy;
import org.puremvc.haxe.demos.feathersui.cafetownsend.view.components.EmployeeLogin;
import org.puremvc.haxe.interfaces.IMediator;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.mediator.Mediator;

/**
	A Mediator for interacting with the EmployeeLogin component.
**/
class EmployeeLoginMediator extends Mediator implements IMediator {
	// Cannnical name of the Mediator
	public static final NAME = "EmployeeLoginMediator";

	/**
		Constructor. 
	**/
	public function new(viewComponent:Any) {
		// pass the viewComponent to the superclass where
		// it will be stored in the inherited viewComponent property
		super(NAME, viewComponent);

		userProxy = cast(facade.retrieveProxy(UserProxy.NAME), UserProxy);

		employeeLogin.addEventListener(EmployeeLogin.APP_LOGIN, login);
	}

	/**
		List all notifications this Mediator is interested in.

		Automatically called by the framework when the mediator
		is registered with the view.

		@return Array the list of Notification names
	**/
	override public function listNotificationInterests():Array<String> {
		return [ApplicationFacade.APP_LOGOUT];
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
			case ApplicationFacade.APP_LOGOUT:
				employeeLogin.resetLogin();
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

		@return EmployeeLogin the viewComponent cast to org.puremvc.haxe.demos.feathersui.cafetownsend.view.components.EmployeeLogin
	**/
	private var employeeLogin(get, never):EmployeeLogin;

	private function get_employeeLogin():EmployeeLogin {
		return cast(viewComponent, EmployeeLogin);
	}

	private function login(event:Event = null):Void {
		var isValid = userProxy.validate(employeeLogin.username.text, employeeLogin.password.text);
		if (isValid) {
			sendNotification(ApplicationFacade.VIEW_EMPLOYEE_LIST);
		} else {
			// if the auth info was incorrect, prompt with an alert box and remain on the login screen
			Alert.show("Invaild username and/or password. Please try again.", "Login Failed", ["OK"]);
		}
	}

	private var userProxy:UserProxy;
}
