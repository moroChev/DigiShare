const express                = require('express'),
      agencyController       = require('../controllers/agencies'),
      auth                   = require('../middleware/auth');

let router = express.Router();

router.get("/", auth, agencyController.getAllAgencies);
router.get("/:id", auth, agencyController.getAgencyById);

//those routes will be modified later to add access restrictions
//to allow only the staff in charge of getting the database initialized 
router.post("/", auth, agencyController.createAgency);
router.post("/:idAgency/addSubsidiary_id::idSubsidiary",auth, agencyController.addSubsidiaryToAgency);

//No need for this because it will be implemented inside signup
//add an employee to an agency
router.post("/:idAgency/addEmployee_id::idEmployee", agencyController.addEmployeeToAgency);

module.exports = router;