const express                = require('express'),
      employeeController     = require('../controllers/employees.js'),
      auth                   = require('../middleware/auth');

let router = express.Router();


router.get("/rechercher/:fullName",auth, employeeController.getEmployeByFullName);
router.get("/", employeeController.getAllEmployees);
router.post("/", auth, employeeController.createEmploye);
router.get("/:id",  employeeController.getEmployeById);
router.get("/:id/Publications", employeeController.getEmployePublications);


module.exports = router;