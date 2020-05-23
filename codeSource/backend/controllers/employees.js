const Employe = require('../models/Employe');

exports.createEmploye = (req, res, next) => {

    console.log("create employe");
    delete req.body.id;
    let employee = new Employe(
        {
            ...req.body
       }
    );
    employee.save()
            .then((employe) => {
                     console.log(employe);
                     res.status(201).json( { message : " creation with success " } );
             })
            .catch((err) => { res.status(400).json({ error: err }) });

}

exports.getAllEmployees = (req, res, next) => {

    console.log("get all employees");
    Employe.find()
           .populate(
            {
                path: 'publications',
                model: 'Publication'
            }
           )
           .exec((err, employees)=>{
               if(err){
                   res.status(500).json({ error: err});
               }else{
                res.status(201).json({ message: "findAll with success", employee: employees });
               }
           });

}

exports.getEmployeById = (req,res,next) => {
    console.log("get emplyee by id");
    Employe.findById(req.params.id)
           .populate(
                {
                    path: 'publications',
                    model: 'Publication'
                }
            )
            .exec((err, employees)=>{
                if(err){
                    res.status(500).json({ error: err});
                }else{
                    res.status(201).json({ message: "findbyId has been executed with success", employee: employees });
                }
            });


}