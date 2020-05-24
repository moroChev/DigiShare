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

exports.getEmployeById = (req,res,next) => {

    console.log("get emplyee by id");
    Employe.findById(req.params.id)
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
            .exec((err, employe)=>{
                if(err){
                    res.status(500).json({ error: err});
                }else{
                    res.status(201).json({ message: "findbyId has been executed with success", employee: employe });
                }
            });


}

exports.getEmployeByFullName = (req,res,next) => {
    console.log("get employee by fullName");

    // to make the search case insensitive
    let fullName = req.params.fullName.split(" ");
    let firstName = new RegExp(`^${fullName[0]}$`, 'i');
    let lastName = new RegExp(`^${fullName[1]}$`, 'i');
    console.log(firstName+"--"+lastName);

    // still to verify which name (first or last) is provided and make a search based on that 

    Employe.findOne({firstName: firstName, lastName: lastName })
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
           .exec((err, employe)=>{
                if(err){
                    res.status(500).json({ error: err});
                }else{
                    res.status(201).json({ message: "findByName has been executed with success", employee: employe });
                }
            });
           
}