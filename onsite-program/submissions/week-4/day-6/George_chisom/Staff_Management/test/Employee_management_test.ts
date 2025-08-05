import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("EmployeeManagement", function () {
  async function deployEmployeeManagement() {
    const [owner, otherAccount] = await hre.ethers.getSigners();

    const salary = 100000;

    const EmployeeManagement = await hre.ethers.getContractFactory(
      "EmployeeManagement"
    );

    const employeeManagement = await EmployeeManagement.deploy(
      owner.address,
      salary
    );

    return { employeeManagement, owner, otherAccount, salary };
  }

  describe("Register Employee", function () {
    it("This is to register an employee", async function () {
      const { employeeManagement, otherAccount } = await loadFixture(
        deployEmployeeManagement
      );

      const employeeName = "David James";
      const employeeRole = 1;

      await employeeManagement.register_employee(
        otherAccount.address,
        employeeName,
        employeeRole
      );

      const employee = await employeeManagement.get_all_employee();

      const get_employee_details = employee[0];

      expect(get_employee_details.name).to.equal(employeeName);
    });
  });

  describe("Update Salary", function () {
    it("This is to update employee salary", async function () {
      const { employeeManagement, otherAccount, salary } = await loadFixture(
        deployEmployeeManagement
      );

      const salary = await employeeManagement.update_salary(
        otherAccount.address,
        salary
      );

      await salary();

      expect(salary).to.equal(salary);
    });
  });
});
