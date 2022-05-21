/*
	PureMVC Haxe Demo - Feathers UI Application Skeleton 
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.appskeleton.model.enums;

enum abstract ConfigKeyEnum(String) to String from String {
	var TEST_DEFAULT_VALUE = "testDefaultValue";
	var KEY_NAME = "keyName";
	var OTHER_KEY_NAME = "otherKeyName";
	var NUMBER_TEST = "numberTest";
	var BOOLEAN_TEST = "booleanTest";
	var KEY_INSIDE_GROUP = "keyNameInsideGroup";
	var KEY_INSIDE_SUBGROUP = "keyNameInsideSubGroup";
	var GROUP_NAME = "groupName";
	var SUBGROUP_NAME = "subGroupName";
}
