/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.cafetownsend.controller;

import org.puremvc.haxe.patterns.command.MacroCommand;

/**
	A MacroCommand executed when the application starts.

	@see org.puremvc.demos.feathersui.appskeleton.controller.ModelPrepCommand
	@see org.puremvc.demos.feathersui.appskeleton.controller.ViewPrepCommand
 */
class ApplicationStartupCommand extends MacroCommand {
	/**
		Initialize the MacroCommand by adding its SubCommands.

		Since we built the UI using an MXML `Application` tag, those
		components are created first. The top level `Application`
		then initialized the `ApplicationFacade`, which in turn initialized 
		the `Controller`, registering Commands. Then the 
		`Application` sent the `APP_STARTUP`
		Notification, leading to this `MacroCommand`'s execution.

		It is important for us to create and register Proxys with the Model 
		prior to creating and registering Mediators with the View, since 
		availability of Model data is often essential to the proper 
		initialization of the View.

		So, `ApplicationStartupCommand` first executes 
		`ModelPrepCommand` followed by `ViewPrepCommand`
	**/
	override private function initializeMacroCommand():Void {
		addSubCommand(ModelPrepCommand);
		addSubCommand(ViewPrepCommand);
	}
}
