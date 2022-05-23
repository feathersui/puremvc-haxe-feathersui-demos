/*
	PureMVC Haxe Demo - Feathers UI Cafe Townsend
	Copyright (c) 2022 Bowler Hat LLC
	Copyright (c) 2007-08 Michael Ramirez <michael.ramirez@puremvc.org>
	Parts Copyright (c) 2005-07 Adobe Systems, Inc. 
	Your reuse is governed by the Creative Commons Attribution 3.0 License
 */

package org.puremvc.haxe.demos.feathersui.cafetownsend.model;

import feathers.data.ArrayCollection;
import feathers.rpc.IResponder;
import feathers.rpc.events.ResultEvent;
import org.puremvc.haxe.demos.feathersui.cafetownsend.model.business.LoadEmployeesDelegate;
import org.puremvc.haxe.demos.feathersui.cafetownsend.model.vo.Employee;
import org.puremvc.haxe.interfaces.IProxy;
import org.puremvc.haxe.patterns.proxy.Proxy;

/**
	A proxy for the Employee data
**/
class EmployeeProxy extends Proxy implements IProxy implements IResponder {
	public static final NAME = "EmployeeProxy";

	public function new(data:Any = null) {
		super(NAME, data);
	}

	public function loadEmployees():Void {
		// create a worker who will go get some data
		// pass it a reference to this proxy so the delegate knows where to return the data
		var delegate = new LoadEmployeesDelegate(this);
		// make the delegate do some work
		delegate.loadEmployeesService();
	}

	// this is called when the delegate receives a result from the service
	public function result(rpcEvent:Dynamic):Void {
		// populate the employee list in the proxy with the results from the service call
		var xmlData:Xml = cast(rpcEvent, ResultEvent).result;
		var employees:Array<Employee> = [];
		for (employeeXml in xmlData.firstElement().elementsNamed("employee")) {
			var emp_id = Std.parseInt(employeeXml.elementsNamed("emp_id").next().firstChild().nodeValue);
			var firstname = employeeXml.elementsNamed("firstname").next().firstChild().nodeValue;
			var lastname = employeeXml.elementsNamed("lastname").next().firstChild().nodeValue;
			var email = employeeXml.elementsNamed("email").next().firstChild().nodeValue;
			var startdate = Date.fromString(employeeXml.elementsNamed("startdate").next().firstChild().nodeValue);
			var employee = new Employee(emp_id, firstname, lastname, email, startdate);
			employees.push(employee);
		}
		data = new ArrayCollection(employees);
		sendNotification(ApplicationFacade.LOAD_EMPLOYEES_SUCCESS);
	}

	// this is called when the delegate receives a fault from the service
	public function fault(rpcEvent:Dynamic):Void {
		data = new ArrayCollection();
		// store an error message in the proxy
		// labels, alerts, etc can bind to this to notify the user of errors
		errorStatus = "Could Not Load Employee List!";
		sendNotification(ApplicationFacade.LOAD_EMPLOYEES_FAILED);
	}

	public function saveEmployee():Void {
		// assume the edited fields are not an existing employee, but a new employee
		// and set the ArrayCollection index to -1, which means this employee is not in our existing
		// employee list anywhere
		var dpIndex = -1;
		// loop thru the employee list
		for (i in 0...employeeListDP.length) {
			// if the emp_id of the incoming employee matches an employee already in the list
			if (employeeListDP.get(i).emp_id == employee.emp_id) {
				// set our ArrayCollection index to that employee position
				dpIndex = i;
			}
		}
		// if it was an existing employee already in the ArrayCollection
		if (dpIndex >= 0) {
			// update that employee's values
			employeeListDP.set(dpIndex, employee);
		}
		// otherwise, if it didn't match any existing employees
		else {
			// add the temp employee to the ArrayCollection
			employeeListDP.add(employee);
		}
	}

	public function deleteEmployee():Void {
		if (employee != null) {
			for (i in 0...employeeListDP.length) {
				// if the emp_id stored in the temp employee matches one of the emp_id's in the employee list
				if (employee.emp_id == employeeListDP.get(i).emp_id) {
					// remove that item from the ArrayCollection
					employeeListDP.removeAt(i);
					break;
				}
			}
		}
	}

	public var employeeListDP(get, never):ArrayCollection<Employee>;

	private function get_employeeListDP():ArrayCollection<Employee> {
		return (data : ArrayCollection<Employee>);
	}

	public var employee:Employee = new Employee();
	public var errorStatus:String;
}
