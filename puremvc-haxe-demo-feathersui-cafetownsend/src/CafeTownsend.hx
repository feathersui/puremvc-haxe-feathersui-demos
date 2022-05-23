/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

import feathers.controls.Application;
import feathers.controls.navigators.StackItem;
import feathers.controls.navigators.StackNavigator;
import feathers.events.FeathersEvent;
import feathers.motion.transitions.FadeTransitionBuilder;
import org.puremvc.haxe.demos.feathersui.cafetownsend.ApplicationFacade;
import org.puremvc.haxe.demos.feathersui.cafetownsend.view.components.EmployeeDetail;
import org.puremvc.haxe.demos.feathersui.cafetownsend.view.components.EmployeeList;
import org.puremvc.haxe.demos.feathersui.cafetownsend.view.components.EmployeeLogin;

class CafeTownsend extends Application {
	// available values for the main navigator
	// defined as contants to help uncover errors at compile time instead of run time
	public static final SCREEN_ID_EMPLOYEE_LOGIN = "employeeLogin";
	public static final SCREEN_ID_EMPLOYEE_LIST = "employeeList";
	public static final SCREEN_ID_EMPLOYEE_DETAIL = "employeeDetail";

	public function new() {
		super();
		this.addEventListener(FeathersEvent.CREATION_COMPLETE, event -> facade.startup(this));
	}

	private var facade = ApplicationFacade.getInstance();

	public var navigator:StackNavigator;
	public var employeeLogin:EmployeeLogin;
	public var employeeList:EmployeeList;
	public var employeeDetail:EmployeeDetail;

	override private function initialize():Void {
		super.initialize();

		employeeLogin = new EmployeeLogin();
		employeeLogin.initializeNow();
		employeeList = new EmployeeList();
		employeeList.initializeNow();
		employeeDetail = new EmployeeDetail();
		employeeDetail.initializeNow();

		navigator = new StackNavigator();
		navigator.addItem(StackItem.withDisplayObject(SCREEN_ID_EMPLOYEE_LOGIN, employeeLogin));
		navigator.addItem(StackItem.withDisplayObject(SCREEN_ID_EMPLOYEE_LIST, employeeList));
		navigator.addItem(StackItem.withDisplayObject(SCREEN_ID_EMPLOYEE_DETAIL, employeeDetail));
		navigator.pushTransition = null;
		navigator.popTransition = null;
		navigator.replaceTransition = new FadeTransitionBuilder().build();
		addChild(navigator);
	}
}
