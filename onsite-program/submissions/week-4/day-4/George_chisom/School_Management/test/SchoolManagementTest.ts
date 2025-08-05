import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("SchoolManagement", function () {
  async function deploySchoolManagement() {
    const SchoolManagement = await hre.ethers.getContractFactory(
      "SchoolManagement"
    );

    const schoolManagement = await SchoolManagement.deploy();

    return { schoolManagement };
  }

  describe("Add Student", function () {
    it("should add a student successfully", async function () {
      const { schoolManagement } = await loadFixture(deploySchoolManagement);

      const studentName = "Felix David";
      const studentId = 1;
      const studentCourse = "Physics";
      const studentAge = 20;
      //   const StudentAddress =

      const schoolRegister = await schoolManagement.register_student(
        studentId,
        studentName
      );

      await schoolRegister.wait();

      const student = await schoolManagement.getStudent(studentId);
      expect(student.name).to.equal(studentName);
    });
  });

  describe("Get Student", function () {
    it("should retrieve a student's details", async function () {
      const { schoolManagement } = await loadFixture(deploySchoolManagement);

      const studentId = 1;
      const student = await schoolManagement.getStudent(studentId);

      expect(student.id).to.equal(studentId);
    });
  });

  describe("Remove Student", function () {
    it("should remove a student successfully", async function () {
      const { schoolManagement, admin } = await loadFixture(
        deploySchoolManagement
      );

      const studentId = 1;

      const tx = await schoolManagement.connect(admin).removeStudent(studentId);
      await tx.wait();

      await expect(schoolManagement.getStudent(studentId)).to.be.revertedWith(
        "Student does not exist"
      );
    });
  });
});
