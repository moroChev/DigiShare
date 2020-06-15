//const agencyService = require('../services/ServiceAgency');
class ControllerAgency{

    constructor(agencySvc){
        console.log('creating InStAnCe of ControllerAgency');
        this._agencyService = agencySvc;
    }


       async getAgenciesWithEmployees(req,res,next){
        console.log("get ALL agencies");
        let result;
        try{
            result = await this._agencyService.getAgenciesWithEmployees();
            if(result == undefined){
                res.status(404).json({result : undefined});
            }else{
                res.status(200).json(result);
            }
        }catch(err){
            res.status(500).json({error : err});
        }
    }

    //This action is designed to be used by the staff hwo will be in charge for getting the app initialized
    //will be modifies to implement multter
    async createAgency(req, res, next){
        console.log("create agency ... ");

        let agency = req.file  ? 
        {
            logo: `${req.protocol}://${req.get('host')}/logo/${req.file.filename}`,
            ...req.body
        }
        :
        {
            ...req.body
        };
        let result;
        try{
            result = await this._agencyService.createAgency(agency);
            res.status(201).json(result);
        }catch(err){
            res.status(500).json({error : err});
        }
    }

    async getAgencyById(req, res, next){
        console.log("get agency by Id : "+req.params.id);
        let result;
        try{
            result = await this._agencyService.getAgencyByIdWithEmployeesAndSubsidiaries(req.params.id);
            if(result == undefined){
                res.status(400).json({error : err});
            }else{
                console.log("result returned");
            res.status(200).json({message : "find agencie by id executed with success", agency: result});
            }
        }catch(err){
            res.status(500).json({error : err});
        }
    }

    async addLocationToAgency(req, res, next){
        console.log("lat "+req.body.lat+" lan "+req.body.lng);
        let result;
        let location = { lat: req.body.lat, lng: req.body.lng };
        let agencyId = req.param.id;
        try{
            result = await this._agencyService.addLocationToAgency(agencyId, location);
            if(result){
                res.status(201).json( agency );
            }else{
                res.status(400).json({error : err}); 
            }
        }catch(err){
            res.status(500).json({error : err});
        }
    }

}


module.exports = ControllerAgency;














































































// Should be implemented inside signup action
/* exports.addEmployeeToAgency = (req,res,next) =>{

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
}  */


//This action is designed to be used by the staff hwo will be in charge for getting the app initialized
//this action will be modified by later to specify how to get the required ids
/* exports.addSubsidiaryToAgency = (req,res,next) =>{

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
}  */