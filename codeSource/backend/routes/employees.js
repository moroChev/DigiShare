const express                = require('express'),
      employeeController     = require('../controllers/employees.js'),
      auth                   = require('../middleware/auth');

let router = express.Router();


router.get("/rechercher/:fullName",auth, employeeController.getEmployeByFullName);
router.get("/", auth,employeeController.getAllEmployees);
router.post("/", auth, employeeController.createEmploye);
router.get("/:id",  auth,employeeController.getEmployeById);
router.get("/:id/Publications", auth,employeeController.getEmployePublications);



module.exports = router;