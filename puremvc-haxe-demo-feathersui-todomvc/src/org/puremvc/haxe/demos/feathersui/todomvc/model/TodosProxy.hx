/*
	PureMVC Haxe Demo - Feathers UI TodoMVC
	Copyright (c) 2022 Bowler Hat LLC
 */

package org.puremvc.haxe.demos.feathersui.todomvc.model;

import feathers.data.ArrayCollection;
import org.puremvc.haxe.demos.feathersui.todomvc.model.vo.TodoItem;
import org.puremvc.haxe.interfaces.IProxy;
import org.puremvc.haxe.patterns.proxy.Proxy;

class TodosProxy extends Proxy implements IProxy {
	public static final NAME = "TodosProxy"; // Proxy name

	public function new(data:Any = null) {
		super(NAME);
	}

	public var todosCollection = new ArrayCollection<TodoItem>();

	public function addTodoItem(item:TodoItem):Void {
		this.todosCollection.add(item);
	}

	public function removeTodoItem(item:TodoItem):Void {
		this.todosCollection.remove(item);
	}

	public function editTodoItem(item:TodoItem, newText:String):Void {
		item.text = newText;
		this.todosCollection.updateAt(this.todosCollection.indexOf(item));
	}

	public function toggleCompleted(item:TodoItem):Void {
		item.completed = !item.completed;
		this.todosCollection.updateAt(this.todosCollection.indexOf(item));
	}

	public function clearCompleted():Void {
		var savedFilterFunction = this.todosCollection.filterFunction;
		this.todosCollection.filterFunction = null;
		var i = this.todosCollection.length - 1;
		while (i >= 0) {
			var todoItem = this.todosCollection.get(i);
			if (todoItem.completed) {
				this.todosCollection.removeAt(i);
			}
			i--;
		}
		this.todosCollection.filterFunction = savedFilterFunction;
	}

	public function refreshSelectAll(select:Bool):Void {
		for (todoItem in this.todosCollection.array) {
			todoItem.completed = select;
		}
		this.todosCollection.updateAll();
	}

	public function filterAll():Void {
		this.todosCollection.filterFunction = null;
	}

	public function filterActive():Void {
		this.todosCollection.filterFunction = activeFilterFunction;
	}

	public function filterCompleted():Void {
		this.todosCollection.filterFunction = completedFilterFunction;
	}

	private function activeFilterFunction(item:TodoItem):Bool {
		return !item.completed;
	}

	private function completedFilterFunction(item:TodoItem):Bool {
		return item.completed;
	}
}
