/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton.controller;

import org.puremvc.haxe.demos.feathersui.appskeleton.model.ConfigProxy;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.command.SimpleCommand;

/**
	This command set the default values in `ConfigProxy`
**/
class SetDefaultConfigValuesCommand extends SimpleCommand {
	override public function execute(note:INotification):Void {
		var configProxy = cast(facade.retrieveProxy(ConfigProxy.NAME), ConfigProxy);
		configProxy.setDefaultValue("language", "en");
		configProxy.setDefaultValue("testDefaultValue", "This isn't defined in config.xml but in SetDefaultConfigValuesCommand");
	}
}
