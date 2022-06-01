/*
	PureMVC Haxe Demo - Feathers UI TodoMVC
	Copyright (c) 2022 Bowler Hat LLC
 */

package org.puremvc.haxe.demos.feathersui.todomvc.model.vo;

class TodoItem {
	public function new(?text:String) {
		this.text = text;
	}

	public var text:String;
	public var completed:Bool = false;
}
