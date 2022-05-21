/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton.model.helpers;

class XmlResource {
	public static function parse(data:Any, node:Xml, prefix:String = ""):Void {
		for (currentNode in node.elements()) {
			if (currentNode.nodeName == "param" || currentNode.nodeName == "item") {
				if (currentNode.exists("value")) {
					Reflect.setField(data, (prefix + currentNode.get("name")).toLowerCase(), currentNode.get("value"));
				} else {
					Reflect.setField(data, (prefix + currentNode.get("name")).toLowerCase(), currentNode.firstChild().nodeValue);
				}
			} else if (currentNode.nodeName == "group") {
				XmlResource.parse(data, currentNode, prefix + currentNode.get("name") + "/");
				continue;
			}
			XmlResource.parse(data, currentNode, prefix);
		}
	}
}
