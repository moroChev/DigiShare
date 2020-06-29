const IEmployeeRepository = require("./iEmployeRepository"),
        Employee          = require('../../models/Employee'),
        util              = require('util');

class EmployeeRepositoryMongoDb extends IEmployeeRepository{

    constructor(){
        super();
    }

    async findByLoginWithAgency(login){
        try {
            let employee = await Employee.findOne({'userAccount.login': login}).populate('agency');
            return employee;
        } catch (error) {
            throw(error);
        }
    }

    async findAllWithAgency(){
        console.log('in finding ALL employees');
        try {
            let employee = await Employee.find().populate('agency').sort({'firstName': 'asc', 'lastName': 'asc'});
            return employee;
        } catch (error) {
            console.log('error in finding all employees');
            throw(error);
        }
    }

    async create(employee){
        try {
            let newEmployee= await Employee.create(employee);
            return newEmployee;
        } catch (error) {
            throw(error);
        }
    }

    async findById(id){
        console.log('in finding employee by id');
        try {
            let employee = await Employee.findById(id);
            return employee;
        } catch (error) {
            console.log('error in finding employee by id');
            throw(error);
        }

    }

   async findByIdWithPublications_And_Agency(id){
    try {
        let employee = await Employee.findById(id)
                                     .populate([
                                                {
                                                    path: 'publications',
                                                    model: 'Publication'
                                                },{
                                                    path: 'agency',
                                                    model: 'Agency'
                                                }
                                            ]);
        return employee;
    } catch (error) {
        throw(error);
    }
   } 

   async findByIdWithPublications(id){
        try {
            let employee = await Employee.findById(id).populate('publications');                              
            return employee;
        } catch (error) {
            throw(error);
        }
    }

    async findById_And_Pull(id,object){
        try {
            console.log("pull to employee id : "+id+" and pull + "+util.inspect(object));     
            let employee = await Employee.findByIdAndUpdate(id,{ $pull : object },{ safe: true, new: true});
            console.log(employee);
            return employee;
        } catch (error) {
            console.log('errror in pull to employee');
            throw(error);
        }
    }

    async findById_And_Set(id,object){
        try {
            console.log("set to employee id : "+id+" and set "+object);
            let employee = await Employee.findByIdAndUpdate(id, { $set : object },{ safe: true, new: true});
            return employee;    
        } catch (error) {
            console.log("erro in set to employee id : "+id+" and set "+object);
            throw(error);
        }
    }

    async findById_And_AddToSet(id, object){
       try {
            console.log("addToSet to employee id : "+id+" and addToSet + "+object);
            let employee = await Employee.findByIdAndUpdate(id,{ $addToSet : object },{ safe: true, new: true});
            return employee;
        } catch (error) {
            console.log('errror in addToSet to employee');
            throw(error);
        }
    }

    async search(string){
        try {
            let employee = await Employee.find({ $text: { $search: string }}).populate('agency');
            return employee;
        } catch (error) {
            throw(error);
        }
    }


    
}

module.exports = EmployeeRepositoryMongoDb;