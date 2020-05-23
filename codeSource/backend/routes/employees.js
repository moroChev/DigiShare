const express                = require('express'),
      employeeController     = require('../controllers/employees.js');


let router = express.Router();


router.get("/", employeeController.getAllEmployees);
router.post("/", employeeController.createEmploye);
router.get("/:id", employeeController.getEmployeById);


module.exports = router;