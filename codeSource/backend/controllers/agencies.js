const Agency   = require('../models/Agency'),
      Employee = require('../models/Employee');

exports.getAllAgencies = (req,res,next) => {

    console.log("get ALL agencies");
    Agency.find()
          .populate(
              {
                  path: 'employees',
                  model: 'Employee'
              }
          )
          .exec((err, agencies)=>{
              if(err){
                  res.status(400).json({error : err});
              }else{
                  res.status(200).json(agencies);
              }
          });
}

//This action is designed to be used by the staff hwo will be in charge for getting the app initialized
//will be modifies to implement multter
exports.createAgency = (req,res,next) => {

    console.log("create agency ... ");

    let agence = req.file  ? 
    {
        logo: `${req.protocol}://${req.get('host')}/logo/${req.file.filename}`,
        ...req.body
    }
    :
    {
        ...req.body
    };
    let agency = new Agency(
        {
            ...agence
        }
    );
    agency.save()
          .then((agency)=>{ res.status(201).json(agency); })
          .catch((err)=>{ res.status(500).json({error : err}); })
}

exports.getAgencyById = (req,res,next) => {

    console.log("get agency by Id : "+req.params.id);
    console.log(typeof 31.923799);

    Agency.findById(req.params.id)
          .populate(
                {
                    path: 'employees',
                    model: 'Employee'
                }
            )
          .populate(
                {
                    path: 'subsidiaries',
                    model: 'Agency'
                }
            )
          .exec((err, agency)=>{
                if(err){
                    res.status(400).json({error : err});
                }else{

                    console.log("result returned");
                    res.status(200).json({message : "find agencie by id executed with success", agency: agency});

                }
           });
          
}

// Should be implemented inside signup action
exports.addEmployeeToAgency = (req,res,next) =>{

    console.log("add employee :"+req.params.idEmployee+"to agency "+req.params.idAgency);

    Employee.findById(req.params.idEmployee)
           .then((employee) => {
               Agency.findByIdAndUpdate(req.params.idAgency,{ $push: { "employees": employee } },{ safe: true, new: true})
                     .then((agency) =>{
                         employee.agency = agency;
                         employee.save()
                                .then((employeeAfterAddingAgency) => { 
                                    console.log("had been added with success "+employeeAfterAddingAgency); 
                                    res.status(201).json( employeeAfterAddingAgency );
                                 } )
                                .catch((err)=>{ res.status(500).json({error : err}); })
                     }
                     )
                     .catch((err)=>{ res.status(500).json({error : err}); })
           }
           )
           .catch((err)=>{ res.status(500).json({error : err}); })
} 


//This action is designed to be used by the staff hwo will be in charge for getting the app initialized
//this action will be modified by later to specify how to get the required ids
exports.addSubsidiaryToAgency = (req,res,next) =>{

    console.log("add agency :"+req.params.idSubsidiary+" to agency "+req.params.idAgency);

    Agency.findById(req.params.idSubsidiary)
           .then((subsidiary) => {
                console.log(subsidiary);
               Agency.findByIdAndUpdate(req.params.idAgency,{ $push: { "subsidiaries": subsidiary } },{ safe: true, new: true})
                     .then((agency) =>{
                          console.log("had been added with success "+agency); 
                          res.status(201).json({ message: "operation executed with success", agency: agency });
                     }
                     )
                     .catch((err)=>{ res.status(500).json({error : err}); })
           }
           )
           .catch((err)=>{ res.status(400).json({error : err}); })
} 



exports.addLocationToAgency = (req,res,next)=>{

    console.log("lat "+req.body.lat+" lan "+req.body.lng);
    Agency.findByIdAndUpdate(req.params.id, { location: { lat: req.body.lat, lng: req.body.lng } },{ new: true })
        .then((agency)=>{
            res.status(201).json( agency );
        })
        .catch((err)=>{ res.status(400).json({error : err}); })
}

