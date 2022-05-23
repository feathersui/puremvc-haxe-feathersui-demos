/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.cafetownsend.controller;

import org.puremvc.haxe.demos.feathersui.cafetownsend.model.EmployeeProxy;
import org.puremvc.haxe.demos.feathersui.cafetownsend.model.UserProxy;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.command.SimpleCommand;

/**
	Create and register `Proxy`s with the `Model`.
**/
class ModelPrepCommand extends SimpleCommand {
	override public function execute(note:INotification):Void {
		facade.registerProxy(new EmployeeProxy());
		facade.registerProxy(new UserProxy());
	}
}
