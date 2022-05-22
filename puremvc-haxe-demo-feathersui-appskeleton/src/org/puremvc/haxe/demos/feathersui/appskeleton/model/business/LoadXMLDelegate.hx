/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton.model.business;

import feathers.rpc.IResponder;
import feathers.rpc.http.HTTPService;

class LoadXMLDelegate {
	private var responder:IResponder;
	private var service:HTTPService;

	public function new(responder:IResponder, url:String) {
		// constructor will store a reference to the service we're going to call
		this.service = new HTTPService();
		this.service.resultFormat = HTTPService.RESULT_FORMAT_HAXE_XML;
		this.service.url = url;

		// and store a reference to the proxy that created this delegate
		this.responder = responder;
	}

	public function load():Void {
		// call the service
		var token = service.send();

		// notify this responder when the service call completes
		token.addResponder(responder);
	}
}
