/*
	PureMVC Haxe Demo - Feathers UI TodoMVC
	Copyright (c) 2022 Bowler Hat LLC
 */

package org.puremvc.haxe.demos.feathersui.todomvc.controller;

import org.puremvc.haxe.demos.feathersui.todomvc.model.TodosProxy;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.command.SimpleCommand;

/**
	Create and register `Proxy`s with the `Model`.
**/
class ModelPrepCommand extends SimpleCommand {
	override public function execute(note:INotification):Void {
		facade.registerProxy(new TodosProxy());
	}
}
