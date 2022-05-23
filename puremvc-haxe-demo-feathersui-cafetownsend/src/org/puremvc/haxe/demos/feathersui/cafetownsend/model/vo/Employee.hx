/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.cafetownsend.model.vo;

class Employee {
	public var emp_id:UInt;
	public var firstname:String;
	public var lastname:String;
	public var email:String;
	public var startdate:Date;

	static public var currentIndex:UInt = 1000;

	public function new(emp_id:UInt = 0, firstname:String = "", lastname:String = "", email:String = "", startdate:Date = null) {
		this.emp_id = (emp_id == 0) ? currentIndex += 1 : emp_id;
		this.firstname = firstname;
		this.lastname = lastname;
		this.email = email;
		this.startdate = (startdate == null) ? Date.now() : startdate;
	}
}
