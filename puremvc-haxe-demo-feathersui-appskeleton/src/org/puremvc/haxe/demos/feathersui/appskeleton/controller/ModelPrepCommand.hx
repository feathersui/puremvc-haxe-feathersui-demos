/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton.controller;

import org.puremvc.haxe.demos.feathersui.appskeleton.model.ConfigProxy;
import org.puremvc.haxe.demos.feathersui.appskeleton.model.LocaleProxy;
import org.puremvc.haxe.demos.feathersui.appskeleton.model.StartupMonitorProxy;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.command.SimpleCommand;

/**
	Create and register `Proxy`s with the `Model`.
**/
class ModelPrepCommand extends SimpleCommand {
	override public function execute(note:INotification):Void {
		facade.registerProxy(new StartupMonitorProxy());
		facade.registerProxy(new ConfigProxy());
		facade.registerProxy(new LocaleProxy());
	}
}
