/*
	PureMVC Haxe Demo - Feathers UI TodoMVC
	Copyright (c) 2022 Bowler Hat LLC
 */

package org.puremvc.haxe.demos.feathersui.todomvc.view;

import org.puremvc.haxe.interfaces.IMediator;
import org.puremvc.haxe.patterns.mediator.Mediator;

/**
	A Mediator for interacting with the top level Application.

	In addition to the ordinary responsibilities of a mediator
	the MXML application (in this case) built all the view components
	and so has a direct reference to them internally. Therefore
	we create and register the mediators for each view component
	with an associated mediator here.

	Then, ongoing responsibilities are: 

	- listening for events from the viewComponent (the application)
	sending notifications on behalf of or as a result of these 
	events or other notifications.
	- direct manipulating of the viewComponent by method invocation
	or property setting
**/
class ApplicationMediator extends Mediator implements IMediator {
	// Canonical name of the Mediator
	public static final NAME = "ApplicationMediator";

	/**
		Constructor. 

		On `applicationComplete` in the `Application`,
		the `ApplicationFacade` is initialized and the 
		`ApplicationMediator` is created and registered.

		The `ApplicationMediator` constructor also registers the 
		Mediators for the view components created by the application.

		@param object the viewComponent (the AppSkeleton instance in this case)
	**/
	public function new(viewComponent:TodoMVC) {
		// pass the viewComponent to the superclass where
		// it will be stored in the inherited viewComponent property
		super(NAME, viewComponent);
	}

	override public function onRegister():Void {
		// Create and register Mediators
		// components that were instantiated by the mxml application
		facade.registerMediator(new MainViewMediator(app.mainView));
	}

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

		@return app the viewComponent cast to TodoMVC
	**/
	private var app(get, never):TodoMVC;

	private function get_app():TodoMVC {
		return cast(viewComponent, TodoMVC);
	}
}
