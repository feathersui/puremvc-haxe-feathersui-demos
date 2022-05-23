/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.cafetownsend.view;

import openfl.events.Event;
import org.puremvc.haxe.demos.feathersui.cafetownsend.model.EmployeeProxy;
import org.puremvc.haxe.demos.feathersui.cafetownsend.view.components.EmployeeList;
import org.puremvc.haxe.interfaces.IMediator;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.mediator.Mediator;

/**
	A Mediator for interacting with the EmployeeList component
**/
class EmployeeListMediator extends Mediator implements IMediator {
	// Canonical name of the Mediator
	public static final NAME = "EmployeeListMediator";

	/**
		Constructor. 
	**/
	public function new(viewComponent:Any) {
		// pass the viewComponent to the superclass where
		// it will be stored in the inherited viewComponent property
		super(NAME, viewComponent);

		employeeProxy = cast(facade.retrieveProxy(EmployeeProxy.NAME), EmployeeProxy);

		employeeList.addEventListener(EmployeeList.APP_LOGOUT, logout);
		employeeList.addEventListener(EmployeeList.ADD_EMPLOYEE, addEmployee);
		employeeList.addEventListener(EmployeeList.UPDATE_EMPLOYEE, updateEmployee);
	}

	/**
		List all notifications this Mediator is interested in.

		Automatically called by the framework when the mediator
		is registered with the view.

		@return Array the list of Notification names
	**/
	override public function listNotificationInterests():Array<String> {
		return [
			ApplicationFacade.LOAD_EMPLOYEES_SUCCESS,
			ApplicationFacade.LOAD_EMPLOYEES_FAILED
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
			case ApplicationFacade.LOAD_EMPLOYEES_SUCCESS:
				employeeList.employees_li.dataProvider = employeeProxy.employeeListDP;

			case ApplicationFacade.LOAD_EMPLOYEES_FAILED:
				employeeList.error.text = employeeProxy.errorStatus;
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

		@return EmployeeList the viewComponent cast to org.puremvc.haxe.demos.feathersui.cafetownsend.view.components.EmployeeList
	**/
	private var employeeList(get, never):EmployeeList;

	private function get_employeeList():EmployeeList {
		return cast(viewComponent, EmployeeList);
	}

	private function logout(event:Event = null):Void {
		sendNotification(ApplicationFacade.APP_LOGOUT);
	}

	private function addEmployee(event:Event = null):Void {
		sendNotification(ApplicationFacade.ADD_EMPLOYEE);
	}

	private function updateEmployee(event:Event = null):Void {
		sendNotification(ApplicationFacade.UPDATE_EMPLOYEE, employeeList.employees_li.selectedItem);
	}

	private var employeeProxy:EmployeeProxy;
}
