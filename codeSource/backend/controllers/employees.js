
const Employee    = require('../models/Employee'),
      Publication = require('../models/Publication');


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
                     res.status(201).json( emp );
             })
            .catch((err) => { res.status(400).json({ error: err }) });

};

exports.getAllEmployees = (req, res, next) => {

    console.log("get all employees");
    Employee.find()
           .populate(
               {

                    path: 'agency',
                    model: 'Agency'
                }
           )
           .exec((err, employees)=>{
               if(err){
                   res.status(500).json({ error: err});
               }else{
                res.status(201).json( employees );
               }
           });

};

exports.getEmployeeById = (req,res,next) => {

    console.log("get emplyee by id "+req.params.id);
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
                    console.log('error + '+err)
                    res.status(500).json({ error: err});
                }else{

                    console.log('employee + '+employee);
                    res.status(200).json(employee);

                }
            });


};

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
                    res.status(201).json(employee);

                }
            });
           
};

exports.modifyEmployee = (req,res,next)=>{
    
    console.log("modify just called");
    let emp = req.file ?  {

                 imageUrl: `${req.protocol}://${req.get('host')}/images/${req.file.filename}`,
                ...req.body
             }
        :
             {
                 ...req.body
             };
    Employee.findByIdAndUpdate(req.params.id, {...emp, _id: req.params.id},{upsert:true, new: true})
            .then((employee)=>{res.status(201).json(employee);})
            .catch((err)=>{res.status(500).json(err);});

};


exports.getEmployeePublications = (req,res,next) =>{
    
    console.log("get employee's publications");
    Publication.find({postedBy: req.params.id})
               .populate([
                   {
                       path:'postedBy',
                       model: 'Employee'
                   },
                   {
                       path: 'approvedBy',
                       model: 'Employee'
                   }
               ])
               .exec((err,publications)=>{
                   if(err){
                    res.status(500).json({ error: err});
                }else{
                    res.status(201).json(publications);
                   }
               });
}