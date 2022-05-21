/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton.view.components;

import feathers.layout.VerticalLayout;
import feathers.layout.VerticalLayoutData;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;

class MainScreen extends LayoutGroup {
	public function new() {
		super();
	}

	private var label1:Label;
	private var label2:Label;
	private var label3:Label;
	private var label4:Label;

	public var myText1(default, set):String = "";

	private function set_myText1(value:String):String {
		if (myText1 == value) {
			return myText1;
		}
		myText1 = value;
		setInvalid(DATA);
		return myText1;
	}

	public var myText2(default, set):String = "";

	private function set_myText2(value:String):String {
		if (myText2 == value) {
			return myText2;
		}
		myText2 = value;
		setInvalid(DATA);
		return myText2;
	}

	public var myText3(default, set):String = "";

	private function set_myText3(value:String):String {
		if (myText3 == value) {
			return myText3;
		}
		myText3 = value;
		setInvalid(DATA);
		return myText3;
	}

	public var myText4(default, set):String = "";

	private function set_myText4(value:String):String {
		if (myText4 == value) {
			return myText4;
		}
		myText4 = value;
		setInvalid(DATA);
		return myText4;
	}

	override private function initialize():Void {
		super.initialize();

		var viewLayout = new VerticalLayout();
		viewLayout.gap = 10.0;
		viewLayout.horizontalAlign = CENTER;
		layout = viewLayout;

		label1 = new Label();
		label1.layoutData = VerticalLayoutData.fillHorizontal(90.0);
		addChild(label1);

		label2 = new Label();
		label2.wordWrap = true;
		label2.layoutData = VerticalLayoutData.fillHorizontal(90.0);
		addChild(label2);

		label3 = new Label();
		label3.layoutData = VerticalLayoutData.fillHorizontal(90.0);
		addChild(label3);

		label4 = new Label();
		label4.wordWrap = true;
		label4.layoutData = VerticalLayoutData.fillHorizontal(90.0);
		addChild(label4);
	}

	override private function update():Void {
		var dataInvalid = isInvalid(DATA);

		if (dataInvalid) {
			label1.text = myText1;
			label2.htmlText = myText2;
			label3.text = myText3;
			label4.htmlText = myText4;
		}

		super.update();
	}
}
