/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.cafetownsend.model;

import org.puremvc.haxe.demos.feathersui.cafetownsend.model.vo.User;
import org.puremvc.haxe.interfaces.IProxy;
import org.puremvc.haxe.patterns.proxy.Proxy;

/**
	A proxy for the User data
**/
class UserProxy extends Proxy implements IProxy {
	public static final NAME = "UserProxy";

	public function new(data:Any = null) {
		super(NAME, data);
	}

	public function validate(username:String, password:String):Bool {
		if (username == "Feathers" && password == "PureMVC") {
			data = new User(username, password);
			return true;
		} else {
			return false;
		}
	}

	public var user(get, never):User;

	private function get_user():User {
		return cast(data, User);
	}
}
