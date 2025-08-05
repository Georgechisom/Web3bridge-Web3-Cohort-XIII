// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.28;

contract EmployeeManagement {
    enum Role { Managers, NonAcademicStaff, AcademicStaff }
    enum Status { Employed, Unemployed, Probation }

    struct Employee {
        uint uid;
        address employeeAddress;
        string name;
        Role role;
        Status status;
        uint256 salary;
    }

    Employee[] public EmployeeList;
 
    address owner;

    mapping(address => Employee) public Employees;

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

    function update_salary(address _employeeAddress) external view {
        uint256 managerAmount = 200000;
        uint256 NonAcademicStaff = 100000;
        uint256 AcademicStaff = 150000;
        
        Employee memory employee = Employees[_employeeAddress];

        if (employee.role == Role.Managers){
            employee.salary == managerAmount;
        } else if (employee.role == Role.NonAcademicStaff){
            employee.salary == NonAcademicStaff;
        } else {
            employee.salary == AcademicStaff;
        }
    }

    function pay_salary(address payable _to, uint256 _amount, address _employeeAddress) external {
        
        Employee memory employee = Employees[_employeeAddress];

        if (owner != msg.sender) {
            revert DONT_PAY();
        }if (employee.status == Status.Employed){
            _to.transfer(_amount);
        } else if (employee.status == Status.Unemployed){
            revert DONT_PAY();
        } else if (employee.status == Status.Probation){
            revert DONT_PAY();
        }
    }

    // function get_employee(address _employeeAddress) external view returns (Employee memory) {
    //     return Employees[_employeeAddress];
    // }

    function get_all_employee() external view returns (Employee[] memory) {
        return EmployeeList;
    }

    
    
}