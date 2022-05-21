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
import org.puremvc.haxe.demos.feathersui.appskeleton.model.enums.ConfigKeyEnum;
import org.puremvc.haxe.demos.feathersui.appskeleton.model.enums.LocaleKeyEnum;
import org.puremvc.haxe.demos.feathersui.appskeleton.view.components.MainScreen;
import org.puremvc.haxe.interfaces.IMediator;
import org.puremvc.haxe.patterns.mediator.Mediator;

/**
	A Mediator for interacting with the MainScreen component.
**/
class MainScreenMediator extends Mediator implements IMediator {
	// Canonical name of the Mediator
	public static final NAME = "MainScreenMediator";

	private var configProxy:ConfigProxy;
	private var localeProxy:LocaleProxy;

	/**
	 * Constructor. 
	 */
	public function new(viewComponent:MainScreen) {
		// pass the viewComponent to the superclass where
		// it will be stored in the inherited viewComponent property
		super(NAME, viewComponent);
	}

	override public function onRegister():Void {
		// retrieve the proxies
		configProxy = cast(facade.retrieveProxy(ConfigProxy.NAME), ConfigProxy);
		localeProxy = cast(facade.retrieveProxy(LocaleProxy.NAME), LocaleProxy);

		mainScreen.addEventListener(FeathersEvent.CREATION_COMPLETE, handleCreationComplete);
	}

	/**
	 * Cast the viewComponent to its actual type.
	 * 
	 * <P>
	 * This is a useful idiom for mediators. The
	 * PureMVC Mediator class defines a viewComponent
	 * property of type Object. </P>
	 * 
	 * <P>
	 * Here, we cast the generic viewComponent to 
	 * its actual type in a protected mode. This 
	 * retains encapsulation, while allowing the instance
	 * (and subclassed instance) access to a 
	 * strongly typed reference with a meaningful
	 * name.</P>
	 * 
	 * @return MainScreen the viewComponent cast to org.puremvc.as3.demos.flex.appskeleton.view.components.MainScreen
	 */
	private var mainScreen(get, never):MainScreen;

	private function get_mainScreen():MainScreen {
		return cast(viewComponent, MainScreen);
	}

	/*********************************/
	/* events handler 				 */
	/*********************************/
	private function handleCreationComplete(event:Event):Void {
		mainScreen.myText1 = localeProxy.getText(LocaleKeyEnum.HOW_TO_READ_CONFIG_VALUES);

		var myHtmlText = "";
		myHtmlText += '<b>simple value:</b> configProxy.getValue( ConfigKeyEnum.KEY_NAME ) = ${configProxy.getValue(ConfigKeyEnum.OTHER_KEY_NAME)}<br><br>';
		myHtmlText += '<b>long text value:</b> configProxy.getValue( ConfigKeyEnum.OTHER_KEY_NAME ) = ${configProxy.getValue(ConfigKeyEnum.OTHER_KEY_NAME)}<br><br>';
		myHtmlText += '<b>number value:</b> configProxy.getNumber( ConfigKeyEnum.NUMBER_TEST ) = ${configProxy.getNumber(ConfigKeyEnum.NUMBER_TEST)}<br><br>';
		myHtmlText += '<b>boolean value:</b> configProxy.getBoolean( ConfigKeyEnum.BOOLEAN_TEST ) = ${configProxy.getBoolean(ConfigKeyEnum.BOOLEAN_TEST)}<br><br>';
		myHtmlText += '<b>default value:</b> configProxy.getValue( ConfigKeyEnum.TEST_DEFAULT_VALUE ) = ${configProxy.getValue(ConfigKeyEnum.TEST_DEFAULT_VALUE)}<br><br>';
		myHtmlText += '<b>value inside a group:</b> configProxy.getValue( ConfigKeyEnum.GROUP_NAME + ConfigProxy.SEPARATOR + ConfigKeyEnum.KEY_INSIDE_GROUP ) = ${configProxy.getValue(ConfigKeyEnum.GROUP_NAME + ConfigProxy.SEPARATOR + ConfigKeyEnum.KEY_INSIDE_GROUP)}<br><br>';
		myHtmlText += '<b>value inside neested group:</b> configProxy.getValue( ConfigKeyEnum.GROUP_NAME + ConfigProxy.SEPARATOR + ConfigKeyEnum.SUBGROUP_NAME + ConfigProxy.SEPARATOR + ConfigKeyEnum.KEY_INSIDE_SUBGROUP  ) = ${configProxy.getValue(ConfigKeyEnum.GROUP_NAME + ConfigProxy.SEPARATOR + ConfigKeyEnum.SUBGROUP_NAME + ConfigProxy.SEPARATOR + ConfigKeyEnum.KEY_INSIDE_SUBGROUP)}<br><br>';
		mainScreen.myText2 = myHtmlText;

		mainScreen.myText3 = localeProxy.getText(LocaleKeyEnum.HOW_TO_READ_LOCALE_TEXT);

		var myHtmlLocaleText = "";
		myHtmlLocaleText += '<b>simple text resource:</b> localeProxy.getText( LocaleKeyEnum.HELLO_WORLD ) = ${localeProxy.getText(LocaleKeyEnum.HELLO_WORLD)}<br><br>';
		myHtmlLocaleText += '<b>long text resource:</b> localeProxy.getText( LocaleKeyEnum.LONG_TEXT ) = ${localeProxy.getText(LocaleKeyEnum.LONG_TEXT)}<br>';
		mainScreen.myText4 = myHtmlLocaleText;
	}
}
