/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.cafetownsend.view.components;

import feathers.controls.Alert;
import feathers.controls.Button;
import feathers.controls.Form;
import feathers.controls.FormItem;
import feathers.controls.Header;
import feathers.controls.LayoutGroup;
import feathers.controls.Panel;
import feathers.controls.PopUpDatePicker;
import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;
import feathers.core.FocusManager;
import feathers.events.TriggerEvent;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.layout.ResponsiveGridLayout;
import feathers.layout.ResponsiveGridLayoutData;
import openfl.events.Event;

class EmployeeDetail extends ScrollContainer {
	public static final CANCEL_EDITS = "cancelEdits";
	public static final DELETE_EMPLOYEE = "deleteEmployee";
	public static final SAVE_EDITS = "saveEdits";

	public var firstname:TextInput;
	public var lastname:TextInput;
	public var email:TextInput;
	public var startdate:PopUpDatePicker;
	public var delete_btn:Button;

	private var details_frm:Form;
	private var submit_btn:Button;
	private var cancel_btn:Button;

	public function new() {
		super();
	}

	public function resetForm():Void {
		firstname.enabled = true;
		lastname.enabled = true;
		email.enabled = true;
		firstname.text = "";
		lastname.text = "";
		email.text = "";
		startdate.selectedDate = Date.now();
		delete_btn.enabled = false;
	}

	override private function initialize():Void {
		super.initialize();

		var viewLayout = new ResponsiveGridLayout();
		viewLayout.setPadding(10.0);
		layout = viewLayout;

		var panel = new Panel();
		panel.layoutData = new ResponsiveGridLayoutData(12, 0, 8, 2, 6, 3, 4, 4);
		panel.layout = new AnchorLayout();
		addChild(panel);

		var header = new Header("Employee Details");
		panel.header = header;

		cancel_btn = new Button();
		cancel_btn.text = "Cancel";
		cancel_btn.addEventListener(TriggerEvent.TRIGGER, cancel_btn_triggerHandler);
		header.leftView = cancel_btn;

		details_frm = new Form();
		details_frm.layoutData = AnchorLayoutData.fill(10.0);
		panel.addChild(details_frm);

		firstname = new TextInput();
		var firstname_fi = new FormItem("First Name:", firstname);
		firstname_fi.required = true;
		firstname_fi.horizontalAlign = JUSTIFY;
		details_frm.addChild(firstname_fi);

		lastname = new TextInput();
		var lastname_fi = new FormItem("Last Name:", lastname);
		lastname_fi.required = true;
		lastname_fi.horizontalAlign = JUSTIFY;
		details_frm.addChild(lastname_fi);

		startdate = new PopUpDatePicker();
		var startdate_fi = new FormItem("Start Date:", startdate);
		startdate_fi.horizontalAlign = JUSTIFY;
		details_frm.addChild(startdate_fi);

		email = new TextInput();
		var email_fi = new FormItem("Email:", email);
		email_fi.required = true;
		email_fi.horizontalAlign = JUSTIFY;
		details_frm.addChild(email_fi);

		var footer = new LayoutGroup();
		footer.variant = LayoutGroup.VARIANT_TOOL_BAR;
		panel.footer = footer;

		submit_btn = new Button();
		submit_btn.text = "Submit";
		submit_btn.addEventListener(TriggerEvent.TRIGGER, submit_btn_triggerHandler);
		footer.addChild(submit_btn);

		delete_btn = new Button();
		delete_btn.text = "Delete";
		delete_btn.addEventListener(TriggerEvent.TRIGGER, delete_btn_triggerHandler);
		footer.addChild(delete_btn);
	}

	// mutate the back button's click event
	private function cancelEmployeeEdits():Void {
		dispatchEvent(new Event(CANCEL_EDITS));
	}

	// mutate the submit button's click event
	private function saveEmployeeEdits():Void {
		// first, validate the fields
		var noFirstName = firstname.text == null || firstname.text.length == 0;
		var noLastName = lastname.text == null || lastname.text.length == 0;
		var noEmail = email.text == null || email.text.length == 0;
		// if any of the fields were not valid
		if (noFirstName || noLastName || noEmail) {
			// return focus to the firstname field and do nothing else
			FocusManager.setFocus(firstname);
			return;
		}

		firstname.enabled = false;
		lastname.enabled = false;
		email.enabled = false;

		// to make it here the fields must have been valid
		dispatchEvent(new Event(SAVE_EDITS));
	}

	// mutate the alert's OK button trigger
	private function deleteEmployee():Void {
		dispatchEvent(new Event(DELETE_EMPLOYEE));
	}

	private function cancel_btn_triggerHandler(event:TriggerEvent):Void {
		cancelEmployeeEdits();
	}

	private function submit_btn_triggerHandler(event:TriggerEvent):Void {
		saveEmployeeEdits();
	}

	private function delete_btn_triggerHandler(event:TriggerEvent):Void {
		Alert.show("Are you sure you want to delete the following employee?", "Delete employee?", ["OK", "Cancel"], state -> {
			if (state.text == "OK") {
				deleteEmployee();
			}
		});
	}
}
