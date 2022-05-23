/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.cafetownsend.model.business;

import feathers.rpc.IResponder;
import feathers.rpc.http.HTTPService;

class LoadEmployeesDelegate {
	private var responder:IResponder;
	private var service:HTTPService;

	public function new(responder:IResponder) {
		// constructor will store a reference to the service we're going to call
		this.service = new HTTPService();
		this.service.resultFormat = HTTPService.RESULT_FORMAT_HAXE_XML;
		this.service.url = "assets/Employees.xml";

		// and store a reference to the proxy that created this delegate
		this.responder = responder;
	}

	public function loadEmployeesService():Void {
		// call the service
		var token = service.send();

		// notify this responder when the service call completes
		token.addResponder(responder);
	}
}
