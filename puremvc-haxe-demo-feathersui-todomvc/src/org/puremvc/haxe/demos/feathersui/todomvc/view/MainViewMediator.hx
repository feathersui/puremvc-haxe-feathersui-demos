/*
	PureMVC Haxe Demo - Feathers UI TodoMVC
	Copyright (c) 2022 Bowler Hat LLC
 */

package org.puremvc.haxe.demos.feathersui.todomvc.view;

import feathers.events.FlatCollectionEvent;
import openfl.events.Event;
import org.puremvc.haxe.demos.feathersui.todomvc.model.TodosProxy;
import org.puremvc.haxe.demos.feathersui.todomvc.view.components.MainView;
import org.puremvc.haxe.demos.feathersui.todomvc.view.components.events.EditTodoItemEvent;
import org.puremvc.haxe.demos.feathersui.todomvc.view.components.events.TodoItemEvent;
import org.puremvc.haxe.interfaces.IMediator;
import org.puremvc.haxe.patterns.mediator.Mediator;

/**
	A Mediator for interacting with the MainView component.
**/
class MainViewMediator extends Mediator implements IMediator {
	// Canonical name of the Mediator
	public static final NAME = "MainViewMediator";

	/**
		Constructor. 

		@param object the viewComponent (the AppSkeleton instance in this case)
	**/
	public function new(viewComponent:MainView) {
		// pass the viewComponent to the superclass where
		// it will be stored in the inherited viewComponent property
		super(NAME, viewComponent);

		this.todosProxy = cast(facade.retrieveProxy(TodosProxy.NAME), TodosProxy);

		var todosCollection = this.todosProxy.todosCollection;
		todosCollection.addEventListener(Event.CHANGE, todosCollection_changeHandler);
		todosCollection.addEventListener(FlatCollectionEvent.UPDATE_ITEM, todosCollection_updateItemHandler);
		todosCollection.addEventListener(FlatCollectionEvent.UPDATE_ALL, todosCollection_updateAllHandler);
		this.mainView.todosListView.dataProvider = todosCollection;
		mainView.addEventListener(TodoItemEvent.ADD_TODO_ITEM, mainView_addTodoItemHandler);
		mainView.addEventListener(TodoItemEvent.REMOVE_TODO_ITEM, mainView_removeTodoItemHandler);
		mainView.addEventListener(TodoItemEvent.TOGGLE_COMPLETED, mainView_toggleCompletedHandler);
		mainView.addEventListener(EditTodoItemEvent.EDIT_TODO_ITEM, mainView_editTodoItemHandler);
		mainView.addEventListener(MainView.EVENT_CLEAR_COMPLETED, mainView_clearCompletedHandler);
		mainView.addEventListener(MainView.EVENT_SELECT_ALL, mainView_selectAllHandler);
		mainView.addEventListener(MainView.EVENT_FILTER_ALL, mainView_filterAllHandler);
		mainView.addEventListener(MainView.EVENT_FILTER_ACTIVE, mainView_filterActiveHandler);
		mainView.addEventListener(MainView.EVENT_FILTER_COMPLETED, mainView_filterCompletedHandler);
	}

	private function refreshSelectAllToggle():Void {
		var allSelected = true;
		for (todoItem in this.todosProxy.todosCollection.array) {
			if (!todoItem.completed) {
				allSelected = false;
				break;
			}
		}
		var oldIgnore = this.ignoreSelectAllChange;
		this.ignoreSelectAllChange = true;
		this.mainView.selectAllToggle.selected = allSelected;
		this.ignoreSelectAllChange = oldIgnore;
	}

	private function refreshIncompleteCount():Void {
		var incompleteCount = 0;
		for (todoItem in this.todosProxy.todosCollection.array) {
			if (!todoItem.completed) {
				incompleteCount++;
			}
		}
		var itemsLeftText = Std.string(incompleteCount);
		if (incompleteCount == 1) {
			itemsLeftText += " item left";
		} else {
			itemsLeftText += " items left";
		}
		this.mainView.incompleteLabel.text = itemsLeftText;
	}

	private function refreshVisibility():Void {
		var hasItems = this.todosProxy.todosCollection.array.length > 0;
		var hasCompleted = false;
		for (todoItem in this.todosProxy.todosCollection.array) {
			if (todoItem.completed) {
				hasCompleted = true;
				break;
			}
		}
		this.mainView.clearButton.visible = hasCompleted;
		this.mainView.todosListView.visible = hasItems;
		this.mainView.todosListView.includeInLayout = hasItems;
		this.mainView.contentContainer.footer = hasItems ? this.mainView.bottomBar : null;
		this.mainView.selectAllToggle.visible = hasItems;
	}

	private function refreshAll():Void {
		this.refreshSelectAllToggle();
		this.refreshIncompleteCount();
		this.refreshVisibility();
	}

	private function todosCollection_changeHandler(event:Event):Void {
		this.refreshAll();
	}

	private function todosCollection_updateItemHandler(event:FlatCollectionEvent):Void {
		this.refreshAll();
	}

	private function todosCollection_updateAllHandler(event:FlatCollectionEvent):Void {
		this.refreshAll();
	}

	private function mainView_addTodoItemHandler(event:TodoItemEvent):Void {
		this.todosProxy.addTodoItem(event.todoItem);
	}

	private function mainView_removeTodoItemHandler(event:TodoItemEvent):Void {
		this.todosProxy.removeTodoItem(event.todoItem);
	}

	private function mainView_editTodoItemHandler(event:EditTodoItemEvent):Void {
		this.todosProxy.editTodoItem(event.todoItem, event.newText);
	}

	private function mainView_toggleCompletedHandler(event:TodoItemEvent):Void {
		this.todosProxy.toggleCompleted(event.todoItem);
	}

	private function mainView_clearCompletedHandler(event:Event):Void {
		this.todosProxy.clearCompleted();
	}

	private function mainView_selectAllHandler(event:Event):Void {
		if (this.ignoreSelectAllChange) {
			return;
		}
		this.todosProxy.refreshSelectAll(this.mainView.selectAllToggle.selected);
	}

	private function mainView_filterAllHandler(event:Event):Void {
		this.todosProxy.filterAll();
	}

	private function mainView_filterActiveHandler(event:Event):Void {
		this.todosProxy.filterActive();
	}

	private function mainView_filterCompletedHandler(event:Event):Void {
		this.todosProxy.filterCompleted();
	}

	private var todosProxy:TodosProxy;
	private var ignoreSelectAllChange:Bool = false;

	/**
		Cast the viewComponent to its actual type.

		This is a useful idiom for mediators. The
		PureMVC Mediator class defines a viewComponent
		property of type Object.

		Here, we cast the generic viewComponent to 
		its actual type in a protected mode. This 
		retains encapsulation, while allowing the instance
		(and subclassed instance) access to a 
		strongly typed reference with a meaningful
		name.

		@return mainView the viewComponent cast to MainView
	**/
	private var mainView(get, never):MainView;

	private function get_mainView():MainView {
		return cast(viewComponent, MainView);
	}
}
