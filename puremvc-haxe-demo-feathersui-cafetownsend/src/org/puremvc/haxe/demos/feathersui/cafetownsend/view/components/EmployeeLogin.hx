/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.cafetownsend.view.components;

import feathers.controls.Button;
import feathers.controls.Form;
import feathers.controls.FormItem;
import feathers.controls.Header;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.Panel;
import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;
import feathers.events.TriggerEvent;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.layout.HorizontalLayoutData;
import feathers.layout.ResponsiveGridLayout;
import feathers.layout.ResponsiveGridLayoutData;
import openfl.events.Event;

class EmployeeLogin extends ScrollContainer {
	public static final APP_LOGIN = "appLogin";

	public var username:TextInput;
	public var password:TextInput;

	private var login_frm:Form;
	private var login_btn:Button;

	public function new() {
		super();
	}

	public function resetLogin():Void {
		username.enabled = true;
		password.enabled = true;
		username.text = "";
		password.text = "";
	}

	override private function initialize():Void {
		super.initialize();

		var viewLayout = new ResponsiveGridLayout();
		viewLayout.setPadding(10.0);
		layout = viewLayout;

		var panel = new Panel();
		panel.layoutData = new ResponsiveGridLayoutData(12, 0, 8, 2, 6, 3, 4, 4);
		panel.layout = new AnchorLayout();
		panel.header = new Header("Cafe Townsend Login");
		addChild(panel);

		login_frm = new Form();
		login_frm.layoutData = AnchorLayoutData.fill(10.0);
		panel.addChild(login_frm);

		username = new TextInput();
		var username_fi = new FormItem("Username:", username);
		username_fi.required = true;
		username_fi.horizontalAlign = JUSTIFY;
		login_frm.addChild(username_fi);

		password = new TextInput();
		password.displayAsPassword = true;
		var password_fi = new FormItem("Password:", password);
		password_fi.required = true;
		password_fi.horizontalAlign = JUSTIFY;
		login_frm.addChild(password_fi);

		login_btn = new Button();
		login_btn.text = "Login";
		login_btn.addEventListener(TriggerEvent.TRIGGER, login_btn_triggerHandler);
		login_frm.addChild(login_btn);

		var footer = new LayoutGroup();
		footer.variant = LayoutGroup.VARIANT_TOOL_BAR;
		var instructions = new Label();
		instructions.text = "Username: Feathers   Password: PureMVC";
		instructions.wordWrap = true;
		instructions.layoutData = HorizontalLayoutData.fillHorizontal();
		footer.addChild(instructions);
		panel.footer = footer;
	}

	// mutate the loginBtn's click event into a cairngorm event
	private function loginEmployee():Void {
		// validate the fields
		var noUsername = username.text == null || username.text.length == 0;
		var noPassword = password.text == null || password.text.length == 0;
		if (noUsername || noPassword) {
			return;
		}

		username.enabled = false;
		password.enabled = false;

		// if everything validates, broadcast an event
		dispatchEvent(new Event(APP_LOGIN));
	}

	private function login_btn_triggerHandler(event:TriggerEvent):Void {
		loginEmployee();
	}
}
