/*
	PureMVC Haxe Demo - Feathers UI TodoMVC
	Copyright (c) 2022 Bowler Hat LLC
 */

package org.puremvc.haxe.demos.feathersui.todomvc.view.components.events;

import openfl.events.Event;
import org.puremvc.haxe.demos.feathersui.todomvc.model.vo.TodoItem;

class EditTodoItemEvent extends Event {
	public static final EDIT_TODO_ITEM = "editTodoItem";

	public function new(type:String, todoItem:TodoItem, newText:String) {
		super(type);
		this.todoItem = todoItem;
		this.newText = newText;
	}

	public var todoItem:TodoItem;
	public var newText:String;

	override public function clone():EditTodoItemEvent {
		return new EditTodoItemEvent(this.type, this.todoItem, this.newText);
	}
}
