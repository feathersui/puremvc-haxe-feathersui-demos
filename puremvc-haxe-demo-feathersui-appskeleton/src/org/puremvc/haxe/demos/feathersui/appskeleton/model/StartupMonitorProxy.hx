/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton.model;

import org.puremvc.haxe.demos.feathersui.appskeleton.model.vo.ResourceVO;
import org.puremvc.haxe.interfaces.IProxy;
import org.puremvc.haxe.patterns.proxy.Proxy;

/**
	A proxy for the startup loading process
	code based on Meekgeek suggestion
	http://forums.puremvc.org/index.php?topic=21.msg345#msg345
**/
class StartupMonitorProxy extends Proxy implements IProxy {
	public static final NAME = "StartupMonitorProxy"; // Proxy name

	// Notifications constants
	public static final LOADING_STEP = NAME + "loadingStep"; // Notification send when a resource il loaded
	public static final LOADING_COMPLETE = NAME + "loadingComplete"; // Notification send when all the resources are loaded

	private var resourceList:Array<ResourceVO>; // array for store all the resource to read
	private var totalResources = 0; // total resource to read
	private var loadedResources = 0; // number of loaded resources

	public function new(data:Any = null) {
		super(NAME, data);
		resourceList = new Array();
	}

	/**
		Add a resource to load

		@param name proxy name
		@param blockChain if the load process is stopped until this resource is loaded
	**/
	public function addResource(proxyName:String, blockChain:Bool = false):Void {
		resourceList.push(new ResourceVO(proxyName, blockChain));
	}

	/**
		Start to read all resources
	**/
	public function loadResources():Void {
		for (i in 0...resourceList.length) {
			var r = resourceList[i];
			if (!r.loaded) {
				var proxy = cast(facade.retrieveProxy(r.proxyName), IResourceProxy);
				proxy.load();

				// check if the loading process must be stopped until the resource is loaded
				if (r.blockChain) {
					break;
				}
			}
		}
	}

	/**
		The resource is loaded, update the state anche check if the loading process is completed

		@param name proxy name
	**/
	public function resourceComplete(proxyName:String):Void {
		for (i in 0...resourceList.length) {
			var r = resourceList[i];
			if (r.proxyName == proxyName) {
				r.loaded = true;
				loadedResources++;
				// send the notification for update the progress bar
				sendNotification(StartupMonitorProxy.LOADING_STEP, (loadedResources * 100.0) / resourceList.length);
				// check if the process is completed
				// if is not completed and the resources have blocked the process chain
				// continue to read the other resources
				if (!checkResources() && r.blockChain) {
					loadResources();
				}
				break;
			}
		}
	}

	/**
		Check if the loading process is completed

		@return boolean process is completed
	**/
	private function checkResources():Bool {
		for (i in 0...resourceList.length) {
			var r = resourceList[i];
			if (!r.loaded) {
				return false;
			}
		}
		sendNotification(StartupMonitorProxy.LOADING_COMPLETE);
		return true;
	}
}
