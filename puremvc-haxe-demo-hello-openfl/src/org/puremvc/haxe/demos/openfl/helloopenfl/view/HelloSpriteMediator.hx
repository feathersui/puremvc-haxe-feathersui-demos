/*
	PureMVC Haxe Demo - Hello OpenFL
	Copyright (c) 2022 Bowler Hat LLC
	PureMVC AS3 / Flash Demo - HelloFlash
	By Cliff Hall <clifford.hall@puremvc.org>
	Copyright(c) 2007-08, Some rights reserved.
 */

package org.puremvc.haxe.demos.openfl.helloopenfl.view;

import openfl.events.Event;
import org.puremvc.haxe.demos.openfl.helloopenfl.ApplicationFacade;
import org.puremvc.haxe.demos.openfl.helloopenfl.model.SpriteDataProxy;
import org.puremvc.haxe.demos.openfl.helloopenfl.view.components.HelloSprite;
import org.puremvc.haxe.interfaces.IMediator;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.mediator.Mediator;

/**
	A Mediator for interacting with the HelloSprite.
**/
class HelloSpriteMediator extends Mediator implements IMediator {
	/**
		Constructor. 
	**/
	public function new(viewComponent:HelloSprite) {
		// pass the viewComponent to the superclass where
		// it will be stored in the inherited viewComponent property
		//
		// *** Note that the name of the mediator is the same as the
		// *** id of the HelloSprite it stewards. It does not use a
		// *** fixed 'NAME' constant as most single-use mediators do
		super(viewComponent.id, viewComponent);

		// Retrieve reference to frequently consulted Proxies
		spriteDataProxy = cast(facade.retrieveProxy(SpriteDataProxy.NAME), SpriteDataProxy);

		// Listen for events from the view component
		helloSprite.addEventListener(HelloSprite.SPRITE_DIVIDE, onSpriteDivide);
	}

	/**
		List all notifications this Mediator is interested in.

		Automatically called by the framework when the mediator
		is registered with the view.

		@return Array the list of Notification names
	**/
	override public function listNotificationInterests():Array<String> {
		return [ApplicationFacade.SPRITE_SCALE, ApplicationFacade.SPRITE_DROP];
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
			case ApplicationFacade.SPRITE_DROP:
				helloSprite.dropSprite();

			case ApplicationFacade.SPRITE_SCALE:
				var delta = (note.getBody() : Int);
				helloSprite.scaleSprite(delta);
		}
	}

	/**
		Sprite divide.

		User is dragging the sprite, send a notification to create a new sprite
		and pass the state the new sprite should inherit.
	**/
	private function onSpriteDivide(event:Event):Void {
		helloSprite.color = spriteDataProxy.nextSpriteColor(helloSprite.color);
		sendNotification(ApplicationFacade.STAGE_ADD_SPRITE, helloSprite.newSpriteState);
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

		@return app the viewComponent cast to HelloSprite
	**/
	private var helloSprite(get, never):HelloSprite;

	private function get_helloSprite():HelloSprite {
		return cast(viewComponent, HelloSprite);
	}

	private var spriteDataProxy:SpriteDataProxy;
}
