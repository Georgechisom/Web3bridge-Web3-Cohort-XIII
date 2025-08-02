// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.28;

interface iEmployee_Management {
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

    function register_employee (string memory _name, address _employeeAddress, Role _role) external;
    function update_salary(address _employeeAddress) external view returns (uint256 salary);
    function pay_salary(address payable _to, uint256 _amount) external;
    function view_employee(address _employeeAddress) external view returns (Employee memory);
}