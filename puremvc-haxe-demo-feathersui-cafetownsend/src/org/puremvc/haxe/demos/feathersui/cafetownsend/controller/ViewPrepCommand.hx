/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.cafetownsend.controller;

import org.puremvc.haxe.demos.feathersui.cafetownsend.model.EmployeeProxy;
import org.puremvc.haxe.demos.feathersui.cafetownsend.view.ApplicationMediator;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.command.SimpleCommand;

/**
	Prepare the View for use.

	The `Notification` was sent by the `Application`,
	and a reference to that view component was passed on the note body.
	The `ApplicationMediator` will be created and registered using this
	reference. The `ApplicationMediator` will then register 
	all the `Mediator`s for the components it created.
**/
class ViewPrepCommand extends SimpleCommand {
	override public function execute(note:INotification):Void {
		// Register the ApplicationMediator
		facade.registerMediator(new ApplicationMediator(cast(note.getBody(), CafeTownsend)));

		// Get the EmployeeProxy
		var employeeProxy = cast(facade.retrieveProxy(EmployeeProxy.NAME), EmployeeProxy);
		employeeProxy.loadEmployees();

		sendNotification(ApplicationFacade.VIEW_EMPLOYEE_LOGIN);
	}
}
