/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton.model;

import feathers.rpc.IResponder;
import feathers.rpc.events.ResultEvent;
import org.puremvc.haxe.demos.feathersui.appskeleton.model.business.LoadXMLDelegate;
import org.puremvc.haxe.demos.feathersui.appskeleton.model.helpers.XmlResource;
import org.puremvc.haxe.patterns.proxy.Proxy;

/**
	A proxy for read the resource file
**/
class LocaleProxy extends Proxy implements IResourceProxy implements IResponder {
	public static final NAME = "LocaleProxy"; // Proxy name

	// Notifications constants
	public static final LOAD_SUCCESSFUL = NAME + "loadSuccessful"; // Successful notification
	public static final LOAD_FAILED = NAME + "loadFailed"; // Failed notification

	// Messages
	public static final ERROR_LOAD_FILE = "Could Not Load the Config File!"; // Error message

	private var startupMonitorProxy:StartupMonitorProxy; // StartupMonitorProxy instance

	public function new(data:Any = null) {
		super(NAME, data);
	}

	override public function onRegister():Void {
		// retrieve the StartupMonitorProxy
		startupMonitorProxy = cast(facade.retrieveProxy(StartupMonitorProxy.NAME), StartupMonitorProxy);
		// add the resource to load
		startupMonitorProxy.addResource(LocaleProxy.NAME, true);

		// reset the data
		setData({});
	}

	/**
		Load the xml file, this method is called by StartupMonitorProxy
	**/
	public function load():Void {
		var configProxy = cast(facade.retrieveProxy(ConfigProxy.NAME), ConfigProxy);
		var language = configProxy.getValue("language");

		// check if the language is defined
		if (language != null && language != "") {
			var url = 'assets/data/${configProxy.getValue("language")}.xml';

			// create a worker who will go get some data
			// pass it a reference to this proxy so the delegate knows where to return the data
			var delegate = new LoadXMLDelegate(this, url);
			// make the delegate do some work
			delegate.load();
		} else {
			resourceLoaded();
		}
	}

	/**
		This is called when the delegate receives a result from the service

		@param rpcEvent
	**/
	public function result(rpcEvent:Dynamic):Void {
		// call the helper class for parse the XML data
		XmlResource.parse(data, cast(rpcEvent, ResultEvent).result);

		resourceLoaded();
	}

	/**
		This is called when the delegate receives a fault from the service

		@param rpcEvent
	**/
	public function fault(rpcEvent:Dynamic):Void {
		// send the failed notification
		sendNotification(LocaleProxy.LOAD_FAILED, LocaleProxy.ERROR_LOAD_FILE);
	}

	/**
		Get the localized text

		@param key the key to read 
		@return String the text value stored in internal object
	**/
	public function getText(key:String):String {
		return Reflect.field(data, key.toLowerCase());
	}

	/**
		Send the notifications when the resource is loaded
	**/
	private function resourceLoaded():Void {
		// call the StartupMonitorProxy for notify that the resource is loaded
		startupMonitorProxy.resourceComplete(LocaleProxy.NAME);

		// send the successful notification
		sendNotification(ConfigProxy.LOAD_SUCCESSFUL);
	}
}
