/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton.model.vo;

class ResourceVO {
	public var proxyName:String;
	public var loaded:Bool;
	public var blockChain:Bool;

	public function new(proxyName:String, blockChain:Bool) {
		this.proxyName = proxyName;
		this.loaded = false;
		this.blockChain = blockChain;
	}
}
