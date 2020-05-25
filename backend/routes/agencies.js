const express                = require('express'),
      agencyController       = require('../controllers/agencies');

let router = express.Router();

router.get("/",agencyController.getAllAgencies);
router.post("/",agencyController.createAgency);
router.get("/:id", agencyController.getAgencyById);

//add an employee to an agency
router.post("/:idAgency/addEmployee/:idEmploye", agencyController.addEmployeToAgency);

module.exports = router;