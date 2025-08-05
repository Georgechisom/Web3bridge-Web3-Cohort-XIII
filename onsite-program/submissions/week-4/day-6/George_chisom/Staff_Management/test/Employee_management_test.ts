import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("EmployeeManagement", function () {
  async function deployEmployeeManagement() {
    const salary = 100000;

    const [admin, otherAccount] = await hre.ethers.getSigners();

    const EmployeeManagement = await hre.ethers.getContractFactory(
      "EmployeeManagement"
    );

    const employeeManagement = await EmployeeManagement.deploy();

    return { employeeManagement, admin, otherAccount, salary };
  }

  describe("Register Employee", function () {
    it("This is to register an employee", async function () {
      const { employeeManagement, otherAccount } = await loadFixture(
        deployEmployeeManagement
      );

      const employeeName = "David James";
      const employeeRole = 2;

      await employeeManagement.register_employee(
        employeeName,
        otherAccount.address,
        employeeRole
      );

      const employee = await employeeManagement.get_all_employee();

      const get_employee_details = employee[0];

      expect(get_employee_details.name).to.equal(employeeName);
    });
  });

  describe("Update Salary", function () {
    it("This is to update employee salary", async function () {
      const { employeeManagement, otherAccount } = await loadFixture(
        deployEmployeeManagement
      );

      const updatedSalary = await employeeManagement.update_salary(
        otherAccount.address
      );

      const employee = await employeeManagement.get_all_employee();

      const get_employee_details = employee[0];

      expect(updatedSalary).to.equal(get_employee_details.salary);
    });
  });
});
