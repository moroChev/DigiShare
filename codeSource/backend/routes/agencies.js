const express                = require('express'),
      auth                   = require('../middleware/auth'),
      multer                 = require('../middleware/multer_config');
      path                   = require('path');

const AgencyRepositoryMongo = require('../repositories/Agencies/agencyRepositoryMongoDb'),
      AgencyService       = require('../services/agencyService'),
      AgencyController    = require('../controllers/agencies') ;


//Dependencies injection ( no need for that )
let router = express.Router();
let agencyRepo = new AgencyRepositoryMongo();
let agencySvc = new AgencyService(agencyRepo);
let agencyController = new AgencyController(agencySvc);


//route to get agencies logos
router.use('/logo', auth, express.static(path.join(__dirname, '../images/agenciesLogos')));

//usual routes
router.get("/", auth, (req,res,next) => agencyController.getAllAgencies(req,res,next));
router.get("/:id", auth, (req,res,next) => agencyController.getAgencyById(req,res,next));

//those routes will be modified later to add access restrictions
//to allow only the staff in charge of getting the database initialized 

router.post("/", auth, multer.multerAgencies, (req,res,next) => agencyController.createAgency(req,res,next));

router.post("/:idCompany/addSubsidiary_id::idAgency", auth, (req,res,next) => agencyController.addAgencyToCompany(req,res,next));

//No need for this because it will be implemented inside signup
//add an employee to an agency

router.post("/:idAgency/addEmployee_id::idEmployee", auth, (req,res,next) => agencyController.addEmployeeToAgency(req, res, next));
router.post("/:id/addLocationToAgency", auth, (req,res,next) => agencyController.addLocationToAgency(req,res,next));


module.exports = router;