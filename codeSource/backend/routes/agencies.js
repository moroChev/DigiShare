const express                = require('express'),
      agencyController       = require('../controllers/agencies'),
      auth                   = require('../middleware/auth'),
      multer                 = require('../middleware/multer_config');
      path                   = require('path');


let router = express.Router();

//route to get agencies logos
router.use('/logo', express.static(path.join(__dirname, '../images/agenciesLogos')));

//usual routes
router.get("/", auth, agencyController.getAllAgencies);
router.get("/:id",auth, agencyController.getAgencyById);

//those routes will be modified later to add access restrictions
//to allow only the staff in charge of getting the database initialized 

router.post("/", multer.multerAgencies, agencyController.createAgency);

router.post("/:idAgency/addSubsidiary_id::idSubsidiary",auth, agencyController.addSubsidiaryToAgency);

//No need for this because it will be implemented inside signup
//add an employee to an agency

router.post("/:idAgency/addEmployee_id::idEmployee", auth,agencyController.addEmployeeToAgency);
router.post("/:id/addLocationToAgency", auth, agencyController.addLocationToAgency);


module.exports = router;