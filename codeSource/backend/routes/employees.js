const express                = require('express'),
      employeeController     = require('../controllers/employees.js'),
      auth                   = require('../middleware/auth');

let router = express.Router();


router.get("/rechercher/:fullName",auth, employeeController.getEmployeeByFullName);
router.get("/", auth, employeeController.getAllEmployees);
router.post("/", auth, employeeController.createEmployee);
router.get("/:id", auth, employeeController.getEmployeeById);


module.exports = router;