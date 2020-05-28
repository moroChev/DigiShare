const express                = require('express'),
      agencyController       = require('../controllers/agencies'),
      auth                   = require('../middleware/auth');

let router = express.Router();

router.get("/", auth, agencyController.getAllAgencies);
router.post("/", auth, agencyController.createAgency);
router.get("/:id", auth, agencyController.getAgencyById);

//add an employee to an agency
router.post("/:idAgency/addEmployee/:idEmploye", agencyController.addEmployeToAgency);

module.exports = router;