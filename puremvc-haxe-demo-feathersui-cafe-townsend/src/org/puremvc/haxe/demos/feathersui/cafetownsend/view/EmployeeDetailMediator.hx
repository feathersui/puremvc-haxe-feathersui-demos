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
import org.puremvc.haxe.demos.feathersui.cafetownsend.model.vo.Employee;
import org.puremvc.haxe.demos.feathersui.cafetownsend.view.components.EmployeeDetail;
import org.puremvc.haxe.interfaces.IMediator;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.mediator.Mediator;

/**
	A Mediator for interacting with the EmployeeDetail component.
**/
class EmployeeDetailMediator extends Mediator implements IMediator {
	// Canonical name of the Mediator
	public static final NAME = "EmployeeDetailMediator";

	/**
		Constructor. 
	**/
	public function new(viewComponent:Any) {
		// pass the viewComponent to the superclass where
		// it will be stored in the inherited viewComponent property
		super(NAME, viewComponent);

		// retrieve and cache a reference to frequently accessed proxys
		employeeProxy = cast(facade.retrieveProxy(EmployeeProxy.NAME), EmployeeProxy);

		employeeDetail.addEventListener(EmployeeDetail.CANCEL_EDITS, cancelEdits);
		employeeDetail.addEventListener(EmployeeDetail.DELETE_EMPLOYEE, deleteEmployee);
		employeeDetail.addEventListener(EmployeeDetail.SAVE_EDITS, saveEdits);
	}

	/**
		Get the Mediator name

		Called by the framework to get the name of this
		mediator. If there is only one instance, we may
		define it in a constant and return it here. If
		there are multiple instances, this method must
		return the unique name of this instance.

		@return String the Mediator name
	 */
	override public function getMediatorName():String {
		return EmployeeDetailMediator.NAME;
	}

	/**
		List all notifications this Mediator is interested in.

		Automatically called by the framework when the mediator
		is registered with the view.

		@return Array the list of Notification names
	**/
	override public function listNotificationInterests():Array<String> {
		return [
			ApplicationFacade.UPDATE_EMPLOYEE,
			ApplicationFacade.SAVE_EMPLOYEE,
			ApplicationFacade.DELETE_EMPLOYEE,
			ApplicationFacade.ADD_EMPLOYEE
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
			case ApplicationFacade.ADD_EMPLOYEE:
				employeeProxy.employee = new Employee();
				employeeDetail.resetForm();
				sendNotification(ApplicationFacade.VIEW_EMPLOYEE_DETAIL);

			case ApplicationFacade.UPDATE_EMPLOYEE:
				var selectedItem = cast(note.getBody(), Employee);
				// Update the model
				employeeProxy.employee = selectedItem;
				// Update the view
				employeeDetail.firstname.text = employeeProxy.employee.firstname;
				employeeDetail.lastname.text = employeeProxy.employee.lastname;
				employeeDetail.startdate.selectedDate = employeeProxy.employee.startdate;
				employeeDetail.email.text = employeeProxy.employee.email;
				employeeDetail.delete_btn.enabled = true;

				sendNotification(ApplicationFacade.VIEW_EMPLOYEE_DETAIL);
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

		@return EmployeeDetail the viewComponent cast to org.puremvc.haxe.demos.feathersui.cafetownsend.view.components.EmployeeDetail
	**/
	private var employeeDetail(get, never):EmployeeDetail;

	private function get_employeeDetail():EmployeeDetail {
		return cast(viewComponent, EmployeeDetail);
	}

	private function cancelEdits(event:Event = null):Void {
		sendNotification(ApplicationFacade.VIEW_EMPLOYEE_LIST);
	}

	private function saveEdits(event:Event = null):Void {
		// Update the Model
		employeeProxy.employee.firstname = employeeDetail.firstname.text;
		employeeProxy.employee.lastname = employeeDetail.lastname.text;
		employeeProxy.employee.startdate = employeeDetail.startdate.selectedDate;
		employeeProxy.employee.email = employeeDetail.email.text;

		employeeProxy.saveEmployee();

		employeeProxy.employee = null;
		employeeDetail.resetForm();

		sendNotification(ApplicationFacade.LOAD_EMPLOYEES_SUCCESS);
		sendNotification(ApplicationFacade.VIEW_EMPLOYEE_LIST);
	}

	private function deleteEmployee(event:Event = null):Void {
		employeeProxy.deleteEmployee();
		sendNotification(ApplicationFacade.VIEW_EMPLOYEE_LIST);
	}

	private var employeeProxy:EmployeeProxy;
}
