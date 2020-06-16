class EmployeeService{

    constructor(employeeRepos){
        this._employeeRepo = employeeRepos;
    }

    async createEmployee(employee){
        try {
            let newEmployee = await this._employeeRepo.create(employee);
            return newEmployee;
        } catch (error) {
            throw(error);
        }
    }

    async getAllEmployeesWithAgency(){
        try {
            let employees = await this._employeeRepo.findAllWithAgency();
            return employees;
        } catch (error) {
            throw(error);
        }
    }

   async getEmployeeById(id){
        try {
            let employee = await this._employeeRepo.findByIdWithPublications_And_Agency(id);
            return employee;
        } catch (error) {
            throw(error);
        }
    }
    
    async getEmployeePublications(id){
        try {
            let employee = await this._employeeRepo.findByIdWithPublications(id);
            return employee;
        } catch (error) {
            throw(error);
        }
    }

    async modifyEmployee(id,employee){}


    async searchEmployee(string){
        try {
            console.log(string);
            let emp = await this._employeeRepo.search(string);
            return emp;
        } catch (error) {
            throw(error);
        }
    }

}

module.exports = EmployeeService;