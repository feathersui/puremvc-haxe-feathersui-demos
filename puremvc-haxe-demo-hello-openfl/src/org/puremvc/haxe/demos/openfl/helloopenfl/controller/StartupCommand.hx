/*
	PureMVC Haxe Demo - Hello OpenFL
	Copyright (c) 2022 Bowler Hat LLC
	PureMVC AS3 / Flash Demo - HelloFlash
	By Cliff Hall <clifford.hall@puremvc.org>
	Copyright(c) 2007-08, Some rights reserved.
 */

package org.puremvc.haxe.demos.openfl.helloopenfl.controller;

import openfl.display.Stage;
import org.puremvc.haxe.demos.openfl.helloopenfl.model.SpriteDataProxy;
import org.puremvc.haxe.demos.openfl.helloopenfl.view.StageMediator;
import org.puremvc.haxe.interfaces.ICommand;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.command.SimpleCommand;

/**
	A command executed when the application starts.
 */
class StartupCommand extends SimpleCommand implements ICommand {
	/**
		Register the Proxies and Mediators.

		Get the View Components for the Mediators from the app,
		which passed a reference to itself on the notification.
	**/
	override public function execute(note:INotification):Void {
		facade.registerProxy(new SpriteDataProxy());
		var stage = cast(note.getBody(), Stage);
		facade.registerMediator(new StageMediator(stage));
		sendNotification(ApplicationFacade.STAGE_ADD_SPRITE);
	}
}
