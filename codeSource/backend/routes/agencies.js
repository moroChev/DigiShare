const express                = require('express'),
      agencyController       = require('../controllers/agencies'),
<<<<<<< HEAD
      auth                   = require('../middleware/auth'),
      multer                 = require('../middleware/multer_config');
=======
      auth                   = require('../middleware/auth');
      path                	 = require('path');
<<<<<<< HEAD
>>>>>>> 14408f049cd5211074339b175c8cd34d8b7f5d85
=======
>>>>>>> c49bb10ed707052ac9aed3e19b2d7cd9e93dfe46

let router = express.Router();

//route to get agencies logos
router.use('/logo', auth, express.static(path.join(__dirname, '../images/agenciesLogos')));

//usual routes
router.get("/", auth, agencyController.getAllAgencies);
router.get("/:id", auth, agencyController.getAgencyById);

//those routes will be modified later to add access restrictions
//to allow only the staff in charge of getting the database initialized 
<<<<<<< HEAD
router.post("/", multer, agencyController.createAgency);
=======
router.post("/", auth, agencyController.createAgency);
>>>>>>> c49bb10ed707052ac9aed3e19b2d7cd9e93dfe46
router.post("/:idAgency/addSubsidiary_id::idSubsidiary",auth, agencyController.addSubsidiaryToAgency);

//No need for this because it will be implemented inside signup
//add an employee to an agency
<<<<<<< HEAD
router.post("/:idAgency/addEmployee_id::idEmployee", auth,agencyController.addEmployeeToAgency);
router.post("/:id/addLocationToAgency", auth, agencyController.addLocationToAgency);
=======
router.post("/:idAgency/addEmployee_id::idEmployee", agencyController.addEmployeeToAgency);
>>>>>>> c49bb10ed707052ac9aed3e19b2d7cd9e93dfe46

module.exports = router;