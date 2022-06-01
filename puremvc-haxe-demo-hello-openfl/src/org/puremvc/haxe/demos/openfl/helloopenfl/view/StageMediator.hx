/*
	PureMVC Haxe Demo - Hello OpenFL
	Copyright (c) 2022 Bowler Hat LLC
	PureMVC AS3 / Flash Demo - HelloFlash
	By Cliff Hall <clifford.hall@puremvc.org>
	Copyright(c) 2007-08, Some rights reserved.
 */

package org.puremvc.haxe.demos.openfl.helloopenfl.view;

import openfl.display.Stage;
import openfl.events.MouseEvent;
import org.puremvc.haxe.demos.openfl.helloopenfl.ApplicationFacade;
import org.puremvc.haxe.demos.openfl.helloopenfl.model.SpriteDataProxy;
import org.puremvc.haxe.demos.openfl.helloopenfl.view.components.HelloSprite;
import org.puremvc.haxe.interfaces.IMediator;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.mediator.Mediator;

/**
	A Mediator for interacting with the Stage.
**/
class StageMediator extends Mediator implements IMediator {
	// Canonical name of the Mediator
	public static final NAME = "StageMediator";

	/**
		Constructor. 

		@param object the viewComponent (the Stage instance in this case)
	**/
	public function new(viewComponent:Stage) {
		// pass the viewComponent to the superclass where
		// it will be stored in the inherited viewComponent property
		super(NAME, viewComponent);

		// Retrieve reference to frequently consulted Proxies
		spriteDataProxy = cast(facade.retrieveProxy(SpriteDataProxy.NAME), SpriteDataProxy);

		// Listen for events from the view component
		stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
		stage.addEventListener(MouseEvent.MOUSE_WHEEL, handleMouseWheel);
	}

	/**
		List all notifications this Mediator is interested in.

		Automatically called by the framework when the mediator
		is registered with the view.

		@return Array the list of Notification names
	**/
	override public function listNotificationInterests():Array<String> {
		return [ApplicationFacade.STAGE_ADD_SPRITE];
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
			// Create a new HelloSprite,
			// Create and register its HelloSpriteMediator
			// and finally add the HelloSprite to the stage
			case ApplicationFacade.STAGE_ADD_SPRITE:
				var params:Array<Int> = (note.getBody() : Array<Int>);
				var helloSprite = new HelloSprite(spriteDataProxy.nextSpriteID, params);
				helloSprite.xBound = stage.stageWidth;
				helloSprite.yBound = stage.stageHeight;
				facade.registerMediator(new HelloSpriteMediator(helloSprite));
				stage.addChild(helloSprite);
		}
	}

	// The user has released the mouse over the stage
	private function handleMouseUp(event:MouseEvent):Void {
		sendNotification(ApplicationFacade.SPRITE_DROP);
	}

	// The user has released the mouse over the stage
	private function handleMouseWheel(event:MouseEvent):Void {
		sendNotification(ApplicationFacade.SPRITE_SCALE, event.delta);
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

		@return app the viewComponent cast to Stage
	**/
	private var stage(get, never):Stage;

	private function get_stage():Stage {
		return cast(viewComponent, Stage);
	}

	private var spriteDataProxy:SpriteDataProxy;
}
