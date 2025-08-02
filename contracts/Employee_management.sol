// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.28;

import "../interface/Employee_interface.sol";

contract EmployeeManagement is iEmployee_Management {

    Employee[] public EmployeeList;

    mapping(address => Employee) public Employees;


    address owner;

    uint256 private uniqueId;
    uint256 public amount;

    constructor() {
        owner = msg.sender;
    }

    error Access_Denied();
    error DONT_PAY();

    // function to register_employee
    function register_employee (string memory _name, address _employeeAddress, Role _role) external {
        uniqueId = uniqueId + 1;
        amount = 100000;
        
        Employee memory _newEmployee = Employee(uniqueId, _employeeAddress, _name, _role, Status.Employed, amount);

        EmployeeList.push(_newEmployee);
        Employees[msg.sender] = _newEmployee;
    }

    function update_salary(address _employeeAddress) external view returns (uint256 salary) {
        
        uint256 managerAmount = 200000;
        uint256 NonAcademicStaffAmount = 100000;
        uint256 AcademicStaffAmount = 150000;
        
        Employee memory employee = Employees[_employeeAddress];

        if (employee.status == Status.Employed) {
            return employee.salary;
        }

        if (employee.role == Role.Managers) {
            return employee.salary = managerAmount;
        }

        if (employee.role == Role.NonAcademicStaff) {
            return employee.salary = NonAcademicStaffAmount;
        }

        if (employee.role == Role.AcademicStaff) {
            return employee.salary = AcademicStaffAmount;
        }

        revert DONT_PAY();
    }

    function pay_salary(address payable _to, uint256 _amount) external {
        
        if (owner != msg.sender) {
            revert Access_Denied();
        }
        Employee memory employee = Employees[_to];

        if (employee.status == Status.Employed) {
            _to.transfer(_amount);
        }
        revert DONT_PAY();
    }

    function view_employee(address _employeeAddress) external view returns (Employee memory) {
        Employee memory employee = Employees[_employeeAddress];
        return employee;
    }

    
    
}