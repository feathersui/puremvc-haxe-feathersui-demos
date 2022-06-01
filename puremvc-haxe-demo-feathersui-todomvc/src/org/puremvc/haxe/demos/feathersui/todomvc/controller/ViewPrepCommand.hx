/*
	PureMVC Haxe Demo - Feathers UI TodoMVC
	Copyright (c) 2022 Bowler Hat LLC
 */

package org.puremvc.haxe.demos.feathersui.todomvc.controller;

import org.puremvc.haxe.demos.feathersui.todomvc.view.ApplicationMediator;
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
		facade.registerMediator(new ApplicationMediator(cast(note.getBody(), TodoMVC)));
	}
}
