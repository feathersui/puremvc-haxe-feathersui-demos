/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton.view;

import feathers.events.FeathersEvent;
import openfl.events.Event;
import org.puremvc.haxe.demos.feathersui.appskeleton.model.ConfigProxy;
import org.puremvc.haxe.demos.feathersui.appskeleton.model.LocaleProxy;
import org.puremvc.haxe.demos.feathersui.appskeleton.model.StartupMonitorProxy;
import org.puremvc.haxe.demos.feathersui.appskeleton.view.components.SplashScreen;
import org.puremvc.haxe.interfaces.IMediator;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.mediator.Mediator;

/**
	A Mediator for interacting with the SplashScreen component.
**/
class SplashScreenMediator extends Mediator implements IMediator {
	// Canonical name of the Mediator
	public static final NAME = "SplashScreenMediator";

	/**
		Constructor. 
	**/
	public function new(viewComponent:SplashScreen) {
		// pass the viewComponent to the superclass where
		// it will be stored in the inherited viewComponent property
		super(NAME, viewComponent);

		splashScreen.addEventListener(FeathersEvent.CREATION_COMPLETE, handleCreationComplete);
	}

	/**
		List all notifications this Mediator is interested in.

		Automatically called by the framework when the mediator
		is registered with the view.

		@return Array the list of Notification names
	**/
	override public function listNotificationInterests():Array<String> {
		return [
			StartupMonitorProxy.LOADING_STEP,
			StartupMonitorProxy.LOADING_COMPLETE,
			ConfigProxy.LOAD_FAILED,
			LocaleProxy.LOAD_FAILED
		];
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
			case StartupMonitorProxy.LOADING_STEP:
				// update the progress bar
				this.splashScreen.pb.value = cast(note.getBody(), Int);

			case StartupMonitorProxy.LOADING_COMPLETE:
				// all done
				// show the main screen
				this.sendNotification(ApplicationFacade.VIEW_MAIN_SCREEN);

			case ConfigProxy.LOAD_FAILED:
			case LocaleProxy.LOAD_FAILED:
				// error reading the config XML fille
				// show the error
				this.splashScreen.errorText.text = cast(note.getBody(), String);
				this.splashScreen.errorBox.visible = true;
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

		@return SplashScreen the viewComponent cast to org.puremvc.haxe.demos.feathersui.appskeleton.view.components.SplashScreen
	**/
	private var splashScreen(get, never):SplashScreen;

	private function get_splashScreen():SplashScreen {
		return cast(viewComponent, SplashScreen);
	}

	private function handleCreationComplete(event:Event):Void {
		// start to load the resources
		var startupMonitorProxy = cast(facade.retrieveProxy(StartupMonitorProxy.NAME), StartupMonitorProxy);
		startupMonitorProxy.loadResources();
	}
}
