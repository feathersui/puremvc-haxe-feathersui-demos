/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton.view;

import feathers.motion.transitions.FadeTransitionBuilder;
import feathers.motion.transitions.SlideTransitionBuilder;
import org.puremvc.haxe.interfaces.IMediator;
import org.puremvc.haxe.interfaces.INotification;
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
	public function new(viewComponent:AppSkeleton) {
		// pass the viewComponent to the superclass where
		// it will be stored in the inherited viewComponent property
		super(NAME, viewComponent);
	}

	override public function onRegister():Void {
		// Create and register Mediators
		// components that were instantiated by the mxml application
		facade.registerMediator(new SplashScreenMediator(app.splashScreen));
		facade.registerMediator(new MainScreenMediator(app.mainScreen));
	}

	/**
		List all notifications this Mediator is interested in.

		Automatically called by the framework when the mediator
		is registered with the view.

		@return Array the list of Notification names
	**/
	override public function listNotificationInterests():Array<String> {
		return [ApplicationFacade.VIEW_SPLASH_SCREEN, ApplicationFacade.VIEW_MAIN_SCREEN];
	}

	/**
		Handle all notifications this Mediator is interested in.

		Called by the framework when a notification is sent that
		this mediator expressed an interest in when registered
		(see `listNotificationInterests`).

		@param INotification a notification 
	**/
	override public function handleNotification(note:INotification):Void {
		switch (note.getName()) {
			case ApplicationFacade.VIEW_SPLASH_SCREEN:
				app.navigator.popToRootItemAndReplace(AppSkeleton.SCREEN_ID_SPLASH, null, new SlideTransitionBuilder().setLeft().build());

			case ApplicationFacade.VIEW_MAIN_SCREEN:
				app.navigator.popToRootItemAndReplace(AppSkeleton.SCREEN_ID_MAIN, new FadeTransitionBuilder().setFadeIn(true).build());
		}
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

		@return app the viewComponent cast to AppSkeleton
	**/
	private var app(get, never):AppSkeleton;

	private function get_app():AppSkeleton {
		return cast(viewComponent, AppSkeleton);
	}
}
