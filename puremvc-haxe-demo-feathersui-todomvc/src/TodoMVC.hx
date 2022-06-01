/*
	PureMVC Haxe Demo - Feathers UI TodoMVC
	Copyright (c) 2022 Bowler Hat LLC
 */

import feathers.controls.Application;
import feathers.events.FeathersEvent;
import feathers.style.Theme;
import org.puremvc.haxe.demos.feathersui.todomvc.ApplicationFacade;
import org.puremvc.haxe.demos.feathersui.todomvc.theme.TodoTheme;
import org.puremvc.haxe.demos.feathersui.todomvc.view.components.MainView;

class TodoMVC extends Application {
	public function new() {
		Theme.setTheme(new TodoTheme());
		super();
		this.addEventListener(FeathersEvent.CREATION_COMPLETE, event -> facade.startup(this));
	}

	public var mainView:MainView;

	private var facade = ApplicationFacade.getInstance();

	override private function initialize():Void {
		super.initialize();
		this.mainView = new MainView();
		this.addChild(this.mainView);
	}
}
