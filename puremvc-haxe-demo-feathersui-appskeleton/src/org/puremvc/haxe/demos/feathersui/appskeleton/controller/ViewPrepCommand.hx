/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton.controller;

import org.puremvc.haxe.demos.feathersui.appskeleton.view.ApplicationMediator;
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
		facade.registerMediator(new ApplicationMediator(cast(note.getBody(), AppSkeleton)));

		// send the notification for show the Splash Screen
		sendNotification(ApplicationFacade.VIEW_SPLASH_SCREEN);
	}
}
