/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.cafetownsend.view.components;

import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.ListView;
import feathers.controls.Panel;
import feathers.controls.ScrollContainer;
import feathers.events.TriggerEvent;
import feathers.layout.ResponsiveGridLayout;
import feathers.layout.ResponsiveGridLayoutData;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalLayoutData;
import feathers.layout.VerticalListLayout;
import openfl.events.Event;
import org.puremvc.haxe.demos.feathersui.cafetownsend.model.vo.Employee;

class EmployeeList extends ScrollContainer {
	public static final APP_LOGOUT = "appLogout";
	public static final ADD_EMPLOYEE = "addEmployee";
	public static final UPDATE_EMPLOYEE = "updateEmployee";

	public var employees_li:ListView;
	public var error:Label;

	private var addEmployee_btn:Button;
	private var logout_btn:Button;

	public function new() {
		super();
	}

	override private function initialize():Void {
		super.initialize();

		var viewLayout = new ResponsiveGridLayout();
		viewLayout.setPadding(10.0);
		layout = viewLayout;

		var panel = new Panel();
		panel.layoutData = new ResponsiveGridLayoutData(12, 0, 8, 2, 6, 3, 4, 4);
		panel.layout = new VerticalLayout();
		addChild(panel);

		panel.header = new Header("Employee List");

		var toolBar = new LayoutGroup();
		toolBar.variant = LayoutGroup.VARIANT_TOOL_BAR;
		toolBar.layoutData = VerticalLayoutData.fillHorizontal();
		panel.addChild(toolBar);

		addEmployee_btn = new Button();
		addEmployee_btn.text = "Add New Employee";
		addEmployee_btn.addEventListener(TriggerEvent.TRIGGER, addEmployee_btn_triggerHandler);
		toolBar.addChild(addEmployee_btn);

		logout_btn = new Button();
		logout_btn.text = "Logout";
		logout_btn.addEventListener(TriggerEvent.TRIGGER, logout_btn_triggerHandler);
		toolBar.addChild(logout_btn);

		employees_li = new ListView();
		employees_li.layoutData = VerticalLayoutData.fillHorizontal();
		employees_li.itemToText = (item:Employee) -> item.lastname + ", " + item.firstname;
		var listLayout = new VerticalListLayout();
		listLayout.requestedMinRowCount = 5.0;
		employees_li.layout = listLayout;
		employees_li.addEventListener(Event.CHANGE, employees_li_changeHandler);
		panel.addChild(employees_li);

		error = new Label();
		panel.addChild(error);
	}

	// mutate the logout button's click event
	private function logout():Void {
		dispatchEvent(new Event(APP_LOGOUT));
	}

	// mutate the add new employee button's click event
	private function addNewEmployee():Void {
		dispatchEvent(new Event(ADD_EMPLOYEE));
		// de-select the list item (it may not exist next time we're on this view)
		clearSelectedEmployee();
	}

	// mutate the List's item trigger event
	private function updateEmployee():Void {
		dispatchEvent(new Event(UPDATE_EMPLOYEE));
		// de-select the list item (it may not exist next time we're on this view)
		clearSelectedEmployee();
	}

	// de-select any selected List items
	private function clearSelectedEmployee():Void {
		employees_li.selectedIndex = -1;
	}

	private function addEmployee_btn_triggerHandler(event:TriggerEvent):Void {
		addNewEmployee();
	}

	private function employees_li_changeHandler(event:Event):Void {
		if (employees_li.selectedIndex == -1) {
			return;
		}
		updateEmployee();
	}

	private function logout_btn_triggerHandler(event:TriggerEvent):Void {
		logout();
	}
}
