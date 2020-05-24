const Agency  = require('../models/Agency'),
      Employe = require('../models/Employe');

exports.getAllAgencies = (req,res,next) => {

    console.log("get ALL agencies");
    Agency.find()
          .populate(
              {
                  path: 'emplyees',
                  model: 'Employe'
              }
          )
          .exec((err, agencies)=>{
              if(err){
                  res.status(400).json({error : err});
              }else{
                  res.status(200).json({message : "findAll agencies executed with success", agencies: agencies});
              }
          });
}

exports.createAgency = (req,res,next) => {

    console.log("create agency");

    let agency = new Agency(
        {
            ...req.body
        }
    );
    agency.save()
          .then((agency)=>{ res.status(201).json({message: "agency created with success", agency: agency}); })
          .catch((err)=>{ res.status(500).json({error : err}); })
}

exports.getAgencyById = (req,res,next) => {

    console.log("get agency by Id : "+req.params.id);

    Agency.findById(req.params.id)
          .populate(
                {
                    path: 'emplyees',
                    model: 'Employe'
                }
            )
          .exec((err, agencies)=>{
                if(err){
                    res.status(400).json({error : err});
                }else{
                    res.status(200).json({message : "findAll agencies executed with success", agencies: agencies});
                }
           });
          
}


exports.addEmployeToAgency = (req,res,next) =>{

    console.log("add employe :"+req.params.idEmploye+"to agency "+req.params.idAgency);

    Employe.findById(req.params.idEmploye)
           .then((employe) => {
               Agency.findByIdAndUpdate(req.params.idAgency,{ $push: { employees: employe } },{ safe: true, new: true})
                     .then((agency) =>{
                         employe.agency = agency;
                         employe.save()
                                .then((employeeAfterAddingAgency) => { 
                                    console.log("had been added with success "+employeeAfterAddingAgency); 
                                    res.status(201).json({ message: "operation exucted with success", employe: employeeAfterAddingAgency });
                                 } )
                                .catch((err)=>{ res.status(500).json({error : err}); })
                     }
                     )
                     .catch((err)=>{ res.status(500).json({error : err}); })
           }
           )
           .catch((err)=>{ res.status(500).json({error : err}); })
} 