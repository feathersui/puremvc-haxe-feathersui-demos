/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

import org.puremvc.haxe.demos.feathersui.appskeleton.ApplicationFacade;
import feathers.events.FeathersEvent;
import org.puremvc.haxe.demos.feathersui.appskeleton.view.components.MainScreen;
import org.puremvc.haxe.demos.feathersui.appskeleton.view.components.SplashScreen;
import feathers.controls.navigators.StackItem;
import feathers.controls.navigators.StackNavigator;
import feathers.controls.Application;

class AppSkeleton extends Application {
	// available values for the main navigator
	// defined as contants to help uncover errors at compile time instead of run time
	public static final SCREEN_ID_SPLASH = "splashScreen";
	public static final SCREEN_ID_MAIN = "mainView";

	public function new() {
		super();
		this.addEventListener(FeathersEvent.CREATION_COMPLETE, event -> facade.startup(this));
	}

	private var facade = ApplicationFacade.getInstance();

	public var navigator:StackNavigator;
	public var splashScreen:SplashScreen;
	public var mainScreen:MainScreen;

	override private function initialize():Void {
		super.initialize();

		splashScreen = new SplashScreen();
		mainScreen = new MainScreen();

		navigator = new StackNavigator();
		navigator.pushTransition = null;
		navigator.popTransition = null;
		navigator.addItem(StackItem.withDisplayObject(SCREEN_ID_SPLASH, splashScreen));
		navigator.addItem(StackItem.withDisplayObject(SCREEN_ID_MAIN, mainScreen));
		addChild(navigator);
	}
}
