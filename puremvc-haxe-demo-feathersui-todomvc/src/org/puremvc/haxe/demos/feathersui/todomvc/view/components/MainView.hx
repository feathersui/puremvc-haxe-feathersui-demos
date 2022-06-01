/*
	PureMVC Haxe Demo - Feathers UI TodoMVC
	Copyright (c) 2022 Bowler Hat LLC
 */

package org.puremvc.haxe.demos.feathersui.todomvc.view.components;

import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.ListView;
import feathers.controls.Panel;
import feathers.controls.ScrollContainer;
import feathers.controls.TabBar;
import feathers.controls.TextInput;
import feathers.controls.ToggleButton;
import feathers.data.ArrayCollection;
import feathers.data.ListViewItemState;
import feathers.events.TriggerEvent;
import feathers.layout.HorizontalLayout;
import feathers.layout.HorizontalLayoutData;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalListFixedRowLayout;
import feathers.utils.DisplayObjectRecycler;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import org.puremvc.haxe.demos.feathersui.todomvc.model.vo.TodoItem;
import org.puremvc.haxe.demos.feathersui.todomvc.view.components.events.EditTodoItemEvent;
import org.puremvc.haxe.demos.feathersui.todomvc.view.components.events.TodoItemEvent;

class MainView extends ScrollContainer {
	public static final EVENT_CLEAR_COMPLETED = "clearCompleted";
	public static final EVENT_SELECT_ALL = "selectAll";
	public static final EVENT_FILTER_ACTIVE = "filterActive";
	public static final EVENT_FILTER_COMPLETED = "filterCompleted";
	public static final EVENT_FILTER_ALL = "filterAll";

	public static final CHILD_VARIANT_CONTENT:String = "todos_content";
	public static final CHILD_VARIANT_NEW_TODO_TEXT_INPUT:String = "todos_newTodoTextInput";
	public static final CHILD_VARIANT_TITLE_LABEL:String = "todos_titleLabel";
	public static final CHILD_VARIANT_SELECT_ALL_TOGGLE:String = "todos_selectAllToggle";
	public static final CHILD_VARIANT_BOTTOM_BAR:String = "todos_bottomBar";
	public static final CHILD_VARIANT_FOOTER_TEXT:String = "todos_footerText";

	public function new() {
		super();
	}

	public var todosListView:ListView;
	public var selectAllToggle:ToggleButton;
	public var incompleteLabel:Label;
	public var clearButton:Button;
	public var contentContainer:Panel;
	public var bottomBar:LayoutGroup;

	private var newTodoInput:TextInput;
	private var filterTabs:TabBar;

