const Employee = require('../models/Employee');

exports.createEmployee = (req, res, next) => {

    console.log("create employee");
    delete req.body.id;
    let employee = new Employee(
        {
            ...req.body
       }
    );
    employee.save()
            .then((emp) => {
                     console.log(emp);
                     res.status(201).json( { message : " creation with success " } );
             })
            .catch((err) => { res.status(400).json({ error: err }) });

}

exports.getAllEmployees = (req, res, next) => {

    console.log("get all employees");
    Employee.find()
           .populate([
                {
                    path: 'publications',
                    model: 'Publication'
                },{
                    path: 'agency',
                    model: 'Agency'
                }
           ]
           )
           .exec((err, employees)=>{
               if(err){
                   res.status(500).json({ error: err});
               }else{
                res.status(201).json({ message: "findAll with success", employee: employees });
               }
           });

}

exports.getEmployeeById = (req,res,next) => {

    console.log("get emplyee by id");
    Employee.findById(req.params.id)
           .populate(
                [
                    {
                        path: 'publications',
                        model: 'Publication'
                    },{
                        path: 'agency',
                        model: 'Agency'
                    }
            ]
            )
            .exec((err, employee)=>{
                if(err){
                    res.status(500).json({ error: err});
                }else{
                    res.status(201).json({ message: "findbyId has been executed with success", employee: employee });
                }
            });


}

exports.getEmployeeByFullName = (req,res,next) => {
    console.log("get employee by fullName");

    // to make the search case insensitive
    let fullName = req.params.fullName.split(" ");
    let firstName = new RegExp(`^${fullName[0]}$`, 'i');
    let lastName = new RegExp(`^${fullName[1]}$`, 'i');
    console.log(firstName+"--"+lastName);

    // still to verify which name (first or last) is provided and make a search based on that 

    Employee.findOne({firstName: firstName, lastName: lastName })
           .populate(
                [
                    {
                        path: 'publications',
                        model: 'Publication'
                    },{
                        path: 'agency',
                        model: 'Agency'
                    }
            ]
            )
           .exec((err, employee)=>{
                if(err){
                    res.status(500).json({ error: err});
                }else{
                    res.status(201).json({ message: "findByName has been executed with success", employee: employee });
                }
            });
           
}