/*
	PureMVC Haxe Demo - Hello OpenFL
	Copyright (c) 2022 Bowler Hat LLC
	PureMVC AS3 / Flash Demo - HelloFlash
	By Cliff Hall <clifford.hall@puremvc.org>
	Copyright(c) 2007-08, Some rights reserved.
 */

package org.puremvc.haxe.demos.openfl.helloopenfl.model;

import org.puremvc.haxe.patterns.proxy.Proxy;

class SpriteDataProxy extends Proxy {
	public static final NAME = "SpriteDataProxy"; // Proxy name

	public function new() {
		super(NAME, 0);
		palette = [blue, red, yellow, green, cyan];
	}

	private var palette:Array<UInt>;
	private var red:UInt = 0xFF0000;
	private var green:UInt = 0x00FF00;
	private var blue:UInt = 0x0000FF;
	private var yellow:UInt = 0xFFFF00;
	private var cyan:UInt = 0x00FFFF;

	public function nextSpriteColor(startColor:UInt):UInt {
		// identify color index
		var index = 0;
		for (j in 0...palette.length) {
			index = j;
			if (startColor == palette[index])
				break;
		}

		// select the next color in the palette
		index = (index == palette.length - 1) ? 0 : index + 1;
		// return startColor;
		return palette[index];
	}

	/**
	 * Get the next Sprite ID
	 */
	public var nextSpriteID(get, never):String;

	private function get_nextSpriteID():String {
		return "sprite" + spriteCount++;
	}

	/**
	 * Get the number of sprites
	 */
	public var spriteCount(get, set):Int;

	private function get_spriteCount():Int {
		return (data : Int);
	}

	private function set_spriteCount(count:Int):Int {
		data = count;
		return data;
	}
}
