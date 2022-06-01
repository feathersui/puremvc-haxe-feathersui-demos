/*
	PureMVC Haxe Demo - Hello OpenFL
	Copyright (c) 2022 Bowler Hat LLC
	PureMVC AS3 / Flash Demo - HelloFlash
	By Cliff Hall <clifford.hall@puremvc.org>
	Copyright(c) 2007-08, Some rights reserved.
 */

import openfl.display.Sprite;
import org.puremvc.haxe.demos.openfl.helloopenfl.ApplicationFacade;

class HelloOpenFL extends Sprite {
	public function new() {
		super();
		ApplicationFacade.getInstance().startup(this.stage);
	}
}
