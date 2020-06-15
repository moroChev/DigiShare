const express                = require('express'),
      auth                   = require('../middleware/auth'),
      multer                 = require('../middleware/multer_config');
      path                   = require('path'),
      nodeID                 = require('node-dependency-injection');

const agencyRepositoryMongo = require('../repositories/Agencies/RepositoryAgencyMongoDb'),
      agencyService       = require('../services/ServiceAgency'),
      agencyController    = require('../controllers/agencies') ;
const ControllerAgency = require('../controllers/agencies');
const ServiceAgency = require('../services/ServiceAgency');
const RespositoryAgencyMongoDb = require('../repositories/Agencies/RepositoryAgencyMongoDb');


let router = express.Router();


//route to get agencies logos
//router.use('/logo', express.static(path.join(__dirname, '../images/agenciesLogos')));

//usual routes
//router.get("/", agencyControllerM.getAgenciesWithEmployees);

















//router.get("/:id",auth, agencyControllerM.getAgencyById(req,res,next));

//those routes will be modified later to add access restrictions
//to allow only the staff in charge of getting the database initialized 

//router.post("/", multer.multerAgencies, agencyControllerM.createAgency(req,res,next));

//router.post("/:idAgency/addSubsidiary_id::idSubsidiary",auth, agencyController.addSubsidiaryToAgency);

//No need for this because it will be implemented inside signup
//add an employee to an agency

//router.post("/:idAgency/addEmployee_id::idEmployee", auth,agencyController.addEmployeeToAgency);
//router.post("/:id/addLocationToAgency", auth, agencyController.addLocationToAgency(req,res,next));


module.exports.default = router;