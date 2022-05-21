/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton.model.business;

import openfl.Assets;
import openfl.events.ErrorEvent;

class LoadXMLDelegate {
	private var resultCallback:(Xml) -> Void;
	private var faultCallback:(Dynamic) -> Void;
	private var assetID:String;

	public function new(resultCallback:(Xml) -> Void, faultCallback:(ErrorEvent) -> Void, assetID:String) {
		// store a reference to the proxy that created this delegate
		this.resultCallback = resultCallback;
		this.faultCallback = faultCallback;

		this.assetID = assetID;
	}

	public function load():Void {
		// call the service
		Assets.loadText(assetID).onComplete(resultText -> {
			var result:Xml = null;
			try {
				result = Xml.parse(resultText);
			} catch (e:Dynamic) {
				faultCallback(e);
				return;
			}
			resultCallback(result);
		}).onError(fault -> {
			faultCallback(fault);
		});
	}
}