	override private function initialize():Void {
		super.initialize();

		this.autoSizeMode = STAGE;
		var mainLayout = new VerticalLayout();
		mainLayout.horizontalAlign = CENTER;
		mainLayout.justifyResetEnabled = true;
		mainLayout.setPadding(10.0);
		mainLayout.gap = 10.0;
		this.layout = mainLayout;

		var title = new Label();
		title.text = "todos";
		title.variant = CHILD_VARIANT_TITLE_LABEL;
		this.addChild(title);

		this.contentContainer = new Panel();
		this.contentContainer.width = 550.0;
		var contentLayout = new VerticalLayout();
		contentLayout.horizontalAlign = JUSTIFY;
		this.contentContainer.layout = contentLayout;
		this.addChild(this.contentContainer);

		var topBar = new LayoutGroup();
		var topBarLayout = new HorizontalLayout();
		topBarLayout.gap = 5.0;
		topBarLayout.verticalAlign = MIDDLE;
		topBar.layout = topBarLayout;
		this.contentContainer.header = topBar;

		this.selectAllToggle = new ToggleButton();
		this.selectAllToggle.variant = CHILD_VARIANT_SELECT_ALL_TOGGLE;
		this.selectAllToggle.visible = false;
		this.selectAllToggle.addEventListener(Event.CHANGE, selectAllToggle_changeHandler);

		this.newTodoInput = new TextInput();
		this.newTodoInput.variant = CHILD_VARIANT_NEW_TODO_TEXT_INPUT;
		this.newTodoInput.leftView = this.selectAllToggle;
		this.newTodoInput.prompt = "What needs to be done?";
		this.newTodoInput.layoutData = HorizontalLayoutData.fillHorizontal();
		this.newTodoInput.addEventListener(KeyboardEvent.KEY_DOWN, newTodoInput_keyDownHandler);
		topBar.addChild(this.newTodoInput);

		this.todosListView = new ListView();
		this.todosListView.itemRendererRecycler = DisplayObjectRecycler.withFunction(() -> {
			var itemRenderer = new TodoItemRenderer();
			itemRenderer.addEventListener(TodoItemEvent.TOGGLE_COMPLETED, todoItemRenderer_toggleCompletedHandler);
			itemRenderer.addEventListener(TodoItemEvent.REMOVE_TODO_ITEM, todoItemRenderer_removeTodoItemHandler);
			itemRenderer.addEventListener(EditTodoItemEvent.EDIT_TODO_ITEM, todoItemRenderer_editTodoItemHandler);
			return itemRenderer;
		}, (itemRenderer, state:ListViewItemState) -> {
			itemRenderer.todoItem = state.data;
		}, (itemRenderer, state) -> {
			itemRenderer.todoItem = null;
		}, (itemRenderer) -> {
			itemRenderer.removeEventListener(TodoItemEvent.TOGGLE_COMPLETED, todoItemRenderer_toggleCompletedHandler);
			itemRenderer.removeEventListener(TodoItemEvent.REMOVE_TODO_ITEM, todoItemRenderer_removeTodoItemHandler);
			itemRenderer.removeEventListener(EditTodoItemEvent.EDIT_TODO_ITEM, todoItemRenderer_editTodoItemHandler);
		});

		this.todosListView.itemToText = (item:TodoItem) -> item.text;
		this.todosListView.selectable = false;
		this.todosListView.layout = new VerticalListFixedRowLayout();
		this.todosListView.visible = false;
		this.contentContainer.addChild(this.todosListView);

		this.bottomBar = new LayoutGroup();
		this.bottomBar.variant = CHILD_VARIANT_BOTTOM_BAR;

		this.incompleteLabel = new Label();
		bottomBar.addChild(this.incompleteLabel);

		this.filterTabs = new TabBar();
		this.filterTabs.dataProvider = new ArrayCollection([
			new FilterItem("All", EVENT_FILTER_ALL),
			new FilterItem("Active", EVENT_FILTER_ACTIVE),
			new FilterItem("Completed", EVENT_FILTER_COMPLETED)
		]);
		this.filterTabs.itemToText = item -> item.text;
		this.filterTabs.addEventListener(Event.CHANGE, filterTabs_changeHandler);
		bottomBar.addChild(this.filterTabs);

		this.clearButton = new Button();
		this.clearButton.text = "Clear Completed";
		this.clearButton.visible = false;
		this.clearButton.addEventListener(TriggerEvent.TRIGGER, clearButton_triggerHandler);
		bottomBar.addChild(this.clearButton);

		var footerText = new Label();
		footerText.variant = CHILD_VARIANT_FOOTER_TEXT;
		footerText.htmlText = '<p>Created with <a href="https://feathersui.com/"><u>Feathers UI</u></a> and <a href="https://github.com/PureMVC/puremvc-haxe-standard-framework/"><u>PureMVC</u></a></p><p>Inspired by <a href="https://todomvc.com/"><u>TodoMVC</u></a></p>';
		this.addChild(footerText);
	}

	private function createNewTodo(text:String):Void {
		var todoText = StringTools.trim(text);
		if (todoText.length == 0) {
			return;
		}
		var item = new TodoItem(todoText);
		this.dispatchEvent(new TodoItemEvent(TodoItemEvent.ADD_TODO_ITEM, item));
	}

	private function selectAllToggle_changeHandler(event:Event):Void {
		this.dispatchEvent(new Event(EVENT_SELECT_ALL));
	}

	private function newTodoInput_keyDownHandler(event:KeyboardEvent):Void {
		if (event.keyCode == Keyboard.ENTER) {
			this.createNewTodo(this.newTodoInput.text);
			this.newTodoInput.text = "";
		}
	}

	private function filterTabs_changeHandler(event:Event):Void {
		var filterItem = cast(this.filterTabs.selectedItem, FilterItem);
		this.dispatchEvent(new Event(filterItem.event));
	}

	private function clearButton_triggerHandler(event:TriggerEvent):Void {
		this.dispatchEvent(new Event(EVENT_CLEAR_COMPLETED));
	}

	private function todoItemRenderer_toggleCompletedHandler(event:Event):Void {
		// simply redispatch
		this.dispatchEvent(event);
	}

	private function todoItemRenderer_removeTodoItemHandler(event:TodoItemEvent):Void {
		// simply redispatch
		this.dispatchEvent(event);
	}

	private function todoItemRenderer_editTodoItemHandler(event:EditTodoItemEvent):Void {
		// simply redispatch
		this.dispatchEvent(event);
	}
}

private class FilterItem {
	public function new(text:String, event:String) {
		this.text = text;
		this.event = event;
	}

	public var text:String;
	public var event:String;
}
