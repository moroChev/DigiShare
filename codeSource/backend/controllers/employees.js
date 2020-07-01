const util        = require('util'),
      digiUtil    = require('../utility/globalUtil');


class EmployeeController{
    constructor(employeeService){
        this._employeeService=employeeService;
    }

    createEmployee = async (req,res,next)=>{
        try {
            let employee = await digiUtil.employeeObjectFromRequest(req);
            let newEmployee = this._employeeService.createEmployee(employee);
            res.status(201).json(newEmployee);
        } catch (error) {
            res.status(500).json(error);
        }
    }

    ///Ok
    getAllEmployees = async (req,res,next)=>{
        try {
            let employees = await this._employeeService.getAllEmployeesWithAgency();
            res.status(200).json(employees);
        } catch (error) {
            res.status(500).json(error);
        }
    }

    ///Ok
    getEmployeeById = async (req,res,next)=>{
        try {
            let employee = await this._employeeService.getEmployeeById(req.params.id);
            res.status(200).json(employee);
        } catch (error) {
            res.status(500).json(error);
        }
    }

    ///Ok
    getEmployeePublications = async (req,res,next)=>{
        try {
            let employee = await this._employeeService.getEmployeePublications(req.params.id);
            res.status(200).json(employee);
        } catch (error) {
            res.status(500).json(error);
        }
    }


    modifyEmployee = async (req,res,next)=>{}

    ///Ok
    searchEmployee = async (req,res,next)=>{
        try {
            console.log(util.inspect(req.body.firstName));
            let employee = await this._employeeService.searchEmployee(req.body.firstName);
            res.status(200).json(employee);
        } catch (error) {
            res.status(500).json(error);
        }
    }



}    

module.exports = EmployeeController;
