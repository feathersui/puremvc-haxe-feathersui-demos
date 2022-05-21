/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton.view.components;

import feathers.skins.RectangleSkin;
import feathers.controls.Label;
import feathers.layout.HorizontalLayout;
import feathers.controls.HProgressBar;
import feathers.controls.AssetLoader;
import feathers.layout.VerticalLayout;
import openfl.events.Event;
import feathers.controls.LayoutGroup;

class SplashScreen extends LayoutGroup {
	public static final EFFECT_END:String = "splashScreenEffectEnd";

	public function new() {
		super();

		this.backgroundSkin = new RectangleSkin(SolidColor(0xffffff, 0));
	}

	public var pb:HProgressBar;
	public var errorBox:LayoutGroup;
	public var errorText:Label;

	public function effectEnd():Void {
		dispatchEvent(new Event(EFFECT_END));
	}

	override private function initialize():Void {
		super.initialize();

		var viewLayout = new VerticalLayout();
		viewLayout.gap = 10.0;
		viewLayout.horizontalAlign = CENTER;
		layout = viewLayout;

		var splashLoader = new AssetLoader("assets/img/splash.png");
		addChild(splashLoader);

		pb = new HProgressBar();
		pb.minimum = 0.0;
		pb.maximum = 100.0;
		pb.width = 300.0;
		addChild(pb);

		var errorLayout = new HorizontalLayout();
		errorLayout.gap = 8.0;
		errorBox = new LayoutGroup();
		errorBox.visible = false;
		addChild(errorBox);

		var errorLoader = new AssetLoader("assets/img/error.png");
		errorBox.addChild(errorLoader);

		errorText = new Label();
		errorBox.addChild(errorText);
	}
}
