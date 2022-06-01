/*
	PureMVC Haxe Demo - Feathers UI TodoMVC
	Copyright (c) 2022 Bowler Hat LLC
 */

package org.puremvc.haxe.demos.feathersui.todomvc.view.components.events;

import openfl.events.Event;
import org.puremvc.haxe.demos.feathersui.todomvc.model.vo.TodoItem;

class TodoItemEvent extends Event {
	public static final ADD_TODO_ITEM = "addTodoItem";
	public static final REMOVE_TODO_ITEM = "removeTodoItem";
	public static final TOGGLE_COMPLETED = "toggleCompleted";

	public function new(type:String, todoItem:TodoItem) {
		super(type);
		this.todoItem = todoItem;
	}

	public var todoItem:TodoItem;

	override public function clone():TodoItemEvent {
		return new TodoItemEvent(this.type, this.todoItem);
	}
}
